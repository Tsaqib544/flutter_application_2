import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_screen.dart';
import 'login_mahasiswa_screen.dart';
import 'styles.dart';  

class LoginOptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Options', style: TextStyles.title.copyWith(color: Colors.white)),
        centerTitle: true,
        backgroundColor: AppColors.darkBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Image.asset('assets/gambar/login_options.png', height: 150.0),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              onPressed: () {
                Get.to(() => LoginDosenScreen());
              },
              child: Text(
                'Login sebagai Admin',
                style: TextStyles.title.copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              onPressed: () {
                Get.to(() => LoginMahasiswaScreen());
              },
              child: Text(
                'Login sebagai Mahasiswa',
                style: TextStyles.title.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
