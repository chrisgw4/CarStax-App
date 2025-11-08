import 'package:car_stax/backend/backend_functions.dart';
import 'package:car_stax/components/my_button.dart';
import 'package:car_stax/components/my_textfield.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});


  final TextEditingController emailController = TextEditingController();

  bool response = false;

  Stream<String> watchResetPassword() async* {
    while(true) {
      await Future.delayed(Duration(milliseconds: 10));

      if (response) {
        yield "Forgot Password Email Sent!";
      }
      else {
        yield "";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.only(left: 30, right: 30, top: 12, bottom: 12),
        child: SizedBox(
          width: 350,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 20,),
              Text("Forgot Password",
                style: TextStyle(fontSize: 20),
              ),

              SizedBox(height: 10,),

              MyTextField(hintText: "Enter Email", obscureText: false, controller: emailController),


              StreamBuilder(
                  stream: watchResetPassword(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError)
                      {
                        return Text("");
                      }
                    if (!snapshot.hasData) {
                      return Text("");
                    }
                    String? data = snapshot.data;
                    return Text(data!);
                  }
              ),


              MyButton(
                  text: "Forgot Password",
                  fontSize: 20,
                  onTap: () async {
                    Map<String, dynamic> map = await backend_forgot_password(email: emailController.text);
                    response = map["success"];
                  }
              ),

            ],
          )
        ),
      ),
    );
  }
}
