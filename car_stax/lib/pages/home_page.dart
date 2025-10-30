import 'package:flutter/material.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

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
