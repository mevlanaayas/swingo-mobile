import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:swingo/app_config.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/components/sw_dialog.dart';
import 'package:swingo/src/models/chat_room.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/services/bid.dart';
import 'package:swingo/src/services/chat.dart';
import 'package:swingo/src/theme/decoration.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/utils/constans.dart';
import 'package:swingo/src/utils/sliders.dart';

import '../pages.dart';
import 'base.dart';

class Chat extends StatelessWidget {
  final ChatRoom chatRoom;
  final String username;

  Chat({this.chatRoom, this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage('assets/images/chat-background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ChatPage(
          chatRoom: this.chatRoom,
          username: this.username,
        ),
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  final ChatRoom chatRoom;
  final String username;

  List<Message> toPrint = [];

  ChatPage({this.chatRoom, this.username});

  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _controller = TextEditingController();
  SocketIOManager manager;
  SocketIO socket;
  String bidStatus;
  bool isUserCarrier = false;

  @override
  void initState() {
    super.initState();
    manager = SocketIOManager();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _getBid(context);
      initSocket();
      _listMessages(context);
    });
  }

  initSocket() async {
    final String chatUrl = AppConfig.of(context).chatUrl;
    socket = await manager.createInstance(chatUrl);
    socket.onConnect((data) {
      joinRoom();
    });
    /*
    socket.onConnectError((data) => print(data));
    socket.onConnectTimeout((data) => print(data));
    socket.onError((data) => print(data));
    socket.onDisconnect((data) => print(data));
     */
    socket.on("SEND_MESSAGE", (data) {
      pprint(data);
    });
    socket.connect();
  }

  joinRoom() {
    socket.emit("JOIN_ROOM", [
      {"username": widget.username, "roomId": widget.chatRoom.id}
    ]);
  }

  disconnect() async {
    await manager.clearInstance(socket);
  }

  disconnectRoom() {
    socket.emit("LEAVE_ROOM", [
      {"username": widget.username, "roomId": widget.chatRoom.id}
    ]);
  }

  @override
  void dispose() {
    disconnectRoom();
    disconnect();
    super.dispose();
  }

  sendMessage() {
    if (socket != null) {
      if (_controller.text != null && _controller.text != "") {
        socket.emit("SEND_MESSAGE", [
          {
            "username": widget.username,
            "message": _controller.text,
            "roomId": widget.chatRoom.id
          }
        ]);
      }
      _controller.clear();
    }
  }

  pprint(data) {
    setState(() {
      print(data);
      widget.toPrint.insert(
          0,
          Message(
              id: data['_id'],
              message: data['message'],
              roomId: data['roomId'],
              createdBy: data['createdBy'],
              createdAt: DateTime.parse(data['createdAt'])));
    });
  }

  Widget _buildMessageBox(String message, Color color, Alignment alignment) {
    double screenWidth =
        MediaQuery.of(context).size.width; //TODO: Bu bir yerde saklanılabilir.
    double maximumMessageSize = screenWidth / 100 * 75;

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.all(2.0),
        padding: const EdgeInsets.all(8),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(Radius.circular(10)),
          color: color,
        ),
        constraints: BoxConstraints(
          maxWidth: maximumMessageSize,
        ),
        child: Text(
          message,
          style: messageWhiteTextStyle,
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    Message message = widget.toPrint[index];
    Widget messageRow;
    if (widget.username == message.createdBy) {
      messageRow = _buildMessageBox(
          message.message, primaryColor, Alignment.centerRight);
    } else {
      messageRow = _buildMessageBox(
          message.message, secondaryColor, Alignment.centerLeft);
    }
    return messageRow;
  }

  void _listMessages(BuildContext context) async {
    ChatService.listMessages(
      context,
      onSuccess: _onRequestSuccess(context),
      chatRoomId: widget.chatRoom.id,
    );
  }

  _onRequestSuccess(BuildContext context) {
    return (responseData) async {
      final messageArray = responseData['messages'];
      setState(() {
        widget.toPrint = messageArray != null
            ? List<Message>.from(messageArray
                .map((messageJson) => Message.fromJson(messageJson)))
            : [];
      });
    };
  }

  _getBid(BuildContext context) {
    BidService.get(
      context,
      bidId: widget.chatRoom.bidId,
      onSuccess: _onGetBidRequestSuccess(context),
    );
  }

