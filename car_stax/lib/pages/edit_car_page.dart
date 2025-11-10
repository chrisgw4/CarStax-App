import 'package:flutter/material.dart';
import '../backend/backend_functions.dart';
import '../components/my_textfield.dart';
import '../components/renter_info.dart';
import 'add_car_page.dart';



class EditCarPage extends StatefulWidget {
  EditCarPage({super.key,
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
  final List<dynamic> warningList;

  final String carID;

  @override
  State<EditCarPage> createState() => _EditCarPageState(
      licensePlate: licensePlate,
      year: year,
      mileage: mileage,
      make: make,
      model: model,
      color: color,
      vin: vin,
      carType: carType,
      rentalStatus: rentalStatus,
      warningList1: warningList,
      carID: carID,
  );
}

class _EditCarPageState extends State<EditCarPage> {
  _EditCarPageState({
  required this.licensePlate,
  required this.year,
  required this.mileage,
  required this.make,
  required this.model,
  required this.color,
  required this.vin,
  required this.carType,
  required this.rentalStatus,
  required this.warningList1,
  required this.carID,
  }
  );

  @override
  void initState() {
    super.initState();
    lPLateController.text = licensePlate;
    yearController.text = year.toString();
    mileageController.text = mileage.toString();
    makeController.text = make;
    modelController.text = model;
    colorController.text = color;
    vinController.text = vin;
    carTypeController.text = carType.substring(0,1).toUpperCase() + carType.substring(1);
    rentalStatusController.text = rentalStatus.substring(0,1).toUpperCase() + rentalStatus.substring(1);

    if (rentalStatus == "rented") {
      setState(() {
        selectedStatus = RentalStatus.rented;
      });
      loadRenter();
    }
    else if (rentalStatus == "available") {
      setState(() {
        selectedStatus = RentalStatus.available;
      });
    }
    else {
      setState(() {
        selectedStatus = RentalStatus.maintenance;
      });
    }

    if (carType == "sedan") {
      setState(() {
        selectedCar = CarType.sedan;

      });
      loadRenter();
    }
    else if (carType == "truck") {
      setState(() {
        selectedCar = CarType.truck;
      });
    }
    else if (carType == "suv") {
      setState(() {
        selectedCar = CarType.suv;
      });
    }
    else if (carType == "coupe") {
      setState(() {
        selectedCar = CarType.coupe;

      });
    }
    else if (carType == "convertible") {
      setState(() {
        selectedCar = CarType.convertible;

      });
    }
    else if (carType == "hatchback") {
      setState(() {
        selectedCar = CarType.hatchback;
      });
    }
    else if (carType == "van") {
      setState(() {
        selectedCar = CarType.van;
      });
    }
    else if (carType == "motorcycle") {
      setState(() {
        selectedCar = CarType.motorcycle;
      });
    }
    else {
      setState(() {
        selectedCar = CarType.other;
      });
    }

    for (String s in warningList1) {
      TextEditingController temp = TextEditingController();
      temp.text = s;
      warningList.add(temp);
    }
  }

  void loadRenter() async {
    var response = await backend_get_renter(carID: carID);
    renterNameController.text = response["rentals"][0]["renterName"];
    renterEmailController.text = response["rentals"][0]["renterEmail"];
    renterPhoneController.text = response["rentals"][0]["renterPhone"];
    renterRateController.text = response["rentals"][0]["rentalRatePerDay"].toString();

    startDate = DateTime.parse(response["rentals"][0]['dateRentedOut']);
    returnDate = DateTime.parse(response["rentals"][0]['expectedReturnDate']);
    actualReturnDate = DateTime.parse(response["rentals"][0]['actualReturnDate']);
  }

  final String licensePlate;
  final int year;
  final int mileage;
  final String make;
  final String model;
  final String color;
  final String vin;
  final String carType;
  final String rentalStatus;
  final List<dynamic> warningList1;

  final String carID;

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

  late DateTime startDate = DateTime.now();
  late DateTime returnDate = DateTime.now();
  late DateTime actualReturnDate = DateTime.now();

  Stream<int> warningListSizeListener() async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      yield warningList.length;
    }
  }

