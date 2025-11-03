import 'package:car_stax/backend/backend_functions.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_text.dart';
import '../components/my_textfield.dart';


class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController companyNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();

  String success_text = "";

  final TextEditingController registerSuccessText = TextEditingController();


  Stream<String> textControllerListener(TextEditingController controller) async* { // <- here
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      yield controller.value.text;
    }
  }

  void register() async {

    if (firstNameController.text == "") {
      print("No firstName input");
      return;
    }

    if (lastNameController.text == "") {
      print("No lastName input");
      return;
    }

    if (companyNameController.text == "") {
      print("No companyName input");
      return;
    }

    if (emailController.text == "") {
      print("No email input");
      return;
    }

    if (passwordController.text == "") {
      print("No password input");
      return;
    }

    if (confirmPasswordController.text == "") {
      print("No confirm password input");
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      print("Passwords do not match");
      return;
    }

    print("Attempting to register");

    Map<String, dynamic> response = await backend_register(email: emailController.text, password: passwordController.text,
        companyName: companyNameController.text, firstName: firstNameController.text,
        lastName: lastNameController.text);


    // Check the response of the Register API
    if (response["success"] == true)
      {
        success_text = "Account created successfully, please check email for verification link.";
        registerSuccessText.text = success_text;
      }
    else if (response["success"] == false)
      {
        success_text = "Account failed to create.";
        registerSuccessText.text = success_text;
      }
    else if (response["message"] == "User already exists")
      {
        success_text = "Email is already used.";
        registerSuccessText.text = success_text;
      }


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

              Row(
                children: [
                  Expanded(
                      child:
                      // firstName text field
                      MyTextField(
                        hintText: "First Name",
                        obscureText: false,
                        controller: firstNameController
                      ),
                  ),

                  SizedBox(width: 15,),
                  
                  Expanded(
                    child:
                    // lastName text field
                    MyTextField(
                        hintText: "Last Name",
                        obscureText: false,
                        controller: lastNameController
                    ),
                  ),
                ],
              ),


              const SizedBox(height: 10,),

              // companyName text field
              MyTextField(
                  hintText: "Company Name",
                  obscureText: false,
                  controller: companyNameController
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

              // Text(success_text),
              StreamBuilder<String>(
                  stream: textControllerListener(registerSuccessText),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else {
                      return Text((snapshot.data) as String);
                    }
                  }),


              const SizedBox(height: 10,),

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
