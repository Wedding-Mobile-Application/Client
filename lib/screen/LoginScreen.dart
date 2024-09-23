import 'package:client/screen/HomeScreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

void handleNavigate(){
  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Handle button press
            handleNavigate();
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
