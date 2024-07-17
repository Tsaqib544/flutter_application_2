import 'package:flutter/material.dart';
import 'package:flutter_application_2/create_edit_dosen_survey_screen.dart';
import 'package:flutter_application_2/create_edit_course_survey_screen.dart';
import 'package:flutter_application_2/view_feedback_screen.dart';
import 'package:flutter_application_2/styles.dart'; // Pastikan Anda memiliki file styles.dart dengan warna yang telah didefinisikan.

class DosenHomeScreen extends StatelessWidget {
  const DosenHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Home Screen',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.darkBlue,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, AppColors.lightBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(
              context,
              icon: Icons.assignment,
              label: 'Buat Formulir Survei Dosen',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateEditDosenSurveyScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 16.0),
            _buildButton(
              context,
              icon: Icons.book,
              label: 'Buat Formulir Penilaian Mata Kuliah',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateEditCourseSurveyScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 16.0),
            _buildButton(
              context,
              icon: Icons.feedback,
              label: 'Lihat Feedback',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ViewFeedbackScreen(), // Ensure this line does not show any error
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkBlue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      icon: Icon(icon, size: 28.0),
      label: Text(label, style: TextStyle(fontSize: 18.0)),
      onPressed: onPressed,
    );
  }
}
