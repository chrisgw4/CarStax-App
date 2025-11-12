import 'dart:ffi';

import 'package:car_stax/backend/backend_functions.dart';
import 'package:car_stax/components/my_text.dart';
import 'package:car_stax/components/my_textfield.dart';
import 'package:car_stax/components/renter_info.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

typedef CarEntry = DropdownMenuEntry<CarType>;

// DropdownMenuEntry labels and values for the second dropdown menu.
enum CarType {
  sedan(
    'Sedan',
    NetworkImage("https://farrukhanwar.site/assets/sedan-BfLnftng.png"),
  ),
  suv('SUV', NetworkImage("https://farrukhanwar.site/assets/suv-DHEXZqaC.png")),
  truck(
    'Truck',
    NetworkImage("https://farrukhanwar.site/assets/truck-DWk2EocT.png"),
  ),
  coupe(
    'Coupe',
    NetworkImage("https://farrukhanwar.site/assets/coupe-DpR66DVc.png"),
  ),
  convertible(
    'Convertible',
    NetworkImage("https://farrukhanwar.site/assets/convertible-D5rVBvli.png"),
  ),
  hatchback(
    'Hatchback',
    NetworkImage("https://farrukhanwar.site/assets/hatchback-Bz_gbJNw.png"),
  ),
  van('Van', NetworkImage("https://farrukhanwar.site/assets/van-D86uPqS3.png")),
  motorcycle(
    'Motorcycle',
    NetworkImage("https://farrukhanwar.site/assets/motorcycle-BLOPTAqK.png"),
  ),
  other(
    'Other',
    NetworkImage("https://farrukhanwar.site/assets/other-Db6NQrY2.png"),
  );

  const CarType(this.label, this.icon);
  final String label;
  final NetworkImage icon;

  static final List<CarEntry> entries = UnmodifiableListView<CarEntry>(
    values.map<CarEntry>(
      (CarType icon) => CarEntry(
        value: icon,
        label: icon.label,
        leadingIcon: ImageIcon(icon.icon),
      ),
    ),
  );
}

typedef RentalEntry = DropdownMenuEntry<RentalStatus>;

// DropdownMenuEntry labels and values for the second dropdown menu.
enum RentalStatus {
  available(
    'Available',
    NetworkImage("https://farrukhanwar.site/assets/available-C_NG3xW-.png"),
  ),
  rented(
    'Rented',
    NetworkImage("https://farrukhanwar.site/assets/rented-CFektGni.png"),
  ),
  maintenance(
    'Maintenance',
    NetworkImage("https://farrukhanwar.site/assets/maintenance-CUMVvKMO.png"),
  );

  const RentalStatus(this.label, this.icon);
  final String label;
  final NetworkImage icon;

  static final List<RentalEntry> entries = UnmodifiableListView<RentalEntry>(
    values.map<RentalEntry>(
      (RentalStatus icon) => RentalEntry(
        value: icon,
        label: icon.label,
        leadingIcon: ImageIcon(icon.icon),
      ),
    ),
  );
}

class AddCarPage extends StatefulWidget {
  const AddCarPage({super.key});

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final TextEditingController lPLateController = TextEditingController();

  final TextEditingController yearController = TextEditingController();

  final TextEditingController mileageController = TextEditingController();

  final TextEditingController makeController = TextEditingController();

  final TextEditingController modelController = TextEditingController();

  final TextEditingController colorController = TextEditingController();

  final TextEditingController vinController = TextEditingController();

  final TextEditingController carTypeController = TextEditingController();

  final TextEditingController rentalStatusController = TextEditingController();
  CarType? selectedCar;
  RentalStatus? selectedStatus;
  late List<TextEditingController> warningList = [];

  final TextEditingController renterNameController = TextEditingController();
  final TextEditingController renterEmailController = TextEditingController();
  final TextEditingController renterPhoneController = TextEditingController();
  final TextEditingController renterRateController = TextEditingController();

  late DateTime startDate;
  late DateTime returnDate;
  late DateTime actualReturnDate;

