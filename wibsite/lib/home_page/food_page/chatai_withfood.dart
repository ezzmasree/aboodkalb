import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChataiWithfood extends StatefulWidget {
  const ChataiWithfood({super.key});

  @override
  _ChataiWithfood createState() => _ChataiWithfood();
}

class _ChataiWithfood extends State<ChataiWithfood> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, String>> messages = [];
  int currentStep = 0; // Tracks the current question
  String selectedCategory = "";
  String caloriesPreference = "";
  String userIngredients = "";

  @override
  void initState() {
    super.initState();

    // Initial welcome message
    messages.add({
      'sender': 'bot',
      'text':
          'Hello! I am your food AI assistant. Let\'s find the perfect meal for you. I have a few questions first!',
    });

    _askNextQuestion();
  }

  Future<void> sendMessage(String userMessage) async {
    setState(() {
      messages.add({'sender': 'user', 'text': userMessage});
    });

    _scrollToBottom();

  //   switch (currentStep) {
  //     case 0:
  //       selectedCategory = userMessage;
  //       messages.add({'sender': 'bot', 'text': 'okay okay thats good,but before that i need to know,How many calories do you want in your meal?'});
  //       currentStep++;
  //       break;

  //     case 1:
  //       caloriesPreference = userMessage;
  //       messages.add({'sender': 'bot', 'text': 'hmmmm okay then ,What ingredients do you have in your kitchen?'});
  //       currentStep++;
  //       break;

  //     case 2:
  //       userIngredients = userMessage;

  //       await _fetchMealRecommendations();
  //       currentStep++;
  //       break;

  //     default:
  //       messages.add({'sender': 'bot', 'text': 'Let me know if you need more recommendations!'});
  //   }

  //   _scrollToBottom();
  // }


 switch (currentStep) {
    case 0:
      selectedCategory = userMessage;
      messages.add({'sender': 'bot', 'text': 'okay okay thats good,but before that i need to know,How many calories do you want in your meal?'});
      currentStep++;
      break;

    case 1:
      caloriesPreference = userMessage;
      messages.add({'sender': 'bot', 'text': 'hmmmm okay then ,What ingredients do you have in your kitchen?'});
      currentStep++;
      break;

    case 2:
      userIngredients = userMessage;

      // Show a waiting message
      setState(() {
        messages.add({'sender': 'bot', 'text': 'Got it! Let me find the perfect meal for you. Please wait a moment...'});
      });

      _scrollToBottom();

      // Fetch meal recommendations after a short delay
      await Future.delayed(const Duration(seconds: 2));
      await _fetchMealRecommendations();
      currentStep++;
      break;

    default:
      messages.add({'sender': 'bot', 'text': 'Let me know if you need more recommendations!'});
  }

  _scrollToBottom();
}




  Future<void> _fetchMealRecommendations() async {
    final url = Uri.parse('http://192.168.1.114:3000/chat'); // Replace with your backend IP

    final requestPayload = {
      'prompt': '''
        Find a meal based on these preferences:
        Category: $selectedCategory,
        Calories: $caloriesPreference,
        Ingredients: $userIngredients.
        Provide the meal title, calories, description, ingredients, and instructions.
      '''
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestPayload),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      setState(() {
        messages.add({'sender': 'bot', 'text': responseData['text']});
      });
    } else {
      setState(() {
        messages.add({'sender': 'bot', 'text': 'Sorry, something went wrong. Please try again later.'});
      });
    }
  }

  void _askNextQuestion() {
    if (currentStep == 0) {
      messages.add({
        'sender': 'bot',
        'text': 'What meal would you like? Choose from breakfast, brunch, lunch, or snacks.',
      });
    }
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
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Food Bot',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey[900],
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messages.length,
                reverse: false,
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
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: isUser
                            ? Colors.red.withOpacity(0.8)
                            : const Color.fromARGB(255, 0, 0, 0)
                                .withOpacity(0.8),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomLeft:
                              isUser ? Radius.circular(16) : Radius.zero,
                          bottomRight:
                              isUser ? Radius.zero : Radius.circular(16),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        message['text'] ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        hintStyle: const TextStyle(color: Colors.white54),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        filled: true,
                        fillColor: Colors.grey[800],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear, color: Colors.red),
                          onPressed: () => _controller.clear(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      if (_controller.text.trim().isNotEmpty) {
                        sendMessage(_controller.text.trim());
                        _controller.clear();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