  Stream<bool> streamRentalStatus() async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));

      if (selectedStatus?.label == "Rented") {
        yield true;
      }
      else {
        yield false;
      }

    }
  }

  Stream<List<dynamic>> streamStartDates () async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 10));
      var response = await backend_get_renter(carID: carID);
      List<dynamic> list = [];
      if (response["rentals"].length > 0) {
        // print( DateTime.parse(response["rentals"][0]["dateRentedOut"]));
        var sD = DateTime.parse(response["rentals"][0]['dateRentedOut']);
        var rD = DateTime.parse(response["rentals"][0]['expectedReturnDate']);
        var aRD =
        DateTime.parse(response["rentals"][0]['actualReturnDate']);
        list = [selectedStatus?.label == "Rented", sD, rD, aRD];
      }
      else {
        list = [selectedStatus?.label == "Rented", null, null, null];
      }

      yield list;
    }
  }


  Future openDialog() => showDialog(
    context: context,
    builder: (context) => Dialog(

      child: StatefulBuilder(
        builder: (context, setDialogState) {
          return Container(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              width: 350,
              height: 500,
              child: Column(
                children: [


                  Expanded(
                    child: StreamBuilder(
                        stream: warningListSizeListener(),
                        builder: (context, snapshot) {
                          return ListView.builder(
                            itemCount: warningList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            warningList.remove(warningList[index]);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red[900],)
                                      ),
                                      Expanded(child: TextField(
                                        controller: warningList[index],
                                        decoration: InputDecoration(
                                          labelText: 'Field ${index + 1}',
                                          border: const OutlineInputBorder(),
                                        ),
                                      )),
                                    ],
                                  )
                              );
                            },
                          );
                        }
                    )

                  ),

                  // Buttons
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.tertiary,
                        ),
                        onPressed: () {
                          setDialogState(() {
                            warningList.add(TextEditingController());
                          });
                        },
                        child: Text(
                          "Add Field",
                          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                        ),
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.tertiary,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Close",
                          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                        ),
                      ),
                    ],
                  )

                ],
              ),
            ),
          );
        },
      ),
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: 80,
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF22577A),Color(0xFF6CDD99) ]),
          borderRadius: BorderRadius.circular(12),
        ),
        child: FloatingActionButton(
            tooltip: 'Edit Car',
            backgroundColor: Colors.transparent,
            child: Text("Edit Car"),
            onPressed: () async {
              print("Pressed add");
              if (yearController.text == "")
                return;
              if (mileageController.text == "")
                return;

              List<String> warningListStrings = [];

              for (TextEditingController object in warningList) {
                if (object.text != "") {
                  warningListStrings.add(object.text);
                }
              }
              // Go back to the home page
              Navigator.pop(context);
              Navigator.pop(context);

              backend_edit_car(
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
                  carId: carID
              );

              var has_renter = await checkCarHasRenter(carID: carID);
              if (selectedStatus?.label == "Rented") {

                var renter = await backend_get_renter(carID: carID);
                print(renter);

                if (has_renter) {
                  backend_edit_renter(
                      renterID: renter["rentals"][0]["_id"],
                      renterName: renterNameController.text,
                      renterEmail: renterEmailController.text,
                      renterPhone: renterPhoneController.text,
                      dateRentedOut: "${startDate.month}/${startDate.day}/${startDate.year}",
                      expectedReturnDate: "${returnDate.month}/${returnDate.day}/${returnDate.year}",
                      actualReturnDate: "${actualReturnDate.month}/${actualReturnDate.day}/${actualReturnDate.year}",
                      rentalRatePerDay: renterRateController.text,
                      notes: ""
                  );
                }
                else {
                  backend_add_renter(
                      carID: carID,
                      renterName: renterNameController.text,
                      renterEmail: renterEmailController.text,
                      renterPhone: renterPhoneController.text,
                      dateRentedOut: "${startDate.month}/${startDate.day}/${startDate.year}",
                      expectedReturnDate: "${returnDate.month}/${returnDate.day}/${returnDate.year}",
                      actualReturnDate: "${actualReturnDate.month}/${actualReturnDate.day}/${actualReturnDate.year}",
                      rentalRatePerDay: renterRateController.text,
                      notes: ""
                  );
                }
              }


            }

        ),
      ),
      appBar: AppBar(
        title: Text("Edit Car"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.only(),
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
                Text("Color", style: TextStyle(fontSize: 16)),
                MyTextField(
                  hintText: "Black",
                  obscureText: false,
                  controller: colorController,
                ),
                SizedBox(height: 10),
                Text("VIN Number", style: TextStyle(fontSize: 16)),
                MyTextField(
                  hintText: "1A2BC34567D890123",
                  obscureText: false,
                  controller: vinController,
                ),
                SizedBox(height: 10),
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

                    contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                  onSelected: (CarType? icon) {
                    setState(() {
                      selectedCar = icon;
                    });
                  },
                  dropdownMenuEntries: CarType.entries,
                  leadingIcon: ImageIcon(selectedCar?.icon),
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
                SizedBox(height: 10,),
                
                ElevatedButton(
                    onPressed: openDialog,
                    child: Text(
                      "Add Issues",
                      style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                    )
                ),

                StreamBuilder(
                    stream: streamStartDates(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("");
                      }
                      if (!snapshot.hasData) {
                        return Text("");
                      }
                      if (snapshot.data?[0] == false) {
                        return Text("");
                      }

                      return RenterInfo(
                        renterNameController: renterNameController,
                        renterEmailController: renterEmailController,
                        renterPhoneController: renterPhoneController,
                        renterRateController: renterRateController,
                        initialStartDate: snapshot.data?[1],
                        initialReturnDate: snapshot.data?[2],
                        initialActualReturnDate: snapshot.data?[3],
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

                    }
                ),


                // StreamBuilder(
                //     stream: streamRentalStatus(),
                //     builder: (context, snapshot) {
                //       if (snapshot.hasError) {
                //         return Text("");
                //       }
                //       if (!snapshot.hasData) {
                //         return Text("");
                //       }
                //       if (snapshot.data == false) {
                //         return Text("");
                //       }
                //       return StreamBuilder(
                //           stream: streamStartDates(),
                //           builder: (context, snapshot) {
                //             if (!snapshot.hasData) {
                //               return Text("No Data");
                //             }
                //
                //             return RenterInfo(
                //               renterNameController: renterNameController,
                //               renterEmailController: renterEmailController,
                //               renterPhoneController: renterPhoneController,
                //               renterRateController: renterRateController,
                //               initialStartDate: snapshot.data?[0],
                //               initialReturnDate: snapshot.data?[1],
                //               initialActualReturnDate: snapshot.data?[2],
                //               startDateChanged: (DateTime d) {
                //                 startDate = d;
                //               },
                //               returnDateChanged: (DateTime d) {
                //                 returnDate = d;
                //               },
                //               actualReturnDateChanged: (DateTime d) {
                //                 actualReturnDate = d;
                //               },
                //             );
                //           }
                //       );
                //     }
                // ),
                SizedBox(height: 100,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

