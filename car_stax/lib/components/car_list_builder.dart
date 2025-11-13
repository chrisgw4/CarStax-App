import "package:flutter/material.dart";
import 'package:mongo_dart/mongo_dart.dart' hide Center, State;

import "../backend/backend_functions.dart";
import "../backend/uris.dart";
import "my_car.dart";




class CarListBuilderStf extends StatefulWidget {
  const CarListBuilderStf({super.key, required this.searchControllers, required this.canSearch, required this.resetSearch, required this.setSearch});

  final List<TextEditingController> searchControllers;
  final bool Function () canSearch;
  final void Function () resetSearch;
  final void Function () setSearch;

  @override
  State<CarListBuilderStf> createState() => _CarListBuilderStfState();
}

class _CarListBuilderStfState extends State<CarListBuilderStf> {
  late Db db;
  Stream? changeStream;
  Stream? changeStreamRental;
  bool allowStream = true;


  @override
  void initState() {
    super.initState();
    _initMongoDBStream();
  }

  Future<void> _initMongoDBStream() async {

    db = await Db.create(
      mongo_db,
    );
    await db.open();

    final collection = db.collection('cars');
    final collection2 = db.collection('rentals');

    final pipeline = [
      {
        '\$match': {
          '\$or': [
            {'operationType': 'insert'},
            {'operationType': 'delete'},
            {'operationType': 'update'},
          ],
        },
      },
    ];

    // Checks for deletions
    changeStream = collection.watch(pipeline);
    changeStreamRental = collection2.watch(pipeline);

    var controller2 = changeStream?.listen((changeEvent) async {
      await Future.delayed(Duration(milliseconds: 800));
      allowStream = true;
      print("Change Happened");
    });

    var controller = changeStreamRental?.listen((changeEvent) async {
      await Future.delayed(Duration(milliseconds: 800));
      allowStream = true;
      print("Change Happened");
    });

    print("Set up streaming");

    // widget.searchText.addListener(() {
    //   print(widget.searchText.text);
    //   print(widget.boolList[0]);
    //
    //   if (widget.boolList[0] == true) {
    //     widget.boolList[0] = false;
    //     widget.searchText.text = widget.searchText.text.substring(0, widget.searchText.text.length-1);
    //     allowStream = true;
    //   }
    //   widget.boolList[0] = false;
    // });

  }

  // Will only return when allowStream is true
  Future<bool> getCanStream() async {
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      if (widget.canSearch() == true)
      {
        widget.resetSearch();
        allowStream = true;
      }


      if (allowStream == true) {
        return allowStream;
      }
    }
  }

  // Will return a stream of the cars to allow for live updating
  Stream<Map<dynamic, dynamic>> streamCars () async* {
    while (true) {
      await getCanStream(); // Waits until allowStream changes to true
      await Future.delayed(Duration(milliseconds: 200));
      allowStream = false;
      var cars = await backend_search_cars(widget.searchControllers);
      yield cars; // Sends back stream of cars
      }
  }

  bool canSearch() {

    // if (widget.boolList[0] == true) {
    //   print("TRUTH");
    //   widget.boolList[0] = false;
    //   allowStream == true;
    // }
    return allowStream;
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamCars(),
      builder: (context, snapshot) {

        if (snapshot.data == null) {
          return Column(
            children: [
              SizedBox(height: 20,),
              Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ],
          );
        }

        List carList = snapshot.data?["cars"];

        // return Expanded(
           return ListView.builder(
            itemCount: carList.length,
            itemBuilder: (context, index) {
              List<dynamic> stringList = carList[index]["warningLightIndicators"];

              if (index == 0) {
                return Container(
                  padding: EdgeInsets.only(top: 80),

                  child: Column(
                    children: [
                      MyCar(
                        carType: carList[index]["carType"],
                        licensePlate: carList[index]["licensePlate"],
                        year: carList[index]["year"],
                        mileage: carList[index]["mileage"],
                        make: carList[index]["make"],
                        model: carList[index]["model"],
                        color: carList[index]["color"],
                        VIN: carList[index]["vehicleIdentificationNumber"],
                        rentalStatus: carList[index]["rentalStatus"],
                        warningLightIndicators: stringList,
                        carID: carList[index]["_id"],
                        signalUpdateFunction: widget.setSearch,
                      ),
                    ],
                  ),
                );
              }

              if (index == carList.length - 1) {
                return Container(
                  padding: EdgeInsets.only(top: 10, bottom: 40),

                  child: Column(
                    children: [
                      MyCar(
                        carType: carList[index]["carType"],
                        licensePlate: carList[index]["licensePlate"],
                        year: carList[index]["year"],
                        mileage: carList[index]["mileage"],
                        make: carList[index]["make"],
                        model: carList[index]["model"],
                        color: carList[index]["color"],
                        VIN: carList[index]["vehicleIdentificationNumber"],
                        rentalStatus: carList[index]["rentalStatus"],
                        warningLightIndicators: stringList,
                        carID: carList[index]["_id"],
                        signalUpdateFunction: () {

                        },
                      ),
                    ],
                  ),
                );
              }

              return Container(
                padding: EdgeInsets.only(top: 10),

                child: Column(
                  children: [
                    MyCar(
                      carType: carList[index]["carType"],
                      licensePlate: carList[index]["licensePlate"],
                      year: carList[index]["year"],
                      mileage: carList[index]["mileage"],
                      make: carList[index]["make"],
                      model: carList[index]["model"],
                      color: carList[index]["color"],
                      VIN: carList[index]["vehicleIdentificationNumber"],
                      rentalStatus: carList[index]["rentalStatus"],
                      warningLightIndicators: stringList,
                      carID: carList[index]["_id"],
                      signalUpdateFunction: widget.setSearch,
                    ),
                  ],
                ),
              );
            },
          // ),
        );
      }
    );
  }
}