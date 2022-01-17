enum Gender { MALE, FEMALE }

enum ProgrammingLanguages { DART, JAVASCRIPT, PAYTHON, SWIFT }

class Settings {
  final String? username;
  final Gender? gender;
  final Set<ProgrammingLanguages>? programmingLanguages;
  final bool? isImployed;

  Settings(
      {this.username, this.gender, this.programmingLanguages, this.isImployed});
}
