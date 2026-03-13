import 'package:flutter/material.dart';

/// ---------------------------
/// Labeled Text Field
/// ---------------------------
class LabeledTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData? suffixIcon; 

  const LabeledTextField({
    super.key,
    required this.label,
    required this.controller,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          validator: (value) =>
              value == null || value.isEmpty ? 'This field is required' : null,
        ),
      ],
    );
  }
}

/// ---------------------------
/// Checkbox Field
/// ---------------------------
class LabeledCheckbox extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const LabeledCheckbox({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
      ],
    );
  }
}

/// ---------------------------
/// Dropdown with optional "Other"
/// ---------------------------

class DropdownWithOther extends StatefulWidget {
  final String label;
  final List<String> options;
  final TextEditingController otherController;

  // Add these to allow external control
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;

  const DropdownWithOther({
    super.key,
    required this.label,
    required this.options,
    required this.otherController,
    this.selectedValue,
    this.onChanged,
  });

  @override
  State<DropdownWithOther> createState() => _DropdownWithOtherState();
}

class _DropdownWithOtherState extends State<DropdownWithOther> {
  late String? _internalSelected;

  @override
  void initState() {
    super.initState();
    // Use external selectedValue if provided, otherwise internal
    _internalSelected = widget.selectedValue;
  }

  @override
  void didUpdateWidget(covariant DropdownWithOther oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update internal selected if external value changes
    if (widget.selectedValue != oldWidget.selectedValue) {
      _internalSelected = widget.selectedValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _internalSelected,
          items: widget.options
              .map((option) => DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
          onChanged: (value) {
            setState(() {
              _internalSelected = value;
              if (value != 'Other') {
                widget.otherController.clear();
              }
            });
            // Call external handler if provided
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          validator: (value) {
            if ((value == null || value.isEmpty) && widget.otherController.text.isEmpty) {
              return 'Please select or specify ${widget.label}';
            }
            return null;
          },
        ),
        if (_internalSelected == 'Other') ...[
          const SizedBox(height: 12),
          LabeledTextField(label: 'If others, please specify:', controller: widget.otherController),
        ],
      ],
    );
  }
}
/// ---------------------------
/// Date Range Picker Field
/// ---------------------------
class DateRangePickerField extends StatefulWidget {
  final void Function(DateTimeRange) onSelected;

  const DateRangePickerField({super.key, required this.onSelected});

  @override
  State<DateRangePickerField> createState() => _DateRangePickerFieldState();
}

class _DateRangePickerFieldState extends State<DateRangePickerField> {
  DateTimeRange? _range;

  Future<void> _pickRange() async {
    final now = DateTime.now();
    final result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 2),
    );
    if (result != null) {
      setState(() => _range = result);
      widget.onSelected(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Date (From - To)", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: _pickRange,
          child: Text(_range == null
              ? "Pick a date"
              : "${_range!.start.toLocal()} - ${_range!.end.toLocal()}"),
        ),
      ],
    );
  }
}

/// ---------------------------
/// Time Range Picker Field
/// ---------------------------
class TimeRangePickerField extends StatefulWidget {
  final void Function(TimeOfDayRange) onSelected;

  const TimeRangePickerField({super.key, required this.onSelected});

  @override
  State<TimeRangePickerField> createState() => _TimeRangePickerFieldState();
}

class _TimeRangePickerFieldState extends State<TimeRangePickerField> {
  TimeOfDayRange? _range;

  Future<void> _pickRange() async {
    final start = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    final end = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (start != null && end != null) {
      setState(() => _range = TimeOfDayRange(start: start, end: end));
      widget.onSelected(_range!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Time (From - To)", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: _pickRange,
          child: Text(_range == null
              ? "Pick time"
              : "${_range!.start.format(context)} - ${_range!.end.format(context)}"),
        ),
      ],
    );
  }
}

/// Helper class for time range
class TimeOfDayRange {
  final TimeOfDay start;
  final TimeOfDay end;
  TimeOfDayRange({required this.start, required this.end});
}

class TechSupportRequestCard extends StatelessWidget {
  final String activityTitle;
  final String venue;
  final DateTimeRange dateRange;
  final TimeOfDayRange timeRange;
  final String requestedBy; // optional: name of the person

  const TechSupportRequestCard({
    super.key,
    required this.activityTitle,
    required this.venue,
    required this.dateRange,
    required this.timeRange,
    required this.requestedBy,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              activityTitle,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text("Requested by: $requestedBy", style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            Text("Venue: $venue", style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            Text(
              "Date: ${dateRange.start.toLocal()} - ${dateRange.end.toLocal()}",
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              "Time: ${timeRange.start.format(context)} - ${timeRange.end.format(context)}",
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}