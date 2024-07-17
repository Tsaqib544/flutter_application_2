import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/register_screen.dart';
import 'package:flutter_application_2/dosen_home_screen.dart';
import 'package:flutter_application_2/course_selection_screen.dart';
import 'package:flutter_application_2/styles.dart';
import 'package:flutter_application_2/widget/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isObscure = true;
  String? errorMessage;

  void validateAndLogin() async {
    setState(() {
      errorMessage = null;
    });

    if (emailController.text.isEmpty && passwordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Email dan Password tidak boleh kosong';
      });
    } else if (emailController.text.isEmpty) {
      setState(() {
        errorMessage = 'Email tidak boleh kosong';
      });
    } else if (passwordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Password tidak boleh kosong';
      });
    } else {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Retrieve user role from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        if (userDoc.exists) {
          String role = userDoc['role'];

          if (role == 'admin') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DosenHomeScreen()),
            );
          } else if (role == 'user') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CourseSelectionScreen()),
            );
          }
        } else {
          setState(() {
            errorMessage = 'User document does not exist';
          });
        }
      } catch (e) {
        setState(() {
          errorMessage = 'Login gagal: ${e.toString()}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyles.title,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/gambar/Login.png'),
              const SizedBox(height: 24.0),
              Text(
                'Login',
                style: TextStyles.title.copyWith(fontSize: 20.0),
              ),
              const SizedBox(height: 24.0),
              CustomTextfield(
                controller: emailController,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                hint: 'Email or Username',
              ),
              const SizedBox(height: 24.0),
              CustomTextfield(
                controller: passwordController,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                hint: 'Password',
                isObscure: isObscure,
                hasSuffix: true,
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
              ),
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 8.0),
              Text('Forgot Password ?', style: TextStyles.body),
              const SizedBox(height: 24.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onPressed: validateAndLogin,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Login',
                    style: TextStyles.title
                        .copyWith(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                'Don\'t have an account ?',
                style: TextStyles.body.copyWith(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },
                child: Text(
                  'Register',
                  style: TextStyles.body.copyWith(
                    fontSize: 18.0,
                    color: AppColors.darkBlue,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
