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
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: feedbackList.length,
          itemBuilder: (context, index) {
            final feedback = feedbackList[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feedback['title'] ?? '',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Feedback:',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      feedback['feedback'] ?? 'No feedback provided',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Penilaian:',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: (feedback['ratings'] as Map<String, dynamic>)
                          .entries
                          .map(
                            (entry) => Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Text(
                                '${entry.key}: ${entry.value ?? 'No rating'}',
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}