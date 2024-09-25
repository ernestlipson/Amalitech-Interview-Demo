import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/employee_model.dart';

class Event {
  final DateTime date;
  final String title;
  final String subtitle;
  final IconData icon;

  Event({
    required this.date,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

class EventUtility {
  static Map<String, List<Event>> groupEventsByMonth(List<Employee> employees) {
    List<Event> allEvents = [];

    for (var employee in employees) {
      // Add birthday event
      allEvents.add(Event(
        date: DateTime(DateTime.now().year, employee.dateOfBirth.month,
            employee.dateOfBirth.day),
        title: employee.fullName,
        subtitle: employee.birthdayString,
        icon: Icons.cake_outlined,
      ));

      // Add anniversary event
      allEvents.add(Event(
        date: DateTime(DateTime.now().year, employee.yearOfEmployment.month,
            employee.yearOfEmployment.day),
        title: employee.fullName,
        subtitle: employee.anniversaryString,
        icon: Icons.celebration_outlined,
      ));
    }

    // Sort events by date
    allEvents.sort((a, b) => a.date.compareTo(b.date));

    // Group events by month
    Map<String, List<Event>> groupedEvents = {};
    for (var event in allEvents) {
      String monthKey = DateFormat('MMMM').format(event.date);
      if (!groupedEvents.containsKey(monthKey)) {
        groupedEvents[monthKey] = [];
      }
      groupedEvents[monthKey]!.add(event);
    }

    return groupedEvents;
  }
}
