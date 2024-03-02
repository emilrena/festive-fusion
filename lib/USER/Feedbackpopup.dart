import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PopupP extends StatefulWidget {
  const PopupP({super.key});

  @override
  State<PopupP> createState() => _PopupPState();
}

class _PopupPState extends State<PopupP> {
  // Controller for the feedback text field
  TextEditingController feedbackController = TextEditingController();

  // Function to show the feedback pop-up
  void showFeedbackPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Give Feedback"),
          content: Column(
            children: [
              Text("Share your thoughts:"),
              TextField(
                controller: feedbackController,
                maxLines: 4,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Add your logic to handle feedback submission
                String feedbackText = feedbackController.text;
                // You can send the feedback to your server or handle it as needed
                print("Feedback submitted: $feedbackText");

                // Close the pop-up
                Navigator.of(context).pop();
              },
              child: Text("Send Feedback"),
            ),
            TextButton(
              onPressed: () {
                // Close the pop-up
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HOME',
          style: TextStyle(color: Color.fromARGB(255, 15, 15, 15)),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              // Your existing content goes here

              // Button to open feedback pop-up
              ElevatedButton(
                onPressed: () {
                  showFeedbackPopup(context);
                },
                child: Text('Give Feedback'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