  _onGetBidRequestSuccess(BuildContext context) {
    return (responseData) {
      final userProvider = Provider.of<UserStatus>(context);
      setState(() {
        //TODO: status değerine göre kontrol edip state'i değiştirmek daha sağlıklı olabilir.
        bidStatus = responseData['status'];
        if (responseData['transceiver'] != null) {
          isUserCarrier = responseData['transceiver']['created_by'] !=
              userProvider.currentUser.username;
        } else if (responseData['transporter'] != null) {
          isUserCarrier = responseData['transporter']['created_by'] ==
              userProvider.currentUser.username;
        }
      });
    };
  }

  Widget _buildStatusText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        color: secondaryColor,
        fontSize: 22,
      ),
    );
  }

  Widget _buildStatusActionButton(IconData iconData, onPressed) {
    return IconButton(
      alignment: Alignment.center,
      icon: Icon(iconData),
      onPressed: onPressed,
    );
  }

  _onBidStatusChanged(BuildContext context) {
    return (responseData) {
      _getBid(context);
    };
  }

  Widget _buildStatusBar() {
    List<Widget> row = [];
    int bidId = widget.chatRoom.bidId;
    dynamic onAcceptTap;
    dynamic onRejectTap = () {
      BidService.reject(
        context,
        bidId: bidId,
        onSuccess: _onBidStatusChanged(context),
      );
    };
    Widget initialText = Text(
      "Next step: ",
      style: TextStyle(
        fontStyle: FontStyle.italic,
        color: primaryColor,
        fontSize: 15,
      ),
    );

    print(this.bidStatus);
    //TODO: karşı taraf onayladığında bunu aygılayabilmemiz gerek.
    if (this.bidStatus == BID_STATUSES["CONSERVATION"]) {
      if (this.isUserCarrier) {
        onAcceptTap = () {
          BidService.accept(
            context,
            bidId: bidId,
            onSuccess: _onBidStatusChanged(context),
          );
        };
      } else {
        onAcceptTap = () {
          return showDialog(
            context: context,
            builder: (BuildContext newContext) => SwDialog(
                  isDismissButtonActive: true,
                  dismissButtonText: 'Okey',
                  contentText: 'You should wait sender to accept.',
                ),
          );
        };
      }
      row = [
        _buildStatusText("Dealing"),
        _buildStatusActionButton(FontAwesomeIcons.check, onAcceptTap),
        _buildStatusActionButton(FontAwesomeIcons.times, onRejectTap),
      ];
    } else if (this.bidStatus == BID_STATUSES["APPROVED_BY_CARRIER"]) {
      if (this.isUserCarrier) {
        row = [
          _buildStatusText("Waiting Sender To Approve"),
        ];
      } else {
        onAcceptTap = () {
          BidService.accept(
            context,
            bidId: bidId,
            onSuccess: _onBidStatusChanged(context),
          );
        };
        row = [
          _buildStatusText("Dealing"),
          _buildStatusActionButton(FontAwesomeIcons.check, onAcceptTap),
          _buildStatusActionButton(FontAwesomeIcons.times, onRejectTap),
        ];
      }
    } else if (this.bidStatus == BID_STATUSES["APPROVED"]) {
      onAcceptTap = (){
        Navigator.push(
          context,
          SlideLeftRoute(
            page: BaseProfile(
              child: CheckpointScreen(match:null), //TODO: match i almamız gerekiyor.
              type: "Track you deal",
            ),
          ),
        );
      };
      row = [
        _buildStatusText("Go To Checkpoint Now!"),
        _buildStatusActionButton(FontAwesomeIcons.arrowRight, onAcceptTap),
      ];
    } else if (this.bidStatus == BID_STATUSES["REJECTED"]) {
      row = [
        _buildStatusText("Rejected"),
      ];
    }

    if (row.length > 0) {
      row.insert(0, initialText);
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: MediaQuery.of(context).size.height / 12,
        padding: EdgeInsets.only(left: 10.0),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
          color: Color(0x88AAAAAA),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: row,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _buildStatusBar(),
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: widget.toPrint.length,
              itemBuilder: _buildListItem,
            ),
          ),
          TextField(
            style: whiteTextStyle,
            cursorColor: primaryColor,
            decoration: SmallFormFieldDecoration(
              null,
              null,
              null,
              IconButton(
                  color: primaryColor,
                  icon: const Icon(FontAwesomeIcons.paperPlane),
                  onPressed: sendMessage),
            ),
            controller: _controller,
          ),
        ],
      ),
    );
  }
}
