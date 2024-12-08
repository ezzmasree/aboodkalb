import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  List<String> dis = [];
  List<String> dis_withnumber = [];
  int count = 1;
  String resposefromai = "";
  List<Map<String, String>> chestVideos = [];
  List<Map<String, String>> shoulderVideos = [];
  List<Map<String, String>> handsVideos = [];
  List<Map<String, String>> backVideos = [];
  List<Map<String, String>> legsVideos = [];
  List<Map<String, String>> trysibs = [];
  @override
  void initState() {
    super.initState();
    searchById("chest.email", 'chest');
    searchById("shoulder.email", 'shoulder');
    searchById("bicebs.email", 'hands');
    searchById("back.email", 'back');
    searchById("legs.email", 'legs');
    searchById("trysibs .email", 'trysibs');

    messages.add({
      'sender': 'bot',
      'text':
          'Hello! What is your job or role? This will help me recommend videos tailored to your needs.'
    });
  }

  void searchById(String id, String category) async {
    final url = Uri.parse('http://192.168.1.100:3000/pro/$id');

    try {
      final response = await http.get(url);
      List<Map<String, String>> videoList = [];
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        int flag = 0;
        if (data['fitnes'] != null && data['fitnes'] is List) {
          setState(() {
            for (var video in data['fitnes']) {
              if (video.length >= 3) {
                if (flag < 1) {
                  dis_withnumber.add('$count-${video[2]}');
                  count++;
                  flag++;
                }
                dis.add(video[2]);
                videoList.add({
                  'id': video[0],
                  'title': video[1],
                  'description': video[2],
                });
              }
            }
            if (category == 'chest') {
              chestVideos = videoList;
            } else if (category == 'shoulder') {
              shoulderVideos = videoList;
            } else if (category == 'hands') {
              handsVideos = videoList;
            } else if (category == 'back') {
              backVideos = videoList;
            } else if (category == 'legs') {
              legsVideos = videoList;
            } else if (category == 'trysibs') {
              trysibs = videoList;
            }
          });
        } else {
          print('Invalid fitness data!');
        }
      } else {
        print('Product not found!');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, String>> messages = [];

  Future<void> sendMessage(String userMessage) async {
    setState(() {
      messages.add({
        'sender': 'user',
        'text': userMessage,
      });
    });

    // Scroll to the bottom after the user sends a message
    _scrollToBottom();

    final url = Uri.parse(
        'http://192.168.1.100:3000/chat'); // Replace with your backend IP

    // Send only the new user message to the API
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'prompt':
            ' I am working a ${userMessage}, chose  from this menu one option to excrcice it  . Please answer only the number of the option from this menu: 1-chest. 2-leg. 3-shoulder. 4-biceps. 5-back. 6-triceps. '
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      setState(() {
        String a;

        resposefromai = responseData['text'];
        print(resposefromai);
        if (resposefromai.contains('1')) {
          // String description = chestVideos['description'];
          a = "Nice jop to be a ${userMessage} .\n I suggest to you to trainnig chest \n ${chestVideos[0]['description']} \n u can vist our page called workout_in in chest menu then chose vedio as u like ";
        } else if (resposefromai.contains('2')) {
          a = "Nice jop to be a ${userMessage} .\nI suggest to you to trainnig legs \n${legsVideos[0]['description']} \n u can vist our page called workout_in in legs menu then chose vedio as u like ";
        } else if (resposefromai.contains('3')) {
          a = "Nice jop to be a ${userMessage} .\nI suggest to you to trainnig shoulder \n${shoulderVideos[0]['description']} \nu can vist our page called workout_in in shoulder menu then chose vedio as u like ";
        } else if (resposefromai.contains('4')) {
          a = "Nice jop to be a ${userMessage} .\nI suggest to you to trainnig bisibs \n${handsVideos[0]['description']} \nu can vist our page called workout_in in bisibs menu then chose vedio as u like ";
        } else if (resposefromai.contains('5')) {
          a = "Nice jop to be a ${userMessage} .\nI suggest to you to trainnig back \n${backVideos[0]['description']}\n u can vist our page called workout_in in back menu then chose vedio as u like ";
        } else if (resposefromai.contains('6')) {
          a = "Nice jop to be a ${userMessage} .\nI suggest to you to trainnig trysibs \n${trysibs[0]['description']} \nu can vist our page called workout_in in trysibs menu then chose vedio as u like ";
        } else {
          a = "Nice jop to be a ${userMessage} .\nI suggest to you to trainnig chest. \n${chestVideos[0]['description']}\n u can vist our page called workout_in in chest menu then chose vedio as u like ";
        }
        //  messages.add({'sender': 'bot', 'text': responseData['text']});
        messages.add({'sender': 'bot', 'text': a});
      });
    } else {
      setState(() {
        messages.add({
          'sender': 'bot',
          'text': 'Sorry, something went wrong. Please try again later.'
        });
      });
    }

    // Scroll to the bottom after the bot sends a response
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 156, 225, 8)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Chat Bot',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messages.length,
                reverse: false, // Ensure the order is not reversed
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isUser = message['sender'] == 'user';
                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.grey[850] : Colors.grey[700],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomLeft:
                              isUser ? Radius.circular(16) : Radius.zero,
                          bottomRight:
                              isUser ? Radius.zero : Radius.circular(16),
                        ),
                      ),
                      child: Text(
                        message['text'] ?? '',
                        style: TextStyle(
                          color: Color(0xffD5FF5F),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            color: Colors.black,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffD5FF5F),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      filled: true,
                      fillColor: Colors.grey[850],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear, color: Color(0xffD5FF5F)),
                        onPressed: () => _controller.clear(),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    print(dis_withnumber);
                    if (_controller.text.trim().isNotEmpty) {
                      sendMessage(_controller.text.trim());
                      _controller.clear();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xffD5FF5F),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.send,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
