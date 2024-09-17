import 'package:flutter/material.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<ChatbotPage> {
  // Controller to get input from the text field
  final TextEditingController _textController = TextEditingController();

  // List of suggestions for solar PV systems
  final List<String> _suggestions = [
    'What are the benefits of installing a solar PV system?',
    'How much does a solar PV system cost?',
    'How does solar energy work in a PV system?',
    'What maintenance is required for a solar PV system?',
    'Can solar PV systems be used for residential homes?',
  ];

  // Dummy chat history for demonstration
  final List<String> _chatHistory = [
    'Hello, how can I assist you?',
    'Can you tell me about solar PV systems?',
    'Sure! Solar PV systems use sunlight to generate electricity...',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4DE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF4DE),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop(); // Go back to the previous screen
          },
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'SINAGbot',
              style: TextStyle(
                color: Color.fromARGB(255, 124, 123, 123),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4), // Spacing between the title and the status
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Color(0xFF14BA43), // Updated color to #14BA43
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 4), // Spacing between the dot and the text
                Text(
                  'Active',
                  style: TextStyle(
                    color: Colors.black, // Changed color to black
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: true, // Center the title in the AppBar
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openEndDrawer(); // Open the side panel (end drawer)
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFFFF4DE),
              ),
              child: Text(
                'Chat History',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ..._chatHistory.map((message) {
              return ListTile(
                title: Text(message),
              );
            }).toList(),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Hello ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),                      
                      Icon(
                        Icons.waving_hand, // Hand waving icon
                        color: Colors.black,
                        size: 24,
                      ),
                      Text(
                        " I'm",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),                      
                      Text(
                        " SINAGbot",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8), // Spacing between the icon and the bottom text
                  Text(
                    "Your personal solar PV system advisor.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Suggestions list placed above the text input
          Container(
            padding: EdgeInsets.all(8.0),
            height: 60, // Adjusted height for the suggestions
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Update the text input with the selected suggestion
                    _textController.text = _suggestions[index];
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF4DE),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFFBBE47)),
                    ),
                    child: Center(
                      child: Text(
                        _suggestions[index],
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Ask a question...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Color(0xFFFBBE47), // Set the border color to #FBBE47
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_upward, color: Colors.grey),
                  onPressed: () {
                    // Handle send button press
                    print('Message sent: ${_textController.text}');
                    _textController.clear(); // Clear the text field
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
