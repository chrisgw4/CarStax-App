import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';


class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();

  void register() async {
    print("Attempting to register");

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(
                child: Text("Image goes here"),
              ),

              SizedBox(height: 50,),

              // email text field
              MyTextField(
                  hintText: "Username",
                  obscureText: false,
                  controller: usernameController
              ),

              const SizedBox(height: 10,),
              // email text field
              MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController
              ),


              const SizedBox(height: 10,),
              // password text field

              MyTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController
              ),

              const SizedBox(height: 10,),
              MyTextField(
                  hintText: "Confirm Password",
                  obscureText: true,
                  controller: confirmPasswordController
              ),

              const SizedBox(height: 10,),

              // forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Forgot Password?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ],
              ),

              // register button
              MyButton(text: "Register", onTap: register),

              const SizedBox(height: 10,),
              // don't have an account? register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Login Here",
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
