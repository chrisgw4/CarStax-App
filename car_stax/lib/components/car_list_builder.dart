import "dart:math";

import "package:flutter/material.dart";
import 'package:mongo_dart/mongo_dart.dart' hide Center, State;

import "../backend/backend_functions.dart";
import "../backend/uris.dart";
import "my_car.dart";




class CarListBuilderStf extends StatefulWidget {
  const CarListBuilderStf({super.key});

  @override
  State<CarListBuilderStf> createState() => _CarListBuilderStfState();
}

class _CarListBuilderStfState extends State<CarListBuilderStf> {
  late Db db;
  Stream? changeStream;

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

    // final pipe = AggregationPipelineBuilder().addStage(
    //   Match(where.oneFrom("operationType", ["insert", "update", "delete"])
    //       .or(where.eq('fullDocument.companyName', "New Company2")))
    // ).build();

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


    changeStream = collection.watch(pipeline);

 

    print("SET UP COLLECTION WATCH");

    // final result = await collection.aggregateToStream(pipeline).toList();
    //
    // print(result);




    setState(() {}); // Trigger rebuild after stream is initialized
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: changeStream,
      builder: (context, snapshot) {

        if (changeStream == null)
          {
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

        print("CHANGED");
        print(snapshot.data);
        return FutureBuilder(
          future: backend_get_cars(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
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
            if (snapshot.hasError) {
              return Text("Error retrieving Cars");
            }
            if (!snapshot.hasData) {
              return Text("No Cars found");
            }

            List carList = snapshot.data["cars"];

            return Expanded(
              child: ListView.builder(
                itemCount: carList.length,
                itemBuilder: (context, index) {
                  List<dynamic> stringList = carList[index]["warningLightIndicators"];

                  if (index == carList.length-1)
                    {
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
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
        // print(snapshot);
        // if (snapshot.hasError) {
        //   return Text("Error retrieving Cars");
        // }
        // if (!snapshot.hasData) {
        //   return Text("No Cars found");
        // }
        // return Text("Nothing here");
      },
    );
  }
}

class CarListBuilder extends StatelessWidget {
  // CarListBuilder({super.key});

  CarListBuilder({super.key}) {}

  Stream getCars() async* {
    // <- here
    while (true) {
      yield await backend_get_cars();
      await Future.delayed(Duration(seconds: 5));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: backend_get_cars(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          );
        }
        if (snapshot.hasError) {
          return Text("Error retrieving Cars");
        }
        if (!snapshot.hasData) {
          return Text("No Cars found");
        }

        List carList = snapshot.data["cars"];

        return Expanded(
          child: ListView.builder(
            key: ValueKey(snapshot.data),
            // physics: NeverScrollableScrollPhysics(),
            // shrinkWrap: true,
            itemCount: carList.length,
            itemBuilder: (context, index) {
              return Container(
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
                      warningLightIndicators: carList[index]["warningLightIndicators"],
                      carID: "",
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
