import 'package:flutter/material.dart';
import 'package:smart_health_project/firebase/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailConteroller = TextEditingController();
    final passConteroller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text("Create an account"),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: emailConteroller,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Email"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              obscureText: true,
              controller: passConteroller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Password"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  AuthMethods().loginUser(
                      email: emailConteroller.text,
                      password: passConteroller.text,
                      context: context);
                },
                child: const Text("Login"))
          ],
        ),
      ),
    );
  }
}
