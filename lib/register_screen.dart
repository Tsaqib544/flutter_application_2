import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/login_screen.dart';
import 'package:flutter_application_2/styles.dart';
import 'package:flutter_application_2/widget/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isObscure = true;
  String? errorMessage;
  String? selectedRole;
  final List<String> roles = ['admin', 'user'];

  void validateAndRegister() async {
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
    } else if (selectedRole == null) {
      setState(() {
        errorMessage = 'Role harus dipilih';
      });
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Save user info to Firestore
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'name': nameController.text,
          'email': emailController.text,
          'role': selectedRole,
        });

        // Navigate to Login Screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      } catch (e) {
        setState(() {
          errorMessage = 'Registrasi gagal: ${e.toString()}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
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
              Image.asset('assets/gambar/Register.png'),
              const SizedBox(height: 24.0),
              Text(
                'Register',
                style: TextStyles.title.copyWith(fontSize: 20.0),
              ),
              const SizedBox(height: 24.0),
              CustomTextfield(
                controller: nameController,
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
                hint: 'Full Name',
              ),
              const SizedBox(height: 24.0),
              CustomTextfield(
                controller: emailController,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                hint: 'Email',
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
              const SizedBox(height: 24.0),
              DropdownButtonFormField<String>(
                value: selectedRole,
                hint: Text('Select Role'),
                items: roles.map((String role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedRole = newValue;
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
              const SizedBox(height: 24.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onPressed: validateAndRegister,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Register',
                    style: TextStyles.title
                        .copyWith(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                'Already have an account?',
                style: TextStyles.body.copyWith(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                child: Text(
                  'Login',
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
