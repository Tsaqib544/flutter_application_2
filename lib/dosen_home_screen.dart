import 'package:flutter/material.dart';
import 'package:flutter_application_2/create_edit_dosen_survey_screen.dart';
import 'package:flutter_application_2/create_edit_course_survey_screen.dart';
import 'package:flutter_application_2/view_feedback_screen.dart';

class DosenHomeScreen extends StatelessWidget {
  const DosenHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dosen Home Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateEditDosenSurveyScreen(),
                  ),
                );
              },
              child: Text('Buat Formulir Survei Dosen'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateEditCourseSurveyScreen(),
                  ),
                );
              },
              child: Text('Buat Formulir Penilaian Mata Kuliah'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewFeedbackScreen(),
                  ),
                );
              },
              child: Text('Lihat Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}
