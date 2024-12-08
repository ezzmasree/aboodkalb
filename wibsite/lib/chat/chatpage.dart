import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wibsite/chat/chatservice.dart';
import 'package:wibsite/sign_inmoblie/auth.dart';

class Chatpage extends StatelessWidget {
  final String riciveemail;
  final String riciveid;

  Chatpage({super.key, required this.riciveemail, required this.riciveid});

  @override
  final TextEditingController massagecount = TextEditingController();
  final chatservice chatServ = chatservice();
  final Authservce authSer = Authservce();

  void sendmaasge() async {
    if (massagecount.text.isNotEmpty) {
      await chatServ.sendmassege(riciveid, massagecount.text);
      print("Message sent: ${massagecount.text}");
      massagecount.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set black background
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          riciveemail,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black, // Match app bar with background
      ),
      body: Column(
        children: [
          Expanded(child: buldmassegelist()),
          const Divider(height: 1, color: Colors.white), // White divider
          bulduserinput(),
        ],
      ),
    );
  }

  Widget buldmassegelist() {
    String senedrid = authSer.getcurrentuser()!.uid;
    return StreamBuilder(
      stream: chatServ.getmessages(riciveid, senedrid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
              child: Text("An error occurred.",
                  style: TextStyle(color: Colors.white)));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.white));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
              child: Text("No messages found.",
                  style: TextStyle(color: Colors.white)));
        }

        List<DocumentSnapshot> messages = snapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return buldmassageitem(messages[index], index + 1);
          },
        );
      },
    );
  }

  Widget buldmassageitem(DocumentSnapshot doc, int count) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool iscurrent = data['senderID'] == authSer.getcurrentuser()!.uid;
    var alligmnt = iscurrent ? Alignment.centerRight : Alignment.centerLeft;
    var badgeColor =
        iscurrent ? Colors.teal : const Color.fromARGB(255, 4, 231, 114);

    return Column(
      crossAxisAlignment:
          iscurrent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          alignment: alligmnt,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!iscurrent)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$count',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              const SizedBox(width: 4),
              Container(
                alignment: alligmnt,
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iscurrent
                      ? Colors.teal
                      : const Color.fromARGB(255, 7, 124, 63),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Text(
                  data["message"],
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              if (iscurrent) const SizedBox(width: 4),
              if (iscurrent)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$count',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget bulduserinput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      color: Colors.grey.shade900, // Dark input area background
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: massagecount,
              decoration: InputDecoration(
                hintText: "Type your message...",
                hintStyle: const TextStyle(
                    color: Colors.white70), // Lighter text for hint
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none, // Remove border line
                ),
                filled: true,
                fillColor: Colors.white30, // Semi-transparent input field
              ),
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: sendmaasge,
            icon: const Icon(Icons.send, color: Colors.teal),
          ),
        ],
      ),
    );
  }
}