  Stream<bool> streamRentalStatus() async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));

      if (selectedStatus?.label == "Rented") {
        yield true;
      } else {
        yield false;
      }
    }
  }

  Stream<bool> streamMaintenanceStatus() async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));

      if (selectedStatus?.label == "Maintenance") {
        yield true;
      } else {
        yield false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // print('Number of entries: ${CarType.entries.length}');
    for (var entry in CarType.entries) {
      // print('Entry label: ${entry.label}, value: ${entry.value}');
    }
    return Scaffold(
      floatingActionButton: Container(
        width: 80,
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF22577A), Color(0xFF6CDD99)],
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: FloatingActionButton(
          tooltip: 'Add Car',
          backgroundColor: Colors.transparent,
          child: Text("Add Car"),
          onPressed: () async {
            print("Pressed add");
            if (yearController.text == "") return;
            if (mileageController.text == "") return;

            List<String> warningListStrings = [];

            for (TextEditingController object in warningList) {
              if (object.text != "") {
                warningListStrings.add(object.text);
              }
            }

            // Adds the car to the backend
            var response = await backend_add_car(
              lPlate: lPLateController.text,
              rentalStatus: rentalStatusController.text,
              currentRental: "",
              year: int.parse(yearController.text),
              color: colorController.text,
              make: makeController.text,
              model: modelController.text,
              mileage: int.parse(mileageController.text),
              repairStatus: "",
              warningLightIndicators: warningListStrings,
              VIN: vinController.text,
              carType: carTypeController.text,
            );

            var responseRenter;
            if (selectedStatus?.label == "Rented") {
              responseRenter = await backend_add_renter(
                carID: response["car"]["_id"],
                renterName: renterNameController.text,
                renterEmail: renterEmailController.text,
                renterPhone: renterPhoneController.text,
                dateRentedOut:
                    "${startDate.month}/${startDate.day}/${startDate.year}",
                expectedReturnDate:
                    "${returnDate.month}/${returnDate.day}/${returnDate.year}",
                actualReturnDate:
                    "${actualReturnDate.month}/${actualReturnDate.day}/${actualReturnDate.year}",
                rentalRatePerDay: renterRateController.text,
                notes: "",
              );
            }

            // Leave the add car page after successfully adding car to database
            if (response["success"] == true) {
              Navigator.pop(context);
            }
          },
        ),
      ),

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: Text("Add a Car"),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        //backgroundColor: Theme.of(context).colorScheme.tertiary,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF48B89F), Color(0xFF38A3A5)],
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 10),
        child: Center(
          child: Container(
            padding: EdgeInsets.only(left: 48, right: 48),
            child: Column(
              // Centers Text
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("License Plate", style: TextStyle(fontSize: 16)),
                MyTextField(
                  hintText: "ABC-1234",
                  obscureText: false,
                  controller: lPLateController,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Year", style: TextStyle(fontSize: 16)),
                          MyTextField(
                            hintText: "2025",
                            obscureText: false,
                            controller: yearController,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Mileage", style: TextStyle(fontSize: 16)),
                          MyTextField(
                            hintText: "0",
                            obscureText: false,
                            controller: mileageController,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Make", style: TextStyle(fontSize: 16)),
                          MyTextField(
                            hintText: "Toyota",
                            obscureText: false,
                            controller: makeController,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Model", style: TextStyle(fontSize: 16)),
                          MyTextField(
                            hintText: "Camry",
                            obscureText: false,
                            controller: modelController,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text("VIN Number", style: TextStyle(fontSize: 16)),
                MyTextField(
                  hintText: "1A2BC34567D890123",
                  obscureText: false,
                  controller: vinController,
                ),

                SizedBox(height: 10),

                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text("Color", style: TextStyle(fontSize: 16)),
                          MyTextField(
                            hintText: "Black",
                            obscureText: false,
                            controller: colorController,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        children: [
                          Text("Car Type", style: TextStyle(fontSize: 16)),
                          DropdownMenu<CarType>(
                            controller: carTypeController,

                            textAlign: TextAlign.center,
                            width: 200,

                            inputDecorationTheme: const InputDecorationTheme(
                              filled: true,

                              prefixIconConstraints: BoxConstraints(
                                minHeight: 40,
                                minWidth: 40,
                              ),

                              contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0,
                              ),
                            ),
                            onSelected: (CarType? icon) {
                              setState(() {
                                selectedCar = icon;
                              });
                            },
                            dropdownMenuEntries: CarType.entries,
                            leadingIcon: ImageIcon(selectedCar?.icon),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),
                Text("Rental Status", style: TextStyle(fontSize: 16)),
                DropdownMenu<RentalStatus>(
                  controller: rentalStatusController,

                  textAlign: TextAlign.center,
                  width: 200,

                  inputDecorationTheme: const InputDecorationTheme(
                    filled: true,

                    prefixIconConstraints: BoxConstraints(
                      minHeight: 40,
                      minWidth: 40,
                    ),

                    contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                  onSelected: (RentalStatus? icon) {
                    setState(() {
                      selectedStatus = icon;
                    });
                  },
                  dropdownMenuEntries: RentalStatus.entries,
                  leadingIcon: ImageIcon(selectedStatus?.icon),
                ),
                SizedBox(height: 10),

                StreamBuilder(
                  stream: streamMaintenanceStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("");
                    }
                    if (!snapshot.hasData) {
                      return Text("");
                    }
                    if (snapshot.data == false) {
                      return Text("");
                    }

                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors
                            .transparent, // Make button background transparent
                        shadowColor:
                            Colors.transparent, // Disable default shadow
                        elevation: 0, // Disable default elevation
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8.0,
                          ), // Match container's border radius
                        ),
                      ),
                      onPressed: openDialog,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF22577A), Color(0xFF6CDD99)],
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: MediaQuery.of(context).size.height / 15,
                        width: MediaQuery.of(context).size.width / 4,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 45,
                            ),
                            Text(
                              "Add Issues",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 25,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                StreamBuilder(
                  stream: streamRentalStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("");
                    }
                    if (!snapshot.hasData) {
                      return Text("");
                    }
                    if (snapshot.data == false) {
                      return Text("");
                    }

                    return RenterInfo(
                      renterNameController: renterNameController,
                      renterEmailController: renterEmailController,
                      renterPhoneController: renterPhoneController,
                      renterRateController: renterRateController,
                      startDateChanged: (DateTime d) {
                        startDate = d;
                      },
                      returnDateChanged: (DateTime d) {
                        returnDate = d;
                      },
                      actualReturnDateChanged: (DateTime d) {
                        actualReturnDate = d;
                      },
                    );
                  },
                ),

                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stream<int> warningListSizeListener() async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      yield warningList.length;
    }
  }

  GlobalKey<AnimatedListState> warningListKey = GlobalKey<AnimatedListState>();

  void removeItem(int index) {
    final removedItem = warningList[index];
    warningList.removeAt(index);

    warningListKey.currentState?.removeItem(
      index,
      (context, animation) => buildItem(removedItem, animation),
    );
  }

  Widget buildItem(controller, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                final index = warningList.indexOf(controller);
                if (index != -1) removeItem(index);

                // warningListKey.currentState?.removeItem(index,
                //     (context, animation) {
                //       animation.addStatusListener((status) {
                //         if (status == AnimationStatus.dismissed) {
                //           warningList.remove(controller);
                //         }
                //       });
                //         return buildItem(controller, animation);
                //       });
              },
              //)
              //},
              icon: Icon(Icons.delete, color: Colors.red[900]),
            ),

            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Field ${warningList.indexOf(controller) + 1}',
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future openDialog() => showDialog(
    context: context,
    builder: (context) => Dialog(
      child: StatefulBuilder(
        builder: (context, setDialogState) {
          return Container(
            padding: EdgeInsets.all(12),
            child: SizedBox(
              width: 350,
              height: 500,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image(
                          image: AssetImage("assets/images/warning.png"),
                        ),
                        height: MediaQuery.of(context).size.height / 35,
                      ),
                      Text(
                        "Issues",
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 90),
                  Divider(),
                  Expanded(
                    child: StreamBuilder(
                      stream: warningListSizeListener(),
                      builder: (context, snapshot) {
                        return AnimatedList(
                          key: warningListKey,
                          initialItemCount: warningList.length,
                          itemBuilder:
                              (
                                BuildContext context,
                                int index,
                                Animation<double> animation,
                              ) {
                                return buildItem(warningList[index], animation);
                              },
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 10),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .transparent, // Make button background transparent
                          shadowColor:
                              Colors.transparent, // Disable default shadow
                          elevation: 0, // Disable default elevation
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              8.0,
                            ), // Match container's border radius
                          ),
                        ),
                        onPressed: () {
                          setDialogState(() {
                            warningList.add(TextEditingController());
                            warningListKey.currentState?.insertItem(
                              warningList.length - 1,
                            );
                          });
                        },

                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF22577A), Color(0xFF6CDD99)],
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: MediaQuery.of(context).size.height / 25,
                          width: MediaQuery.of(context).size.width / 4.5,
                          child: Column(children: [SizedBox(height: 7,),Text(
                            "Add Field",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.width / 26.5,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),],
                      ),),),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .transparent, // Make button background transparent
                          shadowColor:
                          Colors.transparent, // Disable default shadow
                          elevation: 0, // Disable default elevation
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              8.0,
                            ), // Match container's border radius
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF22577A), Color(0xFF6CDD99)],
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: MediaQuery.of(context).size.height / 25,
                          width: MediaQuery.of(context).size.width / 4.5,
                          child: Column(children: [SizedBox(height: 7,),Text(
                            "Save",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.width / 25.5,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),],
                          ),),),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
