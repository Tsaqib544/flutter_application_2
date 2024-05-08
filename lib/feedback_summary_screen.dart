// feedback_summary_screen.dart
import 'package:flutter/material.dart';

class FeedbackSummaryScreen extends StatelessWidget {
  const FeedbackSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Summary'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Feedback 1'),
            subtitle: Text('Course 1'),
            onTap: () {
              // Navigate to detailed feedback
            },
          ),
          ListTile(
            title: Text('Feedback 2'),
            subtitle: Text('Instructor 1'),
            onTap: () {
              // Navigate to detailed feedback
            },
          ),
          ListTile(
            title: Text('Feedback 3'),
            subtitle: Text('Course 2'),
            onTap: () {
              // Navigate to detailed feedback
            },
          ),
          // Add more feedback items as needed
        ],
      ),
    );
  }
}
