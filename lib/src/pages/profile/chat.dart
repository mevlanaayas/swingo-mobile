import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/theme/decoration.dart';
import 'package:swingo/src/theme/style.dart';

// TODO: delete after completing design
final rng = new Random();

// TODO: get username and chat id from navigation and provider
const String roomId = "5d0cfa9e379d92540791c497";
const String username = "sender";

class ChatPage extends StatefulWidget {
  List<String> toPrint = [];

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
  }

  initSocket() async {
    socket = await manager.createInstance("http://192.168.1.61:3000/");
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
      {"username": username, "roomId": roomId}
    ]);
    // TODO: get recent messages from api
  }

  disconnect() async {
    await manager.clearInstance(socket);
  }

  disconnectRoom() {
    socket.emit("LEAVE_ROOM", [
      {"username": username, "roomId": roomId}
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
        {"username": username, "message": _controller.text, "roomId": roomId}
      ]);
      _controller.clear();
    }
  }

  pprint(data) {
    setState(() {
      if (data is Map) {
        data = json.encode(data);
      }
      print(data);
      widget.toPrint.insert(0, data);
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
    String message = widget.toPrint[index];
    Widget messageRow;
    /*
    if(userId != message.userId){
      messageRow = _buildMessageBox(message, swLivingCoral300, Alignment.centerRight);
    } else {
      messageRow = _buildMessageBox(message, altDarkBlue, Alignment.centerLeft);
    }
    return messageRow;
     */
    messageRow = rng.nextInt(100) % 2 == 0
        ? _buildMessageBox(message, primaryColor, Alignment.centerRight)
        : _buildMessageBox(message, secondaryColor, Alignment.centerLeft);
    return messageRow;
  }

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
