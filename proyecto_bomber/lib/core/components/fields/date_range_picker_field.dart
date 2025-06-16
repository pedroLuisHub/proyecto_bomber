import 'package:flutter/material.dart';

class DateRangePickerField extends StatefulWidget {
  final TextEditingController dateRangeController;
  final String labelText;
  final Function(DateTimeRange?) onChanged;

  const DateRangePickerField({
    super.key,
    required this.dateRangeController,
    this.labelText = 'Seleccionar Rango de Fechas',
    required this.onChanged,
  });

  @override
  State<DateRangePickerField> createState() => _DateRangePickerFieldState();
}

class _DateRangePickerFieldState extends State<DateRangePickerField> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDateRange(context),
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: widget.labelText,
            suffixIcon: const Icon(Icons.calendar_today),
          ),
          controller: widget.dateRangeController,
          enabled: false,
        ),
      ),
    );
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      locale: const Locale('es', 'PY'),
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now(),
      ),
    );

    widget.onChanged.call(picked);
  }
}
