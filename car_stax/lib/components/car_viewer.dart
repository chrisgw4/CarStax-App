import "dart:math";

import "package:car_stax/backend/backend_functions.dart";
import "package:car_stax/pages/edit_car_page.dart";
import "package:car_stax/pages/view_car_page.dart";
import "package:flutter/material.dart";
import 'package:simple_shadow/simple_shadow.dart';

class CarViewer extends StatelessWidget {
  CarViewer({
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
  DateTime startDate = DateTime.now();
  DateTime returnDate = DateTime.now();
  final List<dynamic> warningLightIndicators;
  double boxWidth = 3;

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
        rentalColor = Colors.green[400]!;
        rentalColor = Colors.green[400]!;
        boxWidth = 3.3;

        break;
      case "rented":
        rentalImage = "https://farrukhanwar.site/assets/rented-CFektGni.png";
        rentalColor = Colors.red[400]!;
        boxWidth = 3.7;
        break;
      case "maintenance":
        rentalImage =
            "https://farrukhanwar.site/assets/maintenance-CUMVvKMO.png";
        rentalColor = Colors.yellow[300]!;
        boxWidth = 2.5;
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

    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Padding(
        padding: EdgeInsets.all(screenWidth / 48.5),
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  SimpleShadow(
                    color: Colors.black,
                    opacity: 1,
                    sigma: 1,
                    offset: const Offset(0, 1),
                    child: Image.network(image),
                  ),
                  SimpleShadow(
                    color: Colors.black,
                    opacity: 1,
                    sigma: 1,
                    offset: const Offset(0, -1),
                    child: Image.network(image),
                  ),
                  Image.network(image, color: carColor),
                  Image(image: AssetImage(wheel)),
                ],
              ),
              height: screenHeight / 5,
            ),

            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    year.toString() +
                        " " +
                        color +
                        " " +
                        carType[0].toUpperCase() +
                        carType.substring(1),

                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 17),
                  ),
                  FittedBox(
                    child: Text(
                      make + " " + model,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: screenWidth / 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight / 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: screenWidth / 30),
                              Container(
                                child: Image(
                                  image: AssetImage(
                                    "assets/images/mileage.png",
                                  ),
                                  height: screenHeight / 35,
                                ),
                              ),
                              SizedBox(width: screenWidth / 30),
                              Text(
                                " " + mileage.toString() + " miles",
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: screenHeight / 45,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Container(
                                child: Image(
                                  image: AssetImage(
                                    "assets/images/license plate.png",
                                  ),
                                  height: screenHeight / 35,
                                ),
                              ),
                              SizedBox(width: screenWidth / 30),

                              Text(
                                licensePlate,
                                maxLines: 1,

                                style: TextStyle(
                                  fontSize: screenHeight / 45,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight / 100),
                    ],
                  ),
                ),

                SizedBox(width: screenWidth / 28),
                Column(children: [SizedBox(height: 15)]),
                SizedBox(width: screenWidth / 17),
              ],
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    "Status",
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontSize: screenHeight / 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: screenWidth / 82),
                        Container(
                          child: Image.network(rentalImage),
                          height: screenHeight / 36,
                        ),
                        SizedBox(width: screenWidth / 82),
                        Text(
                          rentalStatus[0].toUpperCase() +
                              rentalStatus.substring(1),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: screenWidth / 50),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(175), // Shadow color
                          spreadRadius: 0.5, // How far the shadow spreads
                          blurRadius: 2.5, // How blurred the shadow is
                          offset: Offset(
                            0,
                            3,
                          ), // Changes position of shadow (dx, dy)
                        ),
                      ],
                      color: rentalColor,
                    ),
                    height: screenHeight / 27,
                    width: screenWidth / boxWidth,
                  ),
                  SizedBox(height: screenHeight / 70),
                  Text(
                    "VIN",
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontSize: screenHeight / 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    VIN,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontSize: screenHeight / 52,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (rentalStatus == "rented"|| rentalStatus =="maintenance")
              Divider(),
            if (rentalStatus == "rented")
              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Renter Infomation",
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: screenHeight / 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    FutureBuilder(
                      future: getRenter(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("");
                        }
                        if (!snapshot.hasData) {
                          return Text("");
                        }
                        if (snapshot.data == "") {
                          return Text("");
                        }
                        startDate = DateTime.parse(
                          snapshot.data["rentals"][0]["dateRentedOut"],
                        );
                        returnDate = DateTime.parse(
                          snapshot.data["rentals"][0]["expectedReturnDate"],
                        );
                        // print(returnDate);
                        // print(DateTime.now().isAfter(returnDate));
                        return Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                height: screenHeight / 20,
                                image: AssetImage("assets/images/Calender.png"),
                              ),
                              SizedBox(width: screenWidth / 60),
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      startDate.month.toString() +
                                          "/" +
                                          startDate.day.toString() +
                                          "/" +
                                          startDate.year.toString(),
                                      style: TextStyle(
                                        fontSize: screenWidth / 23,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: screenWidth / 82),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.lightGreen[50],
                                ),
                                height: screenHeight / 37,
                              ),
                              Text(
                                " To ",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    SizedBox(width: screenWidth / 82),
                                    Text(
                                      returnDate.month.toString() +
                                          "/" +
                                          returnDate.day.toString() +
                                          "/" +
                                          returnDate.year.toString(),
                                      style: TextStyle(
                                        fontSize: screenWidth / 23,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: screenWidth / 82),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.lightGreen[50],
                                ),
                                height: screenHeight / 37,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: screenHeight / 80),
            if (rentalStatus == "maintenance")
              Center(child:
              Text(
                "Issues",
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: screenHeight / 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ),
              for (String warning in warningLightIndicators)
              Column(children: [
              Row(
                children: [
                  SizedBox(width: screenWidth / 35),
                  Container(
                    child: Image(
                      image: AssetImage("assets/images/warning.png"),
                    ),
                    height: screenHeight / 35,
                  ),
                  Text(
                    " " +
                        warning,
                    style: TextStyle(
                      fontSize: screenHeight / 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),SizedBox(height: screenHeight / 70),]),

            if (rentalStatus == "rented")
              Row(
                children: [
                  Container(
                    child: Image(
                      image: AssetImage("assets/images/car key.png"),
                    ),
                    height: screenHeight / 15,
                  ),
                  FutureBuilder(
                    future: getRenter(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("");
                      }
                      if (!snapshot.hasData) {
                        return Text("");
                      }
                      if (snapshot.data == "") {
                        return Text("");
                      }
                      startDate = DateTime.parse(
                        snapshot.data["rentals"][0]["dateRentedOut"],
                      );
                      returnDate = DateTime.parse(
                        snapshot.data["rentals"][0]["expectedReturnDate"],
                      );
                      // print(returnDate);
                      // print(DateTime.now().isAfter(returnDate));
                      return Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                snapshot.data["rentals"][0]["renterName"],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: screenHeight / 48,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            if (DateTime.now().isAfter(returnDate))
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: screenWidth / 82),
                                    Container(
                                      child: Image(
                                        image: AssetImage(
                                          "assets/images/Late.png",
                                        ),
                                      ),
                                      height: screenHeight / 36,
                                    ),
                                    SizedBox(width: screenWidth / 82),
                                    Text(
                                      "Overdue",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: screenWidth / 82),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red[400],
                                  border: Border.all(color: Colors.black),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withAlpha(
                                        175,
                                      ), // Shadow color
                                      spreadRadius:
                                          0.5, // How far the shadow spreads
                                      blurRadius:
                                          2.5, // How blurred the shadow is
                                      offset: Offset(
                                        0,
                                        3,
                                      ), // Changes position of shadow (dx, dy)
                                    ),
                                  ],
                                ),
                                height: screenHeight / 27,
                              )
                            else if (!(DateTime.now().isAfter(returnDate)))
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    SizedBox(width: screenWidth / 82),
                                    Container(
                                      child: Image(
                                        image: AssetImage(
                                          "assets/images/On Time.png",
                                        ),
                                      ),
                                      height: screenHeight / 36,
                                    ),
                                    SizedBox(width: screenWidth / 82),
                                    Text(
                                      "On Time",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: screenWidth / 82),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green[400],
                                  border: Border.all(color: Colors.black),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withAlpha(
                                        175,
                                      ), // Shadow color
                                      spreadRadius:
                                          0.5, // How far the shadow spreads
                                      blurRadius:
                                          2.5, // How blurred the shadow is
                                      offset: Offset(
                                        0,
                                        3,
                                      ), // Changes position of shadow (dx, dy)
                                    ),
                                  ],
                                ),
                                height: screenHeight / 27,
                              ),
                            SizedBox(width: screenWidth / 30),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            if (rentalStatus == "rented")
              Row(
                children: [
                  Container(
                    child: Image(image: AssetImage("assets/images/Email.png")),
                    height: screenHeight / 15,
                  ),
                  FutureBuilder(
                    future: getRenter(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("");
                      }
                      if (!snapshot.hasData) {
                        return Text("");
                      }
                      if (snapshot.data == "") {
                        return Text("");
                      }
                      startDate = DateTime.parse(
                        snapshot.data["rentals"][0]["dateRentedOut"],
                      );
                      returnDate = DateTime.parse(
                        snapshot.data["rentals"][0]["expectedReturnDate"],
                      );
                      // print(returnDate);
                      // print(DateTime.now().isAfter(returnDate));
                      return Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                snapshot.data["rentals"][0]["renterEmail"],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: screenHeight / 48,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            if (rentalStatus == "rented")
              Row(
                children: [
                  SizedBox(width: screenWidth / 50),
                  Container(
                    child: Image(image: AssetImage("assets/images/phone.png")),
                    height: screenHeight / 20,
                  ),
                  FutureBuilder(
                    future: getRenter(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("");
                      }
                      if (!snapshot.hasData) {
                        return Text("");
                      }
                      if (snapshot.data == "") {
                        return Text("");
                      }
                      startDate = DateTime.parse(
                        snapshot.data["rentals"][0]["dateRentedOut"],
                      );
                      returnDate = DateTime.parse(
                        snapshot.data["rentals"][0]["expectedReturnDate"],
                      );
                      // print(returnDate);
                      // print(DateTime.now().isAfter(returnDate));
                      return Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                snapshot.data["rentals"][0]["renterPhone"],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: screenHeight / 48,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
