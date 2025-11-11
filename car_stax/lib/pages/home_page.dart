import 'dart:math' as math;

import 'package:car_stax/components/car_list_builder.dart';
import 'package:car_stax/components/my_car.dart';
import 'package:car_stax/pages/car_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth_provider.dart';
import '../backend/backend_functions.dart';
import 'add_car_page.dart';
import 'login_page.dart';



class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
           flexibleSpace: Container(
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF48B89F),Color(0xFF38A3A5) ]),borderRadius: BorderRadius.circular(15.0) ),
           ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
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
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: IconButton(
                onPressed: () {
                  ref.read(authProvider.notifier).logout();
                },
                icon: Icon(Icons.logout,),
              ),
              
            )
            
            // BackButton(
            //   onPressed: () {
            //     ref.read(authProvider.notifier).logout();
            //   },
            // ),
          ],
        )
      ),
      body: Center(
        child: Container(

          decoration: BoxDecoration(


          ),
          padding: EdgeInsets.only(left: 12, right: 12,),
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
