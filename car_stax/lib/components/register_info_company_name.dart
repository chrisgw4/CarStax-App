import 'package:flutter/material.dart';

import 'my_textfield.dart';

class RegisterInfoCompanyName extends StatelessWidget {
  RegisterInfoCompanyName({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.companyNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final TextEditingController firstNameController;

  final TextEditingController lastNameController;

  final TextEditingController companyNameController;

  final TextEditingController emailController;

  final TextEditingController passwordController;

  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          controller: companyNameController,
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
    ]);
  }
}
