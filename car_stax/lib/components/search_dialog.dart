import 'package:car_stax/components/car_type_dropdown.dart';
import 'package:car_stax/components/rental_status_dropdown.dart';
import 'package:flutter/material.dart';

import '../backend/backend_functions.dart';
import '../pages/add_car_page.dart';
import 'my_button.dart';
import 'my_textfield.dart';

class SearchDialog extends StatelessWidget {
  SearchDialog({
    super.key,
    required this.makeController,
    required this.modelController,
    required this.yearController,
    required this.carTypeController,
    required this.rentalStatusController,
    required this.onSearchPressed,
  });

  final void Function() onSearchPressed;

  final TextEditingController makeController;
  final TextEditingController modelController;
  final TextEditingController yearController;
  final TextEditingController carTypeController;
  final TextEditingController rentalStatusController;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 12),
        child: SingleChildScrollView(
          child: SizedBox(
            width: 300,
            height: 700,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 5),
                Text("Search Cars", style: TextStyle(fontSize: 20)),
                Divider(),
          
                SizedBox(height: 7),
          
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [SizedBox(width: 7,),Text("Brand Name")],
                    ),
          
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(14.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0.4,
                            blurRadius: 2,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1.5,
                        ),
                      ),
                      child: MyTextField(
                        hintText: "Toyota",
                        obscureText: false,
                        controller: makeController,
                      ),
                    ),
                  ],
                ),
          
          
                SizedBox(height: 7),
          
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [SizedBox(width: 7,),Text("Model")],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(14.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0.4,
                            blurRadius: 2,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1.5,
                        ),
                      ),
                      child: MyTextField(
                        hintText: "Camry",
                        obscureText: false,
                        controller: modelController,
                      ),
                    ),
                  ],
                ),
          
                SizedBox(height: 7),
          
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [SizedBox(width: 7,),Text("Year")],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(14.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0.4,
                            blurRadius: 2,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1.5,
                        ),
                      ),
                      child: MyTextField(
                        hintText: "2018",
                        obscureText: false,
                        controller: yearController,
                      ),
                    ),
                  ],
                ),
          
          
                SizedBox(height: 10),
          
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [Text("Car Type")],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CarTypeDropdown(carTypeController: carTypeController),
                      ],
                    ),
                  ],
                ),
          
          
                // MyTextField(hintText: "Sedan", obscureText: false, controller: carTypeController),
                SizedBox(height: 10),
          
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [Text("Rental Status")],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RentalStatusDropdown(
                          rentalStatusController: rentalStatusController,
                        ),
                      ],
                    ),
                  ],
                ),
          
          
          
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: 220,
                    height: 70,
                    child: MyButton(
                      text: "Search",
                      fontSize: 18,
                      onTap: () {
                        onSearchPressed();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                )
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}
