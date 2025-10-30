import 'package:flutter/material.dart';

import 'login_page.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            is_logged_in = false;
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(),
        child: Center(
          child: Container(
            padding: EdgeInsets.only(left: 48, right: 48),
            child: Column(
              // Centers Text
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Temp Home Page")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
