import 'dart:collection';

import 'package:flutter/material.dart';



// DropdownMenuEntry labels and values for the second dropdown menu.
enum RentalStatus {
  none(
    '',
    null,
  ),
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
  final dynamic icon;

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
typedef RentalEntry = DropdownMenuEntry<RentalStatus>;

class RentalStatusDropdown extends StatefulWidget {
  const RentalStatusDropdown({super.key, required this.rentalStatusController});

  final TextEditingController rentalStatusController;

  @override
  State<RentalStatusDropdown> createState() => _RentalStatusDropdownState();
}

class _RentalStatusDropdownState extends State<RentalStatusDropdown> {

  void initState() {
    super.initState();
    if (widget.rentalStatusController.text.toLowerCase() == "rented") {
      setState(() {
        selectedStatus = RentalStatus.rented;
      });
    }
    else if (widget.rentalStatusController.text.toLowerCase() == "available") {
      setState(() {
        selectedStatus = RentalStatus.available;
      });
    }
    else if (widget.rentalStatusController.text.toLowerCase() == "maintenance"){
      setState(() {
        selectedStatus = RentalStatus.maintenance;
      });
    }
    else {
      setState(() {
        selectedStatus = RentalStatus.none;
      });
    }

  }

  RentalStatus? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2),
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
      child: DropdownMenu<RentalStatus>(
        controller: widget.rentalStatusController,
        textAlign: TextAlign.center,
        width: 200,
        menuHeight: 200,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
          prefixIconConstraints: BoxConstraints(
            minHeight: 40,
            minWidth: 40,
          ),
        ),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
          elevation: WidgetStatePropertyAll(8),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          shadowColor: WidgetStatePropertyAll(Colors.black.withOpacity(0.25)),
        ),
        onSelected: (RentalStatus? icon) {
          setState(() {
            selectedStatus = icon;
          });
          widget.rentalStatusController.text = icon?.label ?? '';
        },
        dropdownMenuEntries: RentalStatus.entries,
        leadingIcon: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 4.0),
          child: ImageIcon(selectedStatus?.icon),
        ),
      ),
    );

  }
}
