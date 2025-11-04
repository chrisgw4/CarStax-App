import "package:flutter/material.dart";

import "../backend/backend_functions.dart";
import "my_car.dart";


class CarListBuilder extends StatelessWidget {
  const CarListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: backend_get_cars(),
        builder: (context, AsyncSnapshot snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.inversePrimary,
                )
            );
          }
          if (snapshot.hasError)
            {
              return Text("Error retrieving Cars");
            }
          if (!snapshot.hasData)
            {
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
                              rentalStatus: carList[index]["rentalStatus"]
                          ),
                          SizedBox(height: 10,)
                        ],
                      ),
                    );
                  }
              )
          );
        }
    );
  }
}
