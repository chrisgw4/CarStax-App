import "package:car_stax/pages/edit_car_page.dart";
import "package:car_stax/pages/view_car_page.dart";
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
    required this.warningLightIndicators,
    required this.carID,
  });

  final String carID;

  final String carType;
  final String licensePlate;
  final int year;
  final int mileage;
  final String make;
  final String model;
  final String color;
  final String VIN;
  final String rentalStatus;
  String image = "";
  final List<dynamic> warningLightIndicators;

  @override
  Widget build(BuildContext context) {
    switch (carType) {
      case "sedan":
        image = "https://farrukhanwar.site/assets/sedan-BfLnftng.png";
        break;
      case "suv":
        image = "https://farrukhanwar.site/assets/suv-DHEXZqaC.png";
        break;
      case "truck":
        image = "https://farrukhanwar.site/assets/truck-DWk2EocT.png";
        break;

      case "coupe":
        image = "https://farrukhanwar.site/assets/coupe-DpR66DVc.png";
        break;

      case "convertible":
        image = "https://farrukhanwar.site/assets/convertible-D5rVBvli.png";
        break;

      case "hatchback":
        image = "https://farrukhanwar.site/assets/hatchback-Bz_gbJNw.png";
        break;

      case "van":
        image ="https://farrukhanwar.site/assets/van-D86uPqS3.png";
        break;

      case "motorcycle":
        image = "https://farrukhanwar.site/assets/motorcycle-BLOPTAqK.png";
        break;

      case "other":
        image = "https://farrukhanwar.site/assets/other-Db6NQrY2.png";
        break;

      default:
        image = "https://farrukhanwar.site/assets/sedan-BfLnftng.png";
        break;
    }

    return GestureDetector(
      onTap: () {
        print("Pressed Car Item");
        print(warningLightIndicators);
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => ViewCarPage(
                licensePlate: licensePlate,
                year: year,
                mileage: mileage,
                make: make,
                model: model,
                color: color,
                vin: VIN,
                carType: carType,
                rentalStatus: rentalStatus,
                warningList: warningLightIndicators,
                carID: carID
            )
            // builder: (context) => EditCarPage(
            //   licensePlate: licensePlate,
            //   year: year,
            //   mileage: mileage,
            //   make: make,
            //   model: model,
            //   color: color,
            //   vin: VIN,
            //   carType: carType,
            //   rentalStatus: rentalStatus,
            //   warningList: warningLightIndicators,
            //   carID: carID,
            // ),
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
                  SizedBox(width: 15),
                  Container(child: Image.network(image, color: Theme.of(context).colorScheme.inverseSurface,),height: 100),
                  SizedBox(width: 25),
                  Expanded(child:
                  Column(children: [

                  Text(make + " " + model,textAlign:TextAlign.center,overflow: null  ,style: TextStyle(fontSize: 25 ),),
                    Text( carType[0].toUpperCase() + carType.substring(1),overflow: null  ,style: TextStyle(fontSize: 15 ,  ),), ]
                  ),
                    //Text(make + " " + model,overflow: null  ,style: TextStyle(fontSize: 25 ),),

                  )

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
