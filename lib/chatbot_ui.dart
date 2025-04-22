import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _messageController = TextEditingController();
  final String apiKey = dotenv.env['GEMINI_API_KEY'] ?? ''; // Load API key

  late final GenerativeModel model;

  @override
  void initState() {
    super.initState();
    model = GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: apiKey);
  }

  List<Map<String, String>> _messages = [];

  void _sendMessage() async {
    String userMessage = _messageController.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      _messages.add({"sender": "user", "text": userMessage});
    });

    _messageController.clear();

    try {
      GenerateContentResponse response =
          await model.generateContent([Content.text(userMessage)]);
      String botResponse =
          response.text ?? "I'm not sure how to respond to that 🤖";

      setState(() {
        _messages.add({"sender": "bot", "text": botResponse});
      });
    } catch (e) {
      print("❌ ERROR: $e"); // Debugging
      setState(() {
        _messages.add(
            {"sender": "bot", "text": "Oops! Something went wrong. Error: $e"});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chatbot"),
        backgroundColor: Colors.pink[200],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                final isUser = message["sender"] == "user";
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:
                          isUser ? Colors.pink.shade200 : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      message["text"]!,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: _sendMessage,
                  child: Icon(Icons.send, color: Colors.white),
                  backgroundColor: Colors.pink[300],
                  mini: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
