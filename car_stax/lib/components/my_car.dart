import "package:car_stax/backend/backend_functions.dart";
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
  String wheel = "";
  Color carColor = Colors.black;
  Color rentalColor = Colors.green;
  String rentalImage = "";
  final List<dynamic> warningLightIndicators;

  Future<dynamic> getRenter() async {
    if (rentalStatus == "rented") {
      return await backend_get_renter(carID: carID);
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final screenHeight = mediaQueryData.size.height;
    switch (rentalStatus.toLowerCase()) {
      case "available":
        rentalImage = "https://farrukhanwar.site/assets/available-C_NG3xW-.png";
        rentalColor = Colors.green;

        break;
      case "rented":
        rentalImage = "https://farrukhanwar.site/assets/rented-CFektGni.png";
        rentalColor = Colors.red;

        break;
      case "maintenance":
        rentalImage =
            "https://farrukhanwar.site/assets/maintenance-CUMVvKMO.png";
        rentalColor = Colors.yellow;

        break;
    }
    switch (color.toLowerCase()) {
      case "red":
        carColor = Colors.red;
        break;
      case "blue":
        carColor = Colors.blue;
        break;
      case "yellow":
      case "gold":
        carColor = Colors.yellow;
        break;
      case "black":
        carColor = Colors.black;
        break;
      case "white":
        carColor = Colors.white;
        break;
      case "silver":
      case "grey":
        carColor = Colors.grey;
        break;
      case "orange":
        carColor = Colors.orange;
        break;
      case "green":
        carColor = Colors.green;
        break;
      case "rose gold":
      case "pink":
        carColor = Colors.pink;
        break;
      case "purple":
        carColor = Colors.purple;
        break;
      case "default":
        carColor = Colors.black;
    }
    switch (carType) {
      case "sedan":
        image = "https://farrukhanwar.site/assets/sedan-BfLnftng.png";
        wheel = "assets/images/wheels/sedan_wheels.png";
        break;
      case "suv":
        image = "https://farrukhanwar.site/assets/suv-DHEXZqaC.png";
        wheel = "assets/images/wheels/suv_wheels.png";
        break;
      case "truck":
        image = "https://farrukhanwar.site/assets/truck-DWk2EocT.png";
        wheel = "assets/images/wheels/truck_wheels.png";
        break;

      case "coupe":
        image = "https://farrukhanwar.site/assets/coupe-DpR66DVc.png";
        wheel = "assets/images/wheels/coupe_wheels.png";
        break;

      case "convertible":
        image = "https://farrukhanwar.site/assets/convertible-D5rVBvli.png";
        wheel = "assets/images/wheels/convertible_wheels.png";
        break;

      case "hatchback":
        image = "https://farrukhanwar.site/assets/hatchback-Bz_gbJNw.png";
        wheel = "assets/images/wheels/hatchback_wheels.png";
        break;

      case "van":
        image = "https://farrukhanwar.site/assets/van-D86uPqS3.png";
        wheel = "assets/images/wheels/van_wheels.png";
        break;

      case "motorcycle":
        image = "https://farrukhanwar.site/assets/motorcycle-BLOPTAqK.png";
        wheel = "assets/images/wheels/motorcycle_wheels.png";
        break;

      case "other":
        image = "https://farrukhanwar.site/assets/other-Db6NQrY2.png";
        wheel = "assets/images/wheels/other_wheels.png";
        break;

      default:
        image = "https://farrukhanwar.site/assets/sedan-BfLnftng.png";
        wheel = "assets/images/wheels/sedan_wheels.png";
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
              carID: carID,
            ),
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
                  SizedBox(width: screenWidth / 28),
                  Column(
                    children: [
                      Container(
                        child: Stack(
                          children: [
                            Image.network(image, color: carColor),
                            Image(image: AssetImage(wheel)),
                          ],
                        ),
                        height: screenHeight / 9,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: screenWidth / 82),
                                Container(
                                  child: Image.network(rentalImage),
                                  height: screenHeight / 46,
                                ),
                                SizedBox(width: screenWidth / 82),
                                Text(
                                  rentalStatus[0].toUpperCase() +
                                      rentalStatus.substring(1),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: screenWidth / 82),
                              ],
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: rentalColor,
                            ),
                            height: screenHeight / 37,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: screenWidth / 17),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          make + " " + model,
                          textAlign: TextAlign.center,
                          overflow: null,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          year.toString() +
                              " " +
                              carType[0].toUpperCase() +
                              carType.substring(1),
                          overflow: null,
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),

                    //Text(make + " " + model,overflow: null  ,style: TextStyle(fontSize: 25 ),),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: screenWidth / 3),
                  Container(
                    child: Row(
                      spacing: screenWidth / 90,
                      children: [
                        Column(
                          spacing: screenHeight / 90,
                          children: [
                            Container(
                              child: Image(
                                image: AssetImage(
                                  "assets/images/license plate.png",
                                ),
                                height: screenHeight / 40,
                              ),
                            ),

                            Container(
                              child: Image(
                                image: AssetImage("assets/images/mileage.png"),
                                height: screenHeight / 40,
                              ),
                            ),
                          ],
                        ),

                        Column(
                          spacing: screenHeight / 90,
                          children: [
                            Text(
                              licensePlate,
                              style: TextStyle(
                                fontSize: screenHeight / 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              mileage.toString() + " miles",
                              style: TextStyle(
                                fontSize: screenHeight / 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight / 80),
              if (rentalStatus == "maintenance")
                Row(
                  children: [
                    SizedBox(width: screenWidth / 28),
                    Container(
                      child: Image(
                        image: AssetImage("assets/images/warning.png"),
                      ),
                      height: screenHeight / 40,
                    ),
                    Text(
                      " " +
                          warningLightIndicators.length.toString() +
                          " Issues Present",
                      style: TextStyle(
                        fontSize: screenHeight / 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              if (rentalStatus == "rented")
                Row(
                  children: [
                    SizedBox(width: screenWidth / 28),
                    Container(
                      child: Image(
                        image: AssetImage("assets/images/car key.png"),
                      ),
                      height: screenHeight / 20,
                    ),
                    FutureBuilder(
                    future: getRenter(), 
                      builder: (context,snapshot)
                        {
                          if(snapshot.hasError)
                            {
                              return Text("");
                            }
                          if(!snapshot.hasData)
                            {
                              return Text("");
                            }
                          if(snapshot.data=="")
                            {
                              return Text("");
                            }
                          print(snapshot.data);
                          return Text(snapshot.data["rentals"][0]["renterName"], style: TextStyle(
                            fontSize: screenHeight / 60,
                            fontWeight: FontWeight.bold,
                          ),);

                        }),
                    
                  ],
                ),
              SizedBox(height: 5),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text("Year: " + year.toString()),
              //     SizedBox(width: 20),
              //     Text("Mileage: " + mileage.toString()),
              //   ],
              // ),
              // SizedBox(height: 5),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [Text("VIN: " + VIN)],
              // ),
              // SizedBox(height: 5),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [Text("Rental Status: " + rentalStatus)],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
