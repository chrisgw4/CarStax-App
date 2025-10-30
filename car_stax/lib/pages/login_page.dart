import 'package:car_stax/backend/backend_functions.dart';
import 'package:car_stax/components/my_textfield.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';


class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();


  void forgotPassword() async {
    print("Run Forgot Password Code");
  }

  void login() async {

    if (emailController.text == "") {
      print("No email input");
      return;
    }

    if (passwordController.text == "") {
      print("No password input");
      return;
    }

    backend_login(emailController.text, passwordController.text);

    print("Attempting Login");

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(
                child: Text("Image goes here"),
              ),

              SizedBox(height: 50,),

              // Email text input
              MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController
              ),

              // Separator
              SizedBox(height: 10,),

              // Password text input
              MyTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController
              ),

              // Separator
              const SizedBox(height: 10,),

              // forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: forgotPassword,
                    child: Text("Forgot Password?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  )

                ],
              ),

              const SizedBox(height: 5,),

              // sign in button
              MyButton(text: "Login", onTap: login),

              const SizedBox(height: 10,),
              // don't have an account? register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Register Here",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}



