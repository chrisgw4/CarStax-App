import 'dart:collection';

import 'package:flutter/material.dart';


typedef CarEntry = DropdownMenuEntry<CarType>;

// DropdownMenuEntry labels and values for the second dropdown menu.
enum CarType {
  none(
    '',
    null,
  ),
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
  final dynamic icon;

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


class CarTypeDropdown extends StatefulWidget {
  const CarTypeDropdown({super.key, required this.carTypeController});

  final TextEditingController carTypeController;

  @override
  State<CarTypeDropdown> createState() => _CarTypeDropdownState();
}

class _CarTypeDropdownState extends State<CarTypeDropdown> {

  CarType? selectedCar;


  void initState() {
    String carType = widget.carTypeController.text.toLowerCase();
    if (carType == "sedan") {
      setState(() {
        selectedCar = CarType.sedan;
      });
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
    else if (carType == "other"){
      setState(() {
        selectedCar = CarType.other;
      });
    }
    else {
      setState(() {
        selectedCar = CarType.none;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 1.5,
        ),
      ),
      child: DropdownMenu<CarType>(
        controller: widget.carTypeController,
        textAlign: TextAlign.center,
        width: 200,
        menuHeight: 200,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 5.0),

          prefixIconConstraints: BoxConstraints(
            minHeight: 40,
            minWidth: 40,
          ),
        ),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
          elevation: WidgetStatePropertyAll(8), // dropdown popup shadow
          shadowColor: WidgetStatePropertyAll(Colors.black.withOpacity(0.25)),
          surfaceTintColor: WidgetStatePropertyAll(Colors.white),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
        ),
        onSelected: (CarType? icon) {
          setState(() {
            selectedCar = icon;
          });
          widget.carTypeController.text = icon?.label ?? '';
        },
        dropdownMenuEntries: CarType.entries,
        leadingIcon: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 4.0),
          child: ImageIcon(selectedCar?.icon),
        ),
      ),
    );

  }
}
