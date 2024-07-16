import 'package:flutter/material.dart';

class ViewFeedbackScreen extends StatelessWidget {
  const ViewFeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Placeholder data
    final List<Map<String, String>> feedbackList = [
      {'title': 'Survey for Vihi Atina, M.Kom', 'feedback': 'Very knowledgeable and engaging.'},
      {'title': 'Survey for Triyono, M.Kom', 'feedback': 'Good explanations but could use more examples.'},
      {'title': 'Survey for Joni Maulindar, S.T, M.Kom', 'feedback': 'Great lecturer, very clear and concise.'},
      {'title': 'Survey for Pemrograman Mobile', 'feedback': 'Course content was very relevant and up-to-date.'},
      {'title': 'Survey for Kecerdasan Mesin dan Buatan', 'feedback': 'Interesting subject but tough to grasp at times.'},
      {'title': 'Survey for Pemrograman Visual', 'feedback': 'Fun and interactive classes, learned a lot.'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('View Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: feedbackList.length,
          itemBuilder: (context, index) {
            final feedback = feedbackList[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(feedback['title']!),
                subtitle: Text(feedback['feedback']!),
              ),
            );
          },
        ),
      ),
    );
  }
}
