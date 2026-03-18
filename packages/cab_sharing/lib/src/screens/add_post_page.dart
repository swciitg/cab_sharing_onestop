import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:intl/intl.dart';
import 'package:onestop_ui/index.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../functions/snackbar.dart';
import '../services/api.dart';
import '../services/date.dart';
import '../services/user_store.dart';
import '../widgets/add_post/date_picker_modal.dart';
import '../widgets/add_post/location_picker_modal.dart';
import '../widgets/add_post/seats_picker_modal.dart';
import '../widgets/add_post/selectable_field.dart';
import '../widgets/add_post/time_picker_modal.dart';
import './home.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  // Form controllers
  final TextEditingController noteController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Location values
  String _fromLocation = 'Campus';
  String _toLocation = 'Airport';

  // Time values (24-hour format stored internally)
  late int _selectedHour;
  late int _selectedMinute;
  late String _selectedPeriod;

  // Date value
  DateTime? _selectedDate;

  // Seats value
  int _availableSeats = 3;

  // Form state
  bool _allowPost = true;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedHour = now.hour % 12 == 0 ? 12 : now.hour % 12;
    _selectedMinute = now.minute;
    _selectedPeriod = now.hour >= 12 ? 'PM' : 'AM';
    _selectedDate = now;
  }

  // Convert 12-hour to 24-hour format
  int get _hour24 {
    if (_selectedPeriod == 'AM') {
      return _selectedHour == 12 ? 0 : _selectedHour;
    } else {
      return _selectedHour == 12 ? 12 : _selectedHour + 12;
    }
  }

  DateTime get selectedDateTime => DateTime(
    _selectedDate?.year ?? DateTime.now().year,
    _selectedDate?.month ?? DateTime.now().month,
    _selectedDate?.day ?? DateTime.now().day,
    _hour24,
    _selectedMinute,
  );

  String get _formattedTime {
    final hour = _selectedHour.toString().padLeft(2, '0');
    final minute = _selectedMinute.toString().padLeft(2, '0');
    return '$hour : $minute $_selectedPeriod';
  }

  String get _formattedDate {
    if (_selectedDate == null) return 'Date';
    return DateFormat('dd MMM yyyy').format(_selectedDate!);
  }

  /// Shows location picker modal
  Future<void> _showFromLocationPicker() async {
    final result = await LocationPickerModal.show(
      context,
      title: 'From',
      currentValue: _fromLocation,
      headerIcon: TablerIcons.current_location,
    );
    if (result != null) {
      setState(() => _fromLocation = result);
    }
  }

  Future<void> _showToLocationPicker() async {
    final result = await LocationPickerModal.show(
      context,
      title: 'To',
      currentValue: _toLocation,
      headerIcon: TablerIcons.map_pin_filled,
    );
    if (result != null) {
      setState(() => _toLocation = result);
    }
  }

  /// Shows time picker modal
  Future<void> _showTimePicker() async {
    await TimePickerModal.show(
      context,
      initialHour: _selectedHour,
      initialMinute: _selectedMinute,
      initialPeriod: _selectedPeriod,
      onTimeSelected: (hour, minute, period) {
        setState(() {
          _selectedHour = hour;
          _selectedMinute = minute;
          _selectedPeriod = period;
        });
      },
    );
  }

  /// Shows date picker modal
  Future<void> _showDatePicker() async {
    final dateController = context.read<DateController>();
    await DatePickerModal.show(
      context,
      initialDate: _selectedDate,
      onDateSelected: (date) {
        setState(() => _selectedDate = date);
        dateController.setdate(date);
      },
    );
  }

  /// Shows seats picker modal
  Future<void> _showSeatsPicker() async {
    await SeatsPickerModal.show(
      context,
      initialValue: _availableSeats,
      onSeatsSelected: (seats) {
        setState(() => _availableSeats = seats);
      },
    );
  }

  Future<void> _handleSubmit() async {
    if (!_allowPost) return;

    final nav = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final commonStore = context.read<CommonStore>();
    Map<String, dynamic> userData = commonStore.userData;

    setState(() {
      _allowPost = false;
    });

    // Validate From and To are different
    if (_fromLocation == _toLocation) {
      messenger.showSnackBar(
        getSnackBar("From and To cannot be the same", isWarning: true),
      );
      setState(() {
        _allowPost = true;
      });
      return;
    }

    // Validate note field
    if (noteController.text.trim().isEmpty) {
      messenger.showSnackBar(
        getSnackBar("Please enter additional notes", isWarning: true),
      );
      setState(() {
        _allowPost = true;
      });
      return;
    }

    // Validate phone number
    if (phoneController.text.trim().isEmpty) {
      messenger.showSnackBar(
        getSnackBar("Please enter your phone number", isWarning: true),
      );
      setState(() {
        _allowPost = true;
      });
      return;
    }

    // Validate phone number format (10 digits)
    final phoneRegex = RegExp(r'^[0-9]{10}$');
    if (!phoneRegex.hasMatch(phoneController.text.trim())) {
      messenger.showSnackBar(
        getSnackBar(
          "Please enter a valid 10-digit phone number",
          isWarning: true,
        ),
      );
      setState(() {
        _allowPost = true;
      });
      return;
    }

    try {
      Map<String, dynamic> data = {
        'to': _toLocation,
        'from': _fromLocation,
        'name': userData['name'],
        'email': userData['email'],
        'travelDateTime': selectedDateTime.toIso8601String(),
        'note': noteController.text,
        'phonenumber': phoneController.text.trim(),
        'margin': 0,
        'totalSeats': _availableSeats,
        'availableSeats': _availableSeats,
      };

      bool res = await APIService().postTripData(data);

      if (res) {
        if (!mounted) return;
        messenger.showSnackBar(getSnackBar("Post Uploaded"));
        nav.pushReplacement(
          MaterialPageRoute(builder: (context) => const CabSharingScreen()),
        );
      } else {
        if (!mounted) return;
        setState(() {
          _allowPost = true;
        });
        messenger.showSnackBar(getSnackBar("Some error occurred!"));
      }
    } catch (e) {
      setState(() {
        _allowPost = true;
      });
      messenger.showSnackBar(getSnackBar("An error occurred. $e"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DateController>(
      builder: (_, provider, __) {
        return Scaffold(
          backgroundColor: OColor.white,
          appBar: AppBar(
            systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle
                ?.copyWith(statusBarColor: OColor.white),

            backgroundColor: OColor.white,
            elevation: 0,
            leading: IconButton(
              onPressed: Navigator.of(context).pop,
              icon: Icon(TablerIcons.arrow_left, color: OColor.green600),
            ),
            title: Text(
              'Share a Cab',
              style: OTextStyle.headingMedium.copyWith(color: OColor.gray800),
            ),
            centerTitle: true,
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(OSpacing.m),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header section
                  Text(
                    'Enter Details',
                    style: OTextStyle.headingMedium.copyWith(
                      color: OColor.gray800,
                    ),
                  ),
                  const SizedBox(height: OSpacing.xxs),
                  Text(
                    'Your personal details like mail ID and phone number will be visible to others once you post.',
                    style: OTextStyle.bodySmall.copyWith(color: OColor.gray600),
                  ),
                  const SizedBox(height: OSpacing.l),

                  // From and To fields
                  Row(
                    children: [
                      Expanded(
                        child: SelectableField(
                          label: 'From',
                          value: _fromLocation,
                          icon: TablerIcons.map_pin,
                          onTap: _showFromLocationPicker,
                        ),
                      ),
                      const SizedBox(width: OSpacing.m),
                      Expanded(
                        child: SelectableField(
                          label: 'To',
                          value: _toLocation,
                          icon: TablerIcons.map_pin,
                          onTap: _showToLocationPicker,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: OSpacing.m),

                  // Time field
                  SelectableField(
                    label: 'Select Pickup Time',
                    value: _formattedTime,
                    icon: TablerIcons.clock,
                    onTap: _showTimePicker,
                  ),
                  const SizedBox(height: OSpacing.m),

                  // Date field
                  SelectableField(
                    label: 'Select Pickup Date',
                    value: _formattedDate,
                    icon: TablerIcons.calendar,
                    onTap: _showDatePicker,
                  ),
                  const SizedBox(height: OSpacing.m),

                  // Seats field
                  SelectableField(
                    label: 'Seats Available in Cab (excluding yours)',
                    value: _availableSeats.toString(),
                    icon: TablerIcons.users,
                    onTap: _showSeatsPicker,
                  ),
                  const SizedBox(height: OSpacing.m),

                  // Phone Number field
                  OTextField(
                    maxLength: 10,
                    label: 'Phone Number',
                    controller: phoneController,
                  ),
                  const SizedBox(height: OSpacing.m),

                  // Additional Notes using OTextField
                  OTextField(
                    label: 'Additional Notes',
                    controller: noteController,
                    hint: 'e.g. Timing is flexible by 15 mins',
                    isParagraph: true,
                  ),
                  const SizedBox(height: OSpacing.l),

                  // Bottom buttons
                  const SizedBox(height: OSpacing.m),
                  Row(
                    children: [
                      Expanded(
                        child: SecondaryButton(
                          label: 'Back',
                          leadingIcon: TablerIcons.arrow_left,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      const SizedBox(width: OSpacing.m),
                      Expanded(
                        child: PrimaryButton(
                          label: 'Post',
                          tarilingIcon: TablerIcons.check,
                          onPressed: _allowPost ? _handleSubmit : null,
                          enabled: _allowPost,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: OSpacing.m),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
