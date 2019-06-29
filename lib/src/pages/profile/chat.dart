import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/models/chat_room.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/services/chat.dart';
import 'package:swingo/src/theme/decoration.dart';
import 'package:swingo/src/theme/style.dart';

// TODO: delete after completing design
final rng = new Random();

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

  @override
  void initState() {
    super.initState();
    manager = SocketIOManager();
    initSocket();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _listMessages(context);
    });
  }

  initSocket() async {
    socket = await manager.createInstance("http://127.0.0.1:3000/");
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
      socket.emit("SEND_MESSAGE", [
        {
          "username": widget.username,
          "message": _controller.text,
          "roomId": widget.chatRoom.id
        }
      ]);
      _controller.clear();
    }
  }

  pprint(data) {
    setState(() {
      print(data);
      widget.toPrint.insert(0, Message(
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
        margin: const EdgeInsets.all(10),
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

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserStatus>(context);
    return Container(
      decoration: BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage('assets/images/chat-background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
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
        ),
      ),
    );
  }
}
