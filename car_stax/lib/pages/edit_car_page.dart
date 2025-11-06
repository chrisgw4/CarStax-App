import 'package:flutter/material.dart';
import '../backend/backend_functions.dart';
import '../components/my_textfield.dart';
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
    carTypeController.text = carType;
    rentalStatusController.text = rentalStatus;

    for (String s in warningList1) {
      TextEditingController temp = TextEditingController();
      temp.text = s;
      warningList.add(temp);
    }
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

  Stream<int> warningListSizeListener() async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      yield warningList.length;
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
      appBar: AppBar(
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

                // Add Car Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                      ),
                        onPressed: () {
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

                          // Adds the car to the backend
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
                              carId: carID,
                          );
                        },
                        child: SizedBox(
                            width: 80,
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Edit Car",
                                  style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                                ),
                              ],
                            )
                        )
                    ),

                  ],

                ),
                SizedBox(height: 100,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

