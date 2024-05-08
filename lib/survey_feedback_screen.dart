// survey_feedback_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_2/styles.dart';

class SurveyFeedbackScreen extends StatelessWidget {
  final String title;

  const SurveyFeedbackScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback & Survey', style: TextStyles.title),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyles.subtitle,
            ),
            SizedBox(height: 16.0),
            if (title.contains('Dosen'))
              _buildDosenForm()
            else if (title.contains('Mata Kuliah'))
              _buildMataKuliahForm(),
            SizedBox(height: 16.0),
            _buildFeedbackForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildDosenForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Penilaian Dosen',
          style: TextStyles.body,
        ),
        SizedBox(height: 8.0),
        Text('Pertanyaan 1'),
        RadioListTile(
          value: 1,
          groupValue: 1,
          onChanged: (value) {},
          title: Text('Sangat Baik'),
        ),
        RadioListTile(
          value: 2,
          groupValue: 1,
          onChanged: (value) {},
          title: Text('Baik'),
        ),
        RadioListTile(
          value: 3,
          groupValue: 1,
          onChanged: (value) {},
          title: Text('Cukup'),
        ),
        RadioListTile(
          value: 4,
          groupValue: 1,
          onChanged: (value) {},
          title: Text('Kurang'),
        ),
      ],
    );
  }

  Widget _buildMataKuliahForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Penilaian Mata Kuliah',
          style: TextStyles.body,
        ),
        SizedBox(height: 8.0),
        Text('Pertanyaan 1'),
        RadioListTile(
          value: 1,
          groupValue: 1,
          onChanged: (value) {},
          title: Text('Sangat Baik'),
        ),
        RadioListTile(
          value: 2,
          groupValue: 1,
          onChanged: (value) {},
          title: Text('Baik'),
        ),
        RadioListTile(
          value: 3,
          groupValue: 1,
          onChanged: (value) {},
          title: Text('Cukup'),
        ),
        RadioListTile(
          value: 4,
          groupValue: 1,
          onChanged: (value) {},
          title: Text('Kurang'),
        ),
      ],
    );
  }

  Widget _buildFeedbackForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.0),
        Text(
          'Feedback',
          style: TextStyles.body,
        ),
        SizedBox(height: 8.0),
        TextFormField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Masukkan feedback Anda...',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            // Logika untuk menyimpan penilaian dan feedback
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
