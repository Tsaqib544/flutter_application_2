import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/styles.dart';

class CourseFeedbackForm extends StatefulWidget {
  final String courseName;

  const CourseFeedbackForm({Key? key, required this.courseName})
      : super(key: key);

  @override
  _CourseFeedbackFormState createState() => _CourseFeedbackFormState();
}

class _CourseFeedbackFormState extends State<CourseFeedbackForm> {
  final Map<String, String?> _ratings = {
    'Kesesuaian materi kuliah dengan tujuan pembelajaran': null,
    'Kejelasan penyampaian materi oleh dosen': null,
    'Kesesuaian beban tugas dengan kemampuan mahasiswa': null,
    'Keefektifan sarana dan prasarana yang digunakan': null,
    'Mata kuliah ini bermanfaat untuk meningkatkan pengetahuan dan keterampilan saya': null,
  };
  final TextEditingController _feedbackController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _submitFeedback() async {
    Map<String, dynamic> feedbackData = {
      'courseName': widget.courseName,
      'ratings': _ratings,
      'additionalFeedback': _feedbackController.text,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await _firestore.collection('feedbacks').add(feedbackData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Penilaian Mata Kuliah ${widget.courseName}',
          style: TextStyles.title,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                children: _ratings.keys.map((String key) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          key,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Sangat Buruk'),
                            Text('Buruk'),
                            Text('Cukup'),
                            Text('Baik'),
                            Text('Sangat Baik'),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Radio<String>(
                              value: 'Sangat Buruk',
                              groupValue: _ratings[key],
                              onChanged: (value) {
                                setState(() {
                                  _ratings[key] = value;
                                });
                              },
                            ),
                            Radio<String>(
                              value: 'Buruk',
                              groupValue: _ratings[key],
                              onChanged: (value) {
                                setState(() {
                                  _ratings[key] = value;
                                });
                              },
                            ),
                            Radio<String>(
                              value: 'Cukup',
                              groupValue: _ratings[key],
                              onChanged: (value) {
                                setState(() {
                                  _ratings[key] = value;
                                });
                              },
                            ),
                            Radio<String>(
                              value: 'Baik',
                              groupValue: _ratings[key],
                              onChanged: (value) {
                                setState(() {
                                  _ratings[key] = value;
                                });
                              },
                            ),
                            Radio<String>(
                              value: 'Sangat Baik',
                              groupValue: _ratings[key],
                              onChanged: (value) {
                                setState(() {
                                  _ratings[key] = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _feedbackController,
              decoration: InputDecoration(
                labelText: 'Feedback/Masukan (opsional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _submitFeedback();
                Navigator.pop(context);
              },
              child: Text('Kirim Feedback', style: TextStyles.body),
            ),
          ],
        ),
      ),
    );
  }
}
