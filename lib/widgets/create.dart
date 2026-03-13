import 'package:flutter/material.dart';
import '../../widgets/widgets_collection.dart';

class CreateAnnouncementPage extends StatefulWidget {
  const CreateAnnouncementPage({super.key});

  @override
  State<CreateAnnouncementPage> createState() => _CreateAnnouncementPageState();
}

class _CreateAnnouncementPageState extends State<CreateAnnouncementPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _fileController = TextEditingController();
  final TextEditingController _venueOtherController = TextEditingController();
  final TextEditingController _personnelOtherController = TextEditingController();
  final TextEditingController _zoomOtherController = TextEditingController();
  final TextEditingController _uniformOtherController = TextEditingController();

  // Dropdown options
  final List<String> _venues = ['Camp Vicente Lim', 'RITO Office', 'Conference Room', 'Other'];
  final List<String> _personnels = ['IT Dept', 'HR', 'Admin', 'Other'];
  final List<String> _zoomPlatforms = ['Zoom', 'Teams', 'Google Meet', 'Other'];
  final List<String> _uniforms = ['Class A', 'Class B', 'Business Casual', 'Other'];

  // Selected dropdown values
  String? _selectedVenue;
  String? _selectedPersonnel;
  String? _selectedZoom;
  String? _selectedUniform;

  // Checkboxes
  bool _needsTechSupport = false;
  bool _attendPhysicallyAll = false;
  bool _infoNeeded = false;

  // Date & Time
  DateTimeRange? _selectedDateRange;
  TimeOfDayRange? _timeRange;

  @override
  void dispose() {
    _titleController.dispose();
    _fileController.dispose();
    _venueOtherController.dispose();
    _personnelOtherController.dispose();
    _zoomOtherController.dispose();
    _uniformOtherController.dispose();
    super.dispose();
  }

  void _postAnnouncement() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Announcement Posted!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "ANNOUNCEMENT CREATION",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Activity Title
            LabeledTextField(label: "Activity Title", controller: _titleController),
            const SizedBox(height: 20),

            // Venue Dropdown
            DropdownWithOther(
              label: "Venue",
              options: _venues,
              selectedValue: _selectedVenue,
              otherController: _venueOtherController,
              onChanged: (val) => setState(() => _selectedVenue = val),
            ),
            const SizedBox(height: 20),

            // Technical Support Checkbox
            LabeledCheckbox(
              label: "Do you need technical support?",
              value: _needsTechSupport,
              onChanged: (v) => setState(() => _needsTechSupport = v!),
            ),
            const SizedBox(height: 20),

            // File Attachment
            LabeledTextField(
              label: "Attach a file",
              controller: _fileController,
              suffixIcon: Icons.attach_file,
            ),
            const SizedBox(height: 20),

            // Date & Time Pickers
            DateRangePickerField(onSelected: (range) => _selectedDateRange = range),
            const SizedBox(height: 12),
            TimeRangePickerField(onSelected: (range) => _timeRange = range),
            const SizedBox(height: 20),

            // Personnel Dropdown
            DropdownWithOther(
              label: "Personnel/Office",
              options: _personnels,
              selectedValue: _selectedPersonnel,
              otherController: _personnelOtherController,
              onChanged: (val) => setState(() => _selectedPersonnel = val),
            ),
            const SizedBox(height: 20),

            // Attendance Checkbox
            LabeledCheckbox(
              label: "Attended by all personnel?",
              value: _attendPhysicallyAll,
              onChanged: (v) => setState(() => _attendPhysicallyAll = v!),
            ),
            const SizedBox(height: 20),

            // Info Needed Checkbox
            LabeledCheckbox(
              label: "Is information needed?",
              value: _infoNeeded,
              onChanged: (v) => setState(() => _infoNeeded = v!),
            ),
            const SizedBox(height: 20),

            // Zoom/Teams Dropdown
            DropdownWithOther(
              label: "To be attended via Zoom/Teams",
              options: _zoomPlatforms,
              selectedValue: _selectedZoom,
              otherController: _zoomOtherController,
              onChanged: (val) => setState(() => _selectedZoom = val),
            ),
            const SizedBox(height: 20),

            // Uniform Dropdown
            DropdownWithOther(
              label: "Type of Uniform",
              options: _uniforms,
              selectedValue: _selectedUniform,
              otherController: _uniformOtherController,
              onChanged: (val) => setState(() => _selectedUniform = val),
            ),
            const SizedBox(height: 30),

            // Post Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _postAnnouncement,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F2744),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("POST ACTIVITY", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}