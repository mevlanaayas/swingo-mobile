import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/app_config.dart';
import 'package:swingo/src/classes/SwScreen.dart';
import 'package:swingo/src/components/sw_dialog.dart';
import 'package:swingo/src/models/chat_room.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/services/chat.dart';
import 'package:swingo/src/services/match.dart';
import 'package:swingo/src/theme/decoration.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/utils/constans.dart';

class Chat extends StatelessWidget with SwScreen {
  final ChatRoom chatRoom;
  final String username;
  final String chattedUsername;
  final String status;
  final String userType;
  final int matchId;

  Chat(
      {this.chatRoom,
      this.username,
      this.status,
      this.userType,
      this.matchId,
      this.chattedUsername});

  Widget _buildTitle() {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              this.chattedUsername,
              style: messageBlackTextStyle,
            ),
            Text(
              'Please click to see details.',
              style: blackTextStyle,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor50,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: this.buildAppbar(
          context,
          titleWidget: _buildTitle(),
        ),
        body: ChatPage(
          chatRoom: this.chatRoom,
          username: this.username,
          status: this.status,
          userType: this.userType,
          matchId: this.matchId,
        ),
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  final ChatRoom chatRoom;
  final String username;
  final String status;
  final String userType;
  final int matchId;

  List<Message> toPrint = [];

  ChatPage(
      {this.chatRoom, this.username, this.status, this.userType, this.matchId});

  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with SwScreen {
  TextEditingController _controller = TextEditingController();
  SocketIOManager manager;
  SocketIO socket;
  int matchId = 4; //TODO: dışarıdan alınması gerek
  TextEditingController _confirmTakingCodeTextEditingController =
      new TextEditingController();
  TextEditingController _confirmDeliveryCodeTextEditingController =
      new TextEditingController();

  @override
  void initState() {
    super.initState();
    manager = SocketIOManager();
    SchedulerBinding.instance.addPostFrameCallback((_) {
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
        widget.toPrint = widget.toPrint.reversed.toList();
      });
    };
  }

  Widget _buildStatusText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        color: Colors.white,
        fontSize: 22,
      ),
    );
  }

  Widget _buildStatusActionButton(IconData iconData, onPressed) {
    return IconButton(
      alignment: Alignment.center,
      icon: Icon(
        iconData,
        color: secondaryColor,
      ),
      onPressed: onPressed,
    );
  }

  _onAcceptSuccess(BuildContext context) {
    return (responseData) {
      print(responseData);
    };
  }

  _accept(BuildContext context) => () => MatchService.accept(context,
      matchId: widget.matchId, onSuccess: _onAcceptSuccess(context));

  _reject(BuildContext context) => () => MatchService.reject(context,
      matchId: widget.matchId, onSuccess: _onAcceptSuccess(context));

  _passPayment(BuildContext context) => () => MatchService.passPayment(context,
      matchId: widget.matchId, onSuccess: _onAcceptSuccess(context));

  _checkBoxDone(BuildContext context) =>
      () => MatchService.checkBoxDone(context,
          matchId: widget.matchId, onSuccess: _onAcceptSuccess(context));

  _checkBoxFail(BuildContext context) =>
      () => MatchService.checkBoxFail(context,
          matchId: widget.matchId, onSuccess: _onAcceptSuccess(context));

  _readyForTakingBox(BuildContext context) =>
      () => MatchService.readyForTakingBox(context,
          matchId: widget.matchId, onSuccess: _onAcceptSuccess(context));

  _confirmTakingCodeRequest(BuildContext context) => (dialogContext) {
        Navigator.of(dialogContext).pop();
        MatchService.confirmTakingCode(context,
            code: _confirmTakingCodeTextEditingController.text,
            matchId: widget.matchId,
            onSuccess: _onAcceptSuccess(context));
      };

  _confirmTakingCode(BuildContext context) => () => showDialog(
        context: context,
        builder: (BuildContext newContext) {
          return SwDialog(
            isDismissButtonActive: true,
            isAcceptButtonActive: true,
            dismissButtonText: 'Cancel',
            acceptButtonText: 'Accept',
            contentText:
                'You need to enter code which is given by sender to verify receiving packet.',
            onAcceptTap: _confirmTakingCodeRequest(context),
            isInputFieldActive: true,
            textEditingController: _confirmTakingCodeTextEditingController,
          );
        },
      );

  _readyForDeliveringBox(BuildContext context) =>
      () => MatchService.readyForDeliveringBox(context,
          matchId: widget.matchId, onSuccess: _onAcceptSuccess(context));

  _confirmConfirmationCodeRequest(BuildContext context) => (dialogContext) {
        Navigator.of(dialogContext).pop();
        MatchService.confirmDeliveryCode(context,
            code: _confirmDeliveryCodeTextEditingController.text,
            matchId: widget.matchId,
            onSuccess: _onAcceptSuccess(context));
      };

  _confirmConfirmationCode(BuildContext context) => () => showDialog(
        context: context,
        builder: (BuildContext newContext) {
          return SwDialog(
            isDismissButtonActive: true,
            isAcceptButtonActive: true,
            dismissButtonText: 'Cancel',
            acceptButtonText: 'Accept',
            contentText:
                'You need to enter code which is given by sender to complete.',
            onAcceptTap: _confirmConfirmationCodeRequest(context),
            isInputFieldActive: true,
            textEditingController: _confirmDeliveryCodeTextEditingController,
          );
        },
      );

  Widget _buildStatusBar(BuildContext context) {
    print("***");
    print(widget.status);
    print(widget.userType);
    print(widget.matchId);
    List<Widget> row = [
      _buildStatusText(widget.status),
    ];
    double screenWidth = MediaQuery.of(context).size.width;

    if (widget.userType == ORDER_OWNER_TYPES['SENDER']) {
      if (widget.status == MATCH_STATUSES["INITIATED"]) {
        //TODO: reject koymaya gerek var mı ?
      } else if (widget.status == MATCH_STATUSES["CARRIER_APPROVED"]) {
        row.add(
            _buildStatusActionButton(FontAwesomeIcons.times, _reject(context)));
        row.add(
            _buildStatusActionButton(FontAwesomeIcons.check, _accept(context)));
      } else if (widget.status == MATCH_STATUSES["REJECTED"]) {
        //TODO: chat kapatılmalı mı ?
      } else if (widget.status == MATCH_STATUSES["WAITING_FOR_PAYMENT"]) {
        row.add(_buildStatusActionButton(
            FontAwesomeIcons.check, _passPayment(context)));
      } else if (widget.status ==
          MATCH_STATUSES["PAYMENT_PASSED_FOR_ON_ON_DELIVERY"]) {
      } else if (widget.status == MATCH_STATUSES["BOX_CHECK_PASSED"]) {
      } else if (widget.status == MATCH_STATUSES["PACKET_TAKING_CODE_SENT"]) {
      } else if (widget.status == MATCH_STATUSES["ON_WAY"]) {
      } else if (widget.status == MATCH_STATUSES["PACKET_DELIVERY_CODE_SENT"]) {
      } else if (widget.status == MATCH_STATUSES["FINISHED"]) {
        //TODO: chat kapatılsın mı
      }
    } else {
      if (widget.status == MATCH_STATUSES["INITIATED"]) {
        row.add(
            _buildStatusActionButton(FontAwesomeIcons.times, _reject(context)));
        row.add(
            _buildStatusActionButton(FontAwesomeIcons.check, _accept(context)));
      } else if (widget.status == MATCH_STATUSES["CARRIER_APPROVED"]) {
        //TODO: reject koymaya gerek var mı ?
      } else if (widget.status == MATCH_STATUSES["REJECTED"]) {
        //TODO: chat kapatılmalı mı ?
      } else if (widget.status == MATCH_STATUSES["WAITING_FOR_PAYMENT"]) {
      } else if (widget.status ==
          MATCH_STATUSES["PAYMENT_PASSED_FOR_ON_ON_DELIVERY"]) {
        row.add(_buildStatusActionButton(
            FontAwesomeIcons.times, _checkBoxFail(context)));
        row.add(_buildStatusActionButton(
            FontAwesomeIcons.check, _checkBoxDone(context)));
      } else if (widget.status == MATCH_STATUSES["BOX_CHECK_PASSED"]) {
        row.add(_buildStatusActionButton(
            FontAwesomeIcons.check, _readyForTakingBox(context)));
      } else if (widget.status == MATCH_STATUSES["PACKET_TAKING_CODE_SENT"]) {
        row.add(_buildStatusActionButton(
            FontAwesomeIcons.check, _confirmTakingCode(context)));
      } else if (widget.status == MATCH_STATUSES["ON_WAY"]) {
        row.add(_buildStatusActionButton(
            FontAwesomeIcons.check, _readyForDeliveringBox(context)));
      } else if (widget.status == MATCH_STATUSES["PACKET_DELIVERY_CODE_SENT"]) {
        row.add(_buildStatusActionButton(
            FontAwesomeIcons.check, _confirmConfirmationCode(context)));
      } else if (widget.status == MATCH_STATUSES["FINISHED"]) {
        //TODO: chat kapatılsın mı
      }
    }

    return Container(
      margin: EdgeInsets.only(left: 4, right: 4, bottom: 4),
      width: screenWidth,
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        color: primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: row,
      ),
    );
  }

  Widget _buildMessageListView() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
        reverse: true,
        itemCount: widget.toPrint.length,
        itemBuilder: _buildListItem,
      ),
    );
  }

  Widget _buildInputBar() {
    return Padding(
      padding: EdgeInsets.all(4),
      child: TextField(
        style: messageBlackTextStyle,
        cursorColor: Colors.black,
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
          _buildStatusBar(context),
          _buildMessageListView(),
          _buildInputBar(),
        ],
      ),
    );
  }
}
