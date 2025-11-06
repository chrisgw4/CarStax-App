import 'package:car_stax/backend/backend_functions.dart';
import 'package:flutter/material.dart';

import 'edit_car_page.dart';


class ViewCarPage extends StatelessWidget {
  const ViewCarPage({
    super.key,
    required this.licensePlate,
    required this.year,
    required this.mileage,
    required this.make,
    required this.model,
    required this.color,
    required this.vin,
    required this.carType,
    required this.rentalStatus,
    required this.warningList,
    required this.carID,
  });

  final String licensePlate;
  final int year;
  final int mileage;
  final String make;
  final String model;
  final String color;
  final String vin;
  final String carType;
  final String rentalStatus;
  final List warningList;
  final String carID;

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Confirmation!'),
          content: const Text('Are you sure you want to delete this car?'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    backend_delete_car(carId: carID);
                    Navigator.of(context).pop(); // Dismiss the dialog
                    Navigator.pop(context); // Dismiss the view car page
                  },
                ),
                TextButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Dismiss the dialog
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Car")],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
                size: 35,
              ),
              style: ElevatedButton.styleFrom(),
              onPressed: () {
                // backend_delete_car(carId: carID);
                _showAlertDialog(context);
                // Navigator.pop(context);
              },
              tooltip: 'Delete Car',
            ),

            IconButton(
                onPressed: () {
                  // Do Edit Logic here
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => EditCarPage(
                      licensePlate: licensePlate,
                      year: year,
                      mileage: mileage,
                      make: make,
                      model: model,
                      color: color,
                      vin: vin,
                      carType: carType,
                      rentalStatus: rentalStatus,
                      warningList: warningList,
                      carID: carID,
                    )
                  )
                );

                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.black,
                  size: 35,
                ),
            )
          ],
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          // Insert what the car view page should have Here

          children: [
            Text("PLACEHOLDER"),

            Row(

              children: [


                Text("License Plate: $licensePlate")
              ],
            )
          ],
        ),
      )
    );
  }
}
