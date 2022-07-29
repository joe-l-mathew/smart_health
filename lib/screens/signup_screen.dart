import 'package:flutter/material.dart';
import 'package:smart_health_project/firebase/firebase_auth.dart';
import 'package:smart_health_project/functions/show_snackbar.dart';
import 'package:smart_health_project/models/user_model.dart';
import 'package:smart_health_project/screens/login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameConteroller = TextEditingController();
    final emailConteroller = TextEditingController();
    final pass1Conteroller = TextEditingController();
    final pass2Conteroller = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text("Signup"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Center(child: const Text("Create an account")),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: nameConteroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Name"),
              ),
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
                controller: pass1Conteroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Enter a password"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: pass2Conteroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Re-enter password"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => LoginScreen()));
                  },
                  child: Text("Already have an account?")),
              ElevatedButton(
                  onPressed: () {
                    if (nameConteroller.text.isNotEmpty &&
                        emailConteroller.text.isNotEmpty) {
                      if (pass1Conteroller.text == pass2Conteroller.text) {
                        if (pass1Conteroller.text.length < 6) {
                          showSnackbar(context, "Password too short");
                        } else {
                          // print(nameConteroller.text);
                          AuthMethods().createAccount(
                              UserModel(
                                  name: nameConteroller.text,
                                  email: emailConteroller.text),
                              pass1Conteroller.text,
                              context);
                        }
                      } else {
                        showSnackbar(context, "Password not matched");
                      }
                    } else {
                      showSnackbar(context, "Please fill all fields");
                    }
                  },
                  child: const Text("Create Account"))
            ],
          ),
        ));
  }
}
