import 'package:fishfarmguide_prod/views/consult/register/register_user_function.dart';
import 'package:fishfarmguide_prod/views/consult/register/show_restart_dialog.dart';

import '../../../models/consult/register/register_user_model.dart';
import '../../../provider/consult/pin-code/pin_code_data_provider.dart';
import '../../../provider/local_storage/phoneno_presence_provider.dart';
// import '../../../translate/language_store.dart';
import '../../../utils/local_shared_Storage.dart';
import '../../../utils/validation_function.dart';
import '../../../widgets/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterUser extends ConsumerStatefulWidget {
  const RegisterUser({super.key});

  @override
  ConsumerState<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends ConsumerState<RegisterUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _postOfficeController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();

  final TextEditingController _isActiveController = TextEditingController();
  late SharedPreferences prefs;
  String _selectedType = 'Buyer'; // Initialize with a default value
  bool isSaving = false;
  late bool phonePresence;
  bool areAllFieldsValid() {
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  void initState() {
    super.initState();
    localRegisteredProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Initialize SharedPreferences and retrieve stored values
  Future<void> localRegisteredProfile() async {
    final bool phonePresence = ref.read(phoneNoPresenceProvider);

    if (!phonePresence) {
      // If phoneNoPresenceProvider is false, set variables to empty strings
      setState(() {
        _phoneController.text = '';
        _nameController.text = '';
        _selectedType = '';
      });
      return;
    }

    final List<String> userData = await LocalSharedStorage.getUser();
    if (userData.length >= 3) {
      String storedName = userData[0]; // Accessing stored name
      String storedPhone = userData[1]; // Accessing stored phone number
      String storedUserType = userData[2]; // Accessing stored user type

      debugPrint(
          'C1,Name: $storedName, Phone: $storedPhone, Type: $storedUserType');

      if (storedPhone.isNotEmpty &&
          storedName.isNotEmpty &&
          storedUserType.isNotEmpty) {
        setState(() {
          _phoneController.text = storedPhone;
          _nameController.text = storedName;
          _selectedType = storedUserType;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final pinCodeDataProvider = ref.read(pinCodeDataServiceProvider);

    return Scaffold(
      appBar: commonAppBar(
        context,
        'Register Yourself',
        isIconBack: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _phoneController,
                  readOnly: false,
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      TextFieldValidation.validatePhoneNumber(value),
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    hintText: '10 Digit Number',
                  ),
                ),
                TextFormField(
                  controller: _nameController,
                  validator: (value) =>
                      TextFieldValidation.validateGeneralText(value),
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'Full Name',
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedType.isNotEmpty
                      ? _selectedType
                      : null, // Ensure value is not empty or null
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedType =
                          newValue ?? 'Farmer'; // Ensure a default value is set
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Work Role',
                    hintText: 'Select Work Role', // Add hint text here
                  ),
                  items: [
                    'Seller - মাছ ব্রিকেতা',
                    'Buyer - মাছ ক্রেতা',
                    'Agent -  মাছ সরবরাহ প্রতিনিধি',
                    'Trader - সব রক্ষম মাছ ব্যবসায়ী',
                    'Fisherman - জেলে - জাল টানার লোক',
                    'Transporter - জলের ট্যাংকের গাড়ি দেবে',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value
                          .split(' - ')[0], // Store only the label in the value
                      child: Text(
                          value), // Display the full line with label and hint
                    );
                  }).toList(),
                ),
                TextFormField(
                  controller: _locationController,
                  validator: (value) =>
                      TextFieldValidation.validateGeneralText(value),
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    hintText: 'Common Location Name',
                  ),
                ),
                TextFormField(
                  controller: _pinCodeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Pin Code'),
                  validator: (value) =>
                      TextFieldValidation.validatePinCode(value),
                  onChanged: (value) async {
                    if (value.length >= 6) {
                      // Trigger onChanged callback after 6 digits
                      // Call getData method to fetch data based on pin code
                      final data =
                          await pinCodeDataProvider.getData(context, value);
                      if (data != null) {
                        // Update the district and state fields with fetched data
                        setState(() {
                          _postOfficeController.text = data['Name'] ?? '';
                          _districtController.text = data['District'] ?? '';
                          _stateController.text = data['State'] ?? '';
                        });
                      }
                    }
                  },
                ),
                TextFormField(
                  controller: _postOfficeController,
                  decoration: const InputDecoration(labelText: 'Post Office'),
                  enabled: false,
                  validator: (value) =>
                      TextFieldValidation.validateGeneralText(value),
                ),
                TextFormField(
                  controller: _districtController,
                  decoration: const InputDecoration(labelText: 'District'),
                  enabled: false,
                  // validator: (value) =>
                  //     TextFieldValidation.validateGeneralText(value),
                ),
                TextFormField(
                  controller: _stateController,
                  decoration: const InputDecoration(labelText: 'State'),
                  enabled: false,
                  // validator: (value) =>
                  //     TextFieldValidation.validateGeneralText(value),
                ),
                TextFormField(
                  controller: _countryController,
                  decoration: const InputDecoration(labelText: 'Country'),
                  enabled: false,
                  // validator: (value) =>
                  //     TextFieldValidation.validateGeneralText(value),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Creating the RegisterUserModel instance
                      final registerUserModel = RegisterUserModel(
                        userPhNo: _phoneController.text,
                        userName: _nameController.text,
                        userType: _selectedType,
                        locationName: _locationController.text,
                        pinCode: _pinCodeController.text,
                        postOffice: _postOfficeController.text,
                        district: _districtController.text,
                        state: _stateController.text,
                        country: _countryController.text,
                      );

                      try {
                        // Attempting to register the user
                        await registerUserFunction(
                            context, ref, registerUserModel);

                        // Displaying the restart dialog only if registration was successful
                        if (context.mounted) {
                          await showRestartDialog(context);
                        }
                      } catch (e) {
                        // Handle any errors from registerUserFunction
                        print("Registration failed: $e");
                        // Optionally, show an error dialog or message here
                      }
                    }
                  },
                  child: Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Later'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
