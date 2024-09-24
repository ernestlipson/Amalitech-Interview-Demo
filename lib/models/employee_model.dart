import 'package:intl/intl.dart';

class Employee {
  final String firstname;
  final String lastname;
  final DateTime dateOfBirth;
  final DateTime yearOfEmployment;

  Employee({
    required this.firstname,
    required this.lastname,
    required this.dateOfBirth,
    required this.yearOfEmployment,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      firstname: json['firstname'],
      lastname: json['lastname'],
      dateOfBirth: DateTime.parse(json['dateofbirth']),
      yearOfEmployment: DateTime.parse(json['yearofemployment']),
    );
  }

  String get fullName => '$firstname $lastname';

  String get birthdayString {
    final formatter = DateFormat('MMMM d');
    return 'Birthday on ${formatter.format(dateOfBirth)}';
  }

  String get anniversaryString {
    final now = DateTime.now();
    final years = now.year - yearOfEmployment.year;
    return '${ordinal(years)} Company Anniversary';
  }

  static String ordinal(int number) {
    if (number >= 11 && number <= 13) {
      return '${number}th';
    }
    switch (number % 10) {
      case 1:
        return '${number}st';
      case 2:
        return '${number}nd';
      case 3:
        return '${number}rd';
      default:
        return '${number}th';
    }
  }
}
