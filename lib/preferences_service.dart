import 'package:shared_preferences/shared_preferences.dart';

import 'enum_models.dart';

class PreferencesService {
  Future saveSettings(Settings settings) async {
    final prefrences = await SharedPreferences.getInstance();

    await prefrences.setString('username', settings.username!);
    await prefrences.setBool('isImployed', settings.isImployed!);
    await prefrences.setInt('gender', settings.gender!.index);
    await prefrences.setStringList(
        'programmingLanguages',
        settings.programmingLanguages!
            .map((lang) => lang.index.toString())
            .toList());

    print('Saved Settings');
  }

  Future<Settings> getSettings() async {
    final prefrences = await SharedPreferences.getInstance();

    final username = prefrences.getString('username');
    final isEmployed = prefrences.getBool('isImployed');
    final gender = Gender.values[prefrences.getInt('gender') ?? 0];
    final programmingLanguageIndcies =
        prefrences.getStringList('programmingLanguages');

    final programmingLanguages = programmingLanguageIndcies!
        .map((stringIndex) =>
            ProgrammingLanguages.values[int.parse(stringIndex)])
        .toSet();

    return Settings(
        username: username,
        gender: gender,
        programmingLanguages: programmingLanguages,
        isImployed: isEmployed);
  }
}
