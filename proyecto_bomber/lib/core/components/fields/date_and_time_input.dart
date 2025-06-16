import 'package:bomber/core/components/fields/date_formatter.dart';
import 'package:flutter/material.dart';

class DateAndTimeInput extends StatefulWidget {
  final DateTime? date;
  final ValueChanged<DateTime>? selectedDate;
  final String labelText;
  final Color? colorFont;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final double? fontSize;
  final bool? enabled;
  final DateTime? firstDate;

  const DateAndTimeInput({
    super.key,
    required this.date,
    required this.selectedDate,
    required this.labelText,
    this.colorFont,
    required this.controller,
    this.validator,
    this.fontSize,
    this.enabled = true,
    this.firstDate,
  });

  @override
  DateAndTimeInputState createState() => DateAndTimeInputState();
}

class DateAndTimeInputState extends State<DateAndTimeInput> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.date ?? DateTime.now();
    widget.controller.text =
        widget.date != null ? DateFormatter.formatDateTime(widget.date!) : '';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.enabled == true ? _onPressed : null,
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: widget.labelText,
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.calendar_today),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
          enabled: widget.enabled,
          controller: widget.controller,
          // suffixIcon: const Icon(
          //   Icons.calendar_today_rounded,
          //   color: Colors.grey,
          // ),
          validator: widget.validator,
          // label: widget.label,
        ),
      ),
    );
  }

  Future<void> _onPressed() async {
    if (!mounted) return;

    // Selección de fecha
    final pickedDate = await showDatePicker(
      context: context,
      builder: (context, child) {
        return Theme(data: Theme.of(context).copyWith(), child: child!);
      },
      locale: const Locale('es', 'PY'),
      initialDate: selectedDate,
      firstDate: widget.firstDate ?? DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (!mounted || pickedDate == null) return;

    // Selección de hora
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
    );

    if (!mounted || pickedTime == null) return;

    // Combina fecha y hora seleccionadas
    final combinedDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    selectedDate = combinedDateTime;
    widget.controller.text = DateFormatter.formatDateTime(selectedDate);
    widget.selectedDate?.call(combinedDateTime);
  }
}
