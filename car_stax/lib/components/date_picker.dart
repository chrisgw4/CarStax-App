import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  final String label;
  final void Function(DateTime) onDateSelected;

  DateTime? inputDate;

  DatePicker({
    super.key,
    required this.label,
    required this.onDateSelected,
    this.inputDate,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? selectedDate;
  final TextEditingController _controller = TextEditingController();

  void initState() {
    super.initState();

    if (widget.inputDate != null) {
      selectedDate = widget.inputDate;


      // if (picked != null) {
        setState(() => selectedDate = widget.inputDate);
        widget.onDateSelected(widget.inputDate!);
        _controller.text =
        "${widget.inputDate!.month}/${widget.inputDate!.day}/${widget.inputDate!.year}";
      // }
    }

  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.tertiary,
              onPrimary: Colors.white,
              onSurface: Theme.of(context).colorScheme.inverseSurface,
              surface: Theme.of(context).colorScheme.primary,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.teal,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
      widget.onDateSelected(picked);
      _controller.text =
      "${picked.month}/${picked.day}/${picked.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      readOnly: true,
      onTap: _pickDate,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.inverseSurface,
        ),
        suffixIcon: const Icon(Icons.calendar_today),
        hintText: selectedDate == null
            ? 'Select date'
            : '${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}',
      ),
    );
  }
}
