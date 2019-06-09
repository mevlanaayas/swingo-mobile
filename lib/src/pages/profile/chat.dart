import 'package:flutter/material.dart';
import 'package:swingo/src/theme/colors.dart';

class Message {
  final int userId;
  final String text;
  Message(this.userId, this.text);
}

class ChatPage extends StatefulWidget {
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>{
  ValueChanged<String> onSubmitted;
  TextEditingController textEditingController = TextEditingController();
  int userId = 2; // TODO: user kendi bilgisini alınca burası düzeltilecek
  List<Message> messages = [
    new Message(1, 'İrmaaaa cideydrum hoooooooooy anasini aloooooooooooo. Alooooooooooo.'),
    new Message(1, 'Heee oni diyrum.'),
    new Message(2, 'Hamsi çekayi???'),
    new Message(2, 'Sorry?'),
    new Message(1, 'Hacı abi canım hamsi çekayi.'),
  ];

  Widget _buildMessageBox(Message message, Color color, Alignment alignment){
    double screenWidth = MediaQuery.of(context).size.width; //TODO: Bu bir yerde saklanılabilir.
    double maximumMessageSize = screenWidth / 100 * 75;

    return  Align(
        alignment: alignment,
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(8),
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(Radius.circular(10)),
              color: color
          ),
          constraints: BoxConstraints(
              maxWidth: maximumMessageSize,
          ),
          child: Text(
            message.text,
            style: TextStyle(color: Colors.white),
          ),
        )
    );
  }

  Widget _buildListItem(BuildContext context, int index){
    Message message = messages[index];
    Widget messageRow;
    if(userId != message.userId){
      messageRow = _buildMessageBox(message, swLivingCoral300, Alignment.centerRight);
    } else {
      messageRow = _buildMessageBox(message, altDarkBlue, Alignment.centerLeft);
    }
    return messageRow;
  }

  void _onEmojiPressed(){
    print("Emojiye tıklandı");
  }

  void _onSendButtonPressed(){
    if(textEditingController.text != ''){
      _insertMessageToList(Message(userId, textEditingController.text));
    }
  }

  void _handleSubmission(String text){
    _insertMessageToList(Message(userId, text));
  }

  void _insertMessageToList(Message message){
    setState(() {
        messages.insert(0, message);
    });
    textEditingController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey,
            image: new DecorationImage(
                image: new AssetImage('assets/images/chat-background.jpg'),
                fit: BoxFit.cover
            )
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
                        itemCount: messages.length,
                        itemBuilder: _buildListItem
                    ),
                  ),
                  TextField(
                    onSubmitted: _handleSubmission,
                    controller: textEditingController,
                    style: TextStyle(
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black12,
                      hintText: 'Please enter something. :)',
                      hintStyle: TextStyle(
                          color: Colors.white
                      ),
                      prefixIcon: IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.insert_emoticon),
                        onPressed: _onEmojiPressed,
                      ),
                      suffixIcon: IconButton(
                          color: altDarkBlue,
                          icon: Icon(Icons.send),
                          onPressed: _onSendButtonPressed
                      ),
                    ),
                  )
                ]
            )
          ),
      )
    );
  }
}