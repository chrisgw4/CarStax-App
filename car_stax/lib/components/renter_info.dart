import 'package:car_stax/components/my_textfield.dart';
import 'package:car_stax/components/value_text_field.dart';
import 'package:flutter/material.dart';

import 'date_picker.dart';


class RenterInfo extends StatelessWidget {
  RenterInfo({
    super.key,
    required this.renterNameController,
    required this.renterPhoneController,
    required this.renterRateController,
    required this.renterEmailController,
    required this.startDateChanged,
    required this.returnDateChanged,
    required this.actualReturnDateChanged,
    this.initialStartDate,
    this.initialReturnDate,
    this.initialActualReturnDate,
  });

  final DateTime? initialStartDate;
  final DateTime? initialReturnDate;
  final DateTime? initialActualReturnDate;

  final void Function(DateTime) startDateChanged;
  final void Function(DateTime) returnDateChanged;
  final void Function(DateTime) actualReturnDateChanged;

  TextEditingController renterNameController;
  TextEditingController renterEmailController;
  TextEditingController renterPhoneController;
  TextEditingController renterRateController;
  DateTime startDate = DateTime.now();
  DateTime returnDate = DateTime.now();
  DateTime actualReturnDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Renter Information"),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),

              Text("Renter Name"),
              MyTextField(hintText: "John Doe", obscureText: false, controller: renterNameController),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Text("Renter Email"),
                        MyTextField(hintText: "John@gmail.com", obscureText: false, controller: renterEmailController),
                      ],
                    )
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          Text("Renter Phone Number"),
                          MyTextField(hintText: "1234567890", obscureText: false, controller: renterPhoneController),
                        ],
                      )
                  ),
                ],
              ),

              // Row(
              //   children: [
              //     Expanded(child: DatePicker(label: "Rental Start Date", onDateSelected: (DateTime p1) {},),),
              //     SizedBox(width: 10,),
              //     Expanded(child: DatePicker(label: "Expected Return", onDateSelected: (DateTime p1) {},),),
              //   ],
              // ),
              DatePicker(
                label: "Rental Start Date",
                onDateSelected: (DateTime p1) {startDateChanged(p1);},
                inputDate: initialStartDate,
              ),
              SizedBox(height: 15,),
              DatePicker(
                label: "Expected Return",
                onDateSelected: (DateTime p1) {returnDateChanged(p1);},
                inputDate: initialReturnDate,
              ),
              SizedBox(height: 15,),
              ValueTextField(label: 'Rate Per Day (\$)', controller: renterRateController,),
              SizedBox(height: 15,),
              DatePicker(
                label: "Actual Return",
                onDateSelected: (DateTime p1) {actualReturnDateChanged(p1);},
                inputDate: initialActualReturnDate,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
