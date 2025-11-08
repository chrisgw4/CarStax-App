import 'package:car_stax/backend/backend_functions.dart';
import 'package:car_stax/components/my_textfield.dart';
import 'package:car_stax/pages/home_page.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../main.dart';


bool is_logged_in = false;

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool attempting_login = false;


  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController loginFailedText = TextEditingController();


  Stream<String> textControllerListener(TextEditingController controller) async* { // <- here
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      yield controller.value.text;
    }
  }


  void forgotPassword() async {
    print("Run Forgot Password Code");
  }

  void login() async {

    if (is_logged_in) {
      return;
    }

    if (attempting_login) {
      return;
    }
    attempting_login = true;

    if (emailController.text == "") {
      print("No email input");
      attempting_login = false;
      loginFailedText.text = "Please enter all fields.";
      return;
    }

    if (passwordController.text == "") {
      print("No password input");
      attempting_login = false;
      loginFailedText.text = "Please enter all fields.";
      return;
    }

    // show loading circle
    showDialog(
      context: context,
      barrierDismissible: false, // Make it so it doesn't disappear on tap
      builder: (context) => const Center(child: CircularProgressIndicator(),
      ), //center
    );

    Map<String, dynamic> return_value = await backend_login(emailController.text, passwordController.text);

    if (context.mounted) {
      Navigator.pop(context);
    }

    if (return_value["success"] == true)
      {
        passwordController.text = "";
        // Go to home page
        Navigator.push(context, MaterialPageRoute<void>(
          builder: (context) => const HomePage(),
        )
        );
        is_logged_in = true;
      }
    else if(return_value["success"] == false)
      {
        if (return_value["message"] == "Email is not verified") {
          loginFailedText.text = "Email is not verified.";
        }
        else
          {
            loginFailedText.text = "Invalid credentials.";
          }
      }


    attempting_login = false;
    print("Attempting Login");

    return;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final screenHeight = mediaQueryData.size.height;
    return Scaffold(

      body: Center(
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: Stack(
           children: [
             Container(

               decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF22577A),Color(0xFF6CDD99) ]), ),
               height: screenHeight,
               width: screenWidth,
             ),
              Column(
                children: [SizedBox(height:screenHeight/10 ),Image(image: AssetImage("assets/images/Carstax Title Logo.png"),),],
              ),

              Container(

                child: Column(
                children: [
                  SizedBox(height: screenHeight/3),
                  Container(
                    height: screenHeight- screenHeight/3,
                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface,borderRadius: BorderRadius.only(topLeft: (Radius.circular(30)), topRight: (Radius.circular(30)) )),
                    child: Column(children: [

              Padding(padding: EdgeInsets.all(25.0),

              child: Column(
                children: [
                  Text(
                  "Sign In",
                  style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,


                  ),),
                  SizedBox(height: 30),
              // Email text input
              MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: emailController
              ),

              // Separator
              SizedBox(height: 10,),

              StreamBuilder(
                  stream: textControllerListener(passwordController),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    // Password text input
                    return MyTextField(
                        hintText: "Password",
                        obscureText: true,
                        controller: passwordController
                    );
                  }
              ),


              // Separator
              const SizedBox(height: 10,),


              StreamBuilder<String>(
                  stream: textControllerListener(loginFailedText),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else {
                      if (snapshot.data == null)
                        {
                          return Text("");
                        }
                      return Text((snapshot.data) as String);
                    }
                  }),

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
                  ]
              )
              )
                      ]
                    )
                  )

                ]

              )

             )
            ],
          ),
        ),
      ),
    );
  }
}



