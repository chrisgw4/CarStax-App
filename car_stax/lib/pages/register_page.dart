import 'package:car_stax/backend/backend_functions.dart';
import 'package:car_stax/components/register_info_company_name.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_text.dart';
import '../components/my_textfield.dart';
import '../components/register_info.dart';

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

  final TextEditingController confirmPasswordController =
      TextEditingController();

  String success_text = "";

  final TextEditingController registerSuccessText = TextEditingController();

  String userType = "solo";

  double indUserBorderSize = 5;
  double compUserBorderSize = 0;
  double companyBorderSize = 0;

  double indUserHeight = 110;
  double indUserWidth = 110;
  double compUserHeight = 100;
  double compUserWidth = 110;
  double companyHeight = 100;
  double companyWidth = 110;

  Stream<String> textControllerListener(
    TextEditingController controller,
  ) async* {
    // <- here
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      yield controller.value.text;
    }
  }

  Stream<String> userTypeListener() async* {
    // <- here
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      yield userType;
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

    Map<String, dynamic> response = await backend_register(
      email: emailController.text,
      password: passwordController.text,
      companyName: companyNameController.text,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      userType: userType,
    );

    // Check the response of the Register API
    if (response["success"] == true) {
      success_text =
          "Account created successfully, please check your email for a verification link.";
      registerSuccessText.text = success_text;
    } else if (response["success"] == false) {
      success_text = "Account failed to create.";
      registerSuccessText.text = success_text;
    } else if (response["message"] == "User already exists") {
      success_text = "Email is already used.";
      registerSuccessText.text = success_text;
    }

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
          padding: EdgeInsets.all(0),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF22577A), Color(0xFF6CDD99)],
                  ),
                ),
                height: screenHeight,
                width: screenWidth,
              ),
              Column(
                children: [
                  SizedBox(height: screenHeight / 16),
                  Image(
                    image: AssetImage("assets/images/Carstax Title Logo.png"),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  SizedBox(height: screenHeight / 4),
                  Container(
                    height: screenHeight - screenHeight / 4,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.only(
                        topLeft: (Radius.circular(30)),
                        topRight: (Radius.circular(30)),
                      ),
                    ),
                    child: SingleChildScrollView(child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(25.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFF22577A),
                                                Color(0xFF6CDD99),
                                              ],
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          padding: EdgeInsets.all(
                                            indUserBorderSize,
                                          ),

                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                            ),
                                            width: indUserWidth,
                                            height: indUserHeight,
                                            child: Column(
                                              children: [
                                                SizedBox(height: 20),
                                                Image(
                                                  image: NetworkImage(
                                                    "https://farrukhanwar.site/assets/solo-Bto2POrv.png",
                                                  ),
                                                  width: 40,
                                                ),
                                                Text("Individual User"),
                                                SizedBox(height: 5),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      setState(() {
                                        compUserBorderSize = 0;
                                        compUserHeight = 100;
                                        compUserWidth = 110;
                                        indUserHeight = 110;
                                        indUserWidth = 110;
                                        indUserBorderSize = 5;
                                        companyHeight = 100;
                                        companyWidth = 110;
                                        companyBorderSize = 0;
                                      });
                                      userType = "solo";

                                      print(userType);
                                    },
                                  ),

                                  SizedBox(width: 10),

                                  GestureDetector(
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFF22577A),
                                                Color(0xFF6CDD99),
                                              ],
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          padding: EdgeInsets.all(
                                            compUserBorderSize,
                                          ),

                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                            ),
                                            width: compUserWidth,
                                            height: compUserHeight,
                                            child: Column(
                                              children: [
                                                SizedBox(height: 20),
                                                Image(
                                                  image: NetworkImage(
                                                    "https://farrukhanwar.site/assets/join_company-DttSnnG5.png",
                                                  ),
                                                  width: 40,
                                                ),
                                                Text("Join Company"),
                                                SizedBox(height: 5),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      setState(() {
                                        compUserBorderSize = 5;
                                        compUserHeight = 110;
                                        compUserWidth = 110;
                                        indUserHeight = 100;
                                        indUserWidth = 110;
                                        indUserBorderSize = 0;
                                        companyHeight = 100;
                                        companyWidth = 110;
                                        companyBorderSize = 0;
                                      });
                                      userType = "company_member";
                                      print(userType);
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFF22577A),
                                                Color(0xFF6CDD99),
                                              ],
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          padding: EdgeInsets.all(
                                            companyBorderSize,
                                          ),

                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                            ),
                                            width: companyWidth,
                                            height: companyHeight,
                                            child: Column(
                                              children: [
                                                SizedBox(height: 20),
                                                Image(
                                                  image: NetworkImage(
                                                    "https://farrukhanwar.site/assets/create_company-DCiy0iUX.png",
                                                  ),
                                                  width: 40,
                                                ),
                                                Text("Create Company"),
                                                SizedBox(height: 5),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      setState(() {
                                        compUserBorderSize = 0;
                                        compUserHeight = 100;
                                        compUserWidth = 110;
                                        indUserHeight = 100;
                                        indUserWidth = 110;
                                        indUserBorderSize = 0;
                                        companyHeight = 110;
                                        companyWidth = 110;
                                        companyBorderSize = 5;
                                      });
                                      userType = "company_admin";
                                      print(userType);
                                    },
                                  ),
                                ],
                              ),

                              SizedBox(height: 20),

                              StreamBuilder(
                                stream: userTypeListener(),
                                builder: (context, snapshot) {
                                  // Show Company Name
                                  if (snapshot.data == "company_member" ||
                                      snapshot.data == "company_admin") {
                                    if (companyNameController.text == "N/A")
                                      companyNameController.text = "";
                                    return RegisterInfoCompanyName(
                                      firstNameController: firstNameController,
                                      lastNameController: lastNameController,
                                      companyNameController:
                                          companyNameController,
                                      emailController: emailController,
                                      passwordController: passwordController,
                                      confirmPasswordController:
                                          confirmPasswordController,
                                    );
                                  }

                                  // Do not show company name
                                  compUserBorderSize = 0;
                                  compUserHeight = 100;
                                  companyNameController.text = "N/A";
                                  return RegisterInfo(
                                    firstNameController: firstNameController,
                                    lastNameController: lastNameController,
                                    emailController: emailController,
                                    passwordController: passwordController,
                                    confirmPasswordController:
                                        confirmPasswordController,
                                  );
                                },
                              ),

                              const SizedBox(height: 10),

                              StreamBuilder<String>(
                                stream: textControllerListener(
                                  registerSuccessText,
                                ),
                                builder:
                                    (
                                      BuildContext context,
                                      AsyncSnapshot<String> snapshot,
                                    ) {
                                      if (snapshot.hasError) {
                                        return const Text('Error');
                                      } else {
                                        if (snapshot.data == null) {
                                          return Text("");
                                        }
                                        return Text((snapshot.data) as String);
                                      }
                                    },
                              ),

                              const SizedBox(height: 10),

                              // register button
                              MyButton(text: "Register", onTap: register),

                              const SizedBox(height: 10),
                              // don't have an account? register here
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account?",
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.inversePrimary,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: widget.onTap,
                                    child: const Text(
                                      " Login Here",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,)
                      ],
                    ),
                  ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
