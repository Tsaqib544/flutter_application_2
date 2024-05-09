import 'package:flutter/material.dart';

class FeedbackSummaryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> feedbackList;

  const FeedbackSummaryScreen({Key? key, required this.feedbackList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Summary'),
      ),
      body: ListView.builder(
        itemCount: feedbackList.length,
        itemBuilder: (context, index) {
          final feedback = feedbackList[index];
          return ListTile(
            title: Text(feedback['title'] ?? ''),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Feedback: ${feedback['feedback'] ?? ''}'),
                SizedBox(height: 8),
                Text('Penilaian:'),
                SizedBox(height: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (feedback['ratings'] as Map<String, dynamic>)
                      .entries
                      .map(
                        (entry) => Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '${entry.key}: ${entry.value}',
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
