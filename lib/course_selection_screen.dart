// course_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_2/survey_feedback_screen.dart';
import 'package:flutter_application_2/styles.dart';

class CourseSelectionScreen extends StatelessWidget {
  const CourseSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Silahkan Pilih Dosen atau Mata Kuliah',
            style: TextStyles.title),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Dosen', style: TextStyles.subtitle),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SurveyFeedbackScreen(title: 'Vihi Atina, M.Kom'),
                  ),
                );
              },
              child: Text('Vihi Atina, M.Kom', style: TextStyles.body),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SurveyFeedbackScreen(title: 'Triyono, M.Kom'),
                  ),
                );
              },
              child: Text('Triyono, M.Kom', style: TextStyles.body),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SurveyFeedbackScreen(
                        title: 'Joni Maulindar, S.T, M.Kom'),
                  ),
                );
              },
              child: Text('Joni Maulindar, S.T, M.Kom', style: TextStyles.body),
            ),
            SizedBox(height: 32.0),
            Text('Mata Kuliah', style: TextStyles.subtitle),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SurveyFeedbackScreen(title: 'Pemrograman Mobile'),
                  ),
                );
              },
              child: Text('Pemrograman Mobile', style: TextStyles.body),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SurveyFeedbackScreen(
                        title: 'Kecerdasan Mesin dan Buatan'),
                  ),
                );
              },
              child:
                  Text('Kecerdasan Mesin dan Buatan', style: TextStyles.body),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SurveyFeedbackScreen(title: 'Pemrograman Visual'),
                  ),
                );
              },
              child: Text('Pemrograman Visual', style: TextStyles.body),
            ),
          ],
        ),
      ),
    );
  }
}
