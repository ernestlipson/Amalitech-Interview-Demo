import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/employee_model.dart';
import '../models/event.dart';

class EventUtility {
  static Map<String, List<Event>> groupEventsByMonth(List<Employee> employees) {
    List<Event> allEvents = _getAllEvents(employees);
    allEvents.sort((a, b) => a.date.compareTo(b.date));
    return _groupEventsByMonth(allEvents);
  }

  static List<Event> _getAllEvents(List<Employee> employees) {
    List<Event> allEvents = [];
    for (var employee in employees) {
      allEvents.add(_createBirthdayEvent(employee));
      allEvents.add(_createAnniversaryEvent(employee));
    }
    return allEvents;
  }

  static Event _createBirthdayEvent(Employee employee) {
    return Event(
      date: DateTime(DateTime.now().year, employee.dateOfBirth.month,
          employee.dateOfBirth.day),
      title: employee.fullName,
      subtitle: employee.birthdayString,
      icon: Icons.cake_outlined,
    );
  }

  static Event _createAnniversaryEvent(Employee employee) {
    return Event(
      date: DateTime(DateTime.now().year, employee.yearOfEmployment.month,
          employee.yearOfEmployment.day),
      title: employee.fullName,
      subtitle: employee.anniversaryString,
      icon: Icons.celebration_outlined,
    );
  }

  static Map<String, List<Event>> _groupEventsByMonth(List<Event> events) {
    Map<String, List<Event>> groupedEvents = {};
    for (var event in events) {
      String monthKey = DateFormat('MMMM').format(event.date);
      if (!groupedEvents.containsKey(monthKey)) {
        groupedEvents[monthKey] = [];
      }
      groupedEvents[monthKey]!.add(event);
    }
    return groupedEvents;
  }
}
