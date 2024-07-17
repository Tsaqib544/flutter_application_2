import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewFeedbackScreen extends StatelessWidget {
  const ViewFeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lihat Feedback'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('feedbacks').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Tidak ada feedback'));
          }

          var feedbacks = snapshot.data!.docs;

          return ListView.builder(
            itemCount: feedbacks.length,
            itemBuilder: (context, index) {
              var feedback = feedbacks[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(feedback['courseName'] ?? 'No Title'),
                  subtitle:
                      Text(feedback['additionalFeedback'] ?? 'No Description'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(feedback['courseName'] ?? 'No Title'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Penilaian:'),
                            ...feedback['ratings'].entries.map<Widget>((entry) {
                              return Text('${entry.key}: ${entry.value}');
                            }).toList(),
                            SizedBox(height: 10),
                            Text('Feedback tambahan:'),
                            Text(feedback['additionalFeedback'] ?? 'Tidak ada'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Tutup'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
