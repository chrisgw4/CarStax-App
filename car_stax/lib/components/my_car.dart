import "package:car_stax/pages/edit_car_page.dart";
import "package:flutter/material.dart";

class MyCar extends StatelessWidget {
  MyCar({
    super.key,
    required this.carType,
    required this.licensePlate,
    required this.year,
    required this.mileage,
    required this.make,
    required this.model,
    required this.color,
    required this.VIN,
    required this.rentalStatus,
  });

  final String carType;
  final String licensePlate;
  final int year;
  final int mileage;
  final String make;
  final String model;
  final String color;
  final String VIN;
  final String rentalStatus;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Pressed Car Item");
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
              vin: VIN,
              carType: carType,
              rentalStatus: rentalStatus,
              warningList: [],
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Make: " + make),
                  SizedBox(width: 20),
                  Text("Model: " + model),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Car Type: " + carType),
                  SizedBox(width: 20),
                  Text("Color: " + color),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("License Plate: " + licensePlate)],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Year: " + year.toString()),
                  SizedBox(width: 20),
                  Text("Mileage: " + mileage.toString()),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("VIN: " + VIN)],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Rental Status: " + rentalStatus)],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
