import 'package:flutter/material.dart';
import 'package:flutter_application_2/styles.dart';
import 'package:flutter_application_2/feedback_summary_screen.dart';

class DosenFeedbackForm extends StatefulWidget {
  final String dosenName;

  const DosenFeedbackForm({Key? key, required this.dosenName})
      : super(key: key);

  @override
  _DosenFeedbackFormState createState() => _DosenFeedbackFormState();
}

class _DosenFeedbackFormState extends State<DosenFeedbackForm> {
  Map<String, String?> _ratings = {
    'Dosen mampu menjelaskan materi dengan jelas dan mudah dipahami.': null,
    'Dosen mampu menjawab pertanyaan mahasiswa dengan jelas dan tepat.': null,
    'Dosen mampu membangun hubungan yang baik dengan mahasiswa.': null,
    'Dosen memberikan feedback yang jelas dan konstruktif terhadap tugas mahasiswa.':
        null,
    'Dosen mampu memotivasi dan menginspirasi mahasiswa untuk belajar.': null,
    'Dosen mendorong mahasiswa untuk mengembangkan potensi diri mereka.': null,
  };
  TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Penilaian Dosen ${widget.dosenName}',
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
              onPressed: () {
                // Kirim feedback ke server atau simpan ke database
                Map<String, dynamic> feedback = {
                  'title': 'Feedback for ${widget.dosenName}',
                  'subtitle': widget.dosenName,
                  'ratings': _ratings,
                  'feedback': _feedbackController.text,
                };
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeedbackSummaryScreen(
                      feedbackList: [feedback],
                    ),
                  ),
                );
              },
              child: Text('Kirim Feedback', style: TextStyles.body),
            ),
          ],
        ),
      ),
    );
  }
}
