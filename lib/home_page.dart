import 'package:flutter/material.dart';
import 'package:shared_pref/preferences_service.dart';

import 'enum_models.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _preferencesService = PreferencesService();

  final _userNameController = TextEditingController();
  var _selektedGender = Gender.MALE;
  var _selectedLanguages = <ProgrammingLanguages>{};
  var _isEmployed = false;

  void _populateFields() async {
    final settings = await _preferencesService.getSettings();
    setState(() {
      _userNameController.text = settings.username!;
      _selektedGender = settings.gender!;
      _selectedLanguages = settings.programmingLanguages!;
      _isEmployed = settings.isImployed!;
    });
  }

  @override
  void initState() {
    super.initState();
    _populateFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preferens'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: _userNameController,
              decoration: const InputDecoration(label: Text('Username')),
            ),
          ),
          RadioListTile(
              title: const Text('Male'),
              value: Gender.MALE,
              groupValue: _selektedGender,
              onChanged: (newVal) =>
                  setState(() => _selektedGender = newVal as Gender)),
          RadioListTile(
              title: const Text('FEMALE'),
              value: Gender.FEMALE,
              groupValue: _selektedGender,
              onChanged: (newVal) {
                setState(() {
                  _selektedGender = newVal as Gender;
                });
              }),
          CheckboxListTile(
              title: const Text('DART'),
              value: _selectedLanguages.contains(ProgrammingLanguages.DART),
              onChanged: (_) {
                setState(() {
                  _selectedLanguages.contains(ProgrammingLanguages.DART)
                      ? _selectedLanguages.remove(ProgrammingLanguages.DART)
                      : _selectedLanguages.add(ProgrammingLanguages.DART);
                });
              }),
          CheckboxListTile(
              title: const Text('JAVASCRIPT'),
              value:
                  _selectedLanguages.contains(ProgrammingLanguages.JAVASCRIPT),
              onChanged: (_) {
                setState(() {
                  _selectedLanguages.contains(ProgrammingLanguages.JAVASCRIPT)
                      ? _selectedLanguages
                          .remove(ProgrammingLanguages.JAVASCRIPT)
                      : _selectedLanguages.add(ProgrammingLanguages.JAVASCRIPT);
                });
              }),
          CheckboxListTile(
              title: const Text('PAYTHON'),
              value: _selectedLanguages.contains(ProgrammingLanguages.PAYTHON),
              onChanged: (_) {
                setState(() {
                  _selectedLanguages.contains(ProgrammingLanguages.PAYTHON)
                      ? _selectedLanguages.remove(ProgrammingLanguages.PAYTHON)
                      : _selectedLanguages.add(ProgrammingLanguages.PAYTHON);
                });
              }),
          CheckboxListTile(
              title: const Text('SWIFT'),
              value: _selectedLanguages.contains(ProgrammingLanguages.SWIFT),
              onChanged: (_) {
                setState(() {
                  _selectedLanguages.contains(ProgrammingLanguages.SWIFT)
                      ? _selectedLanguages.remove(ProgrammingLanguages.SWIFT)
                      : _selectedLanguages.add(ProgrammingLanguages.SWIFT);
                });
              }),
          SwitchListTile(
              title: const Text('Is Employed'),
              value: _isEmployed,
              onChanged: (newValue) => setState(() {
                    _isEmployed = newValue;
                  })),
          TextButton(
              onPressed: _saveSettings, child: const Text('Save Settings'))
        ],
      ),
    );
  }

  void _saveSettings() {
    final newSettings = Settings(
      username: _userNameController.text,
      gender: _selektedGender,
      programmingLanguages: _selectedLanguages,
      isImployed: _isEmployed,
    );
    _preferencesService.saveSettings(newSettings);
    print(newSettings);
  }
}
