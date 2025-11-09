import "package:flutter/material.dart";


class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final double fontSize;

  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
    this.fontSize=30,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF22577A),Color(0xFF6CDD99) ]),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(25),
        child: Center(

            child: Stack(children:
              [

          Text(
            text,
            style:  TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
              color: Colors.white,

            ),
          ),


              ]
          ),
        ),
      ),
    );
  }
}
