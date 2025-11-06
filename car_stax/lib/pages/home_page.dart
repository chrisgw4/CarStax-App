import 'package:car_stax/components/car_list_builder.dart';
import 'package:car_stax/components/my_car.dart';
import 'package:car_stax/pages/car_list_page.dart';
import 'package:flutter/material.dart';

import '../backend/backend_functions.dart';
import 'add_car_page.dart';
import 'login_page.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Temp Home Page")
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        actions: <Widget>[
          IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                builder: (context) => const AddCarPage(),
              )
            );

          },
          tooltip: 'Add Car', // Optional: provides a tooltip on long press
          ),
        ],
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BackButton(
              onPressed: () {
                is_logged_in = false;
                Navigator.of(context).pop();
              },
            ),
          ],
        )
      ),
      body: Center(
        child: Container(

          decoration: BoxDecoration(


          ),
          padding: EdgeInsets.only(left: 48, right: 48,),
          child: Column(
            // Centers Text
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text("Temp Home Page"),
              // CarListBuilder(),
              CarListBuilderStf(),


            ],
          ),
        ),
      ),
    );
  }
}
