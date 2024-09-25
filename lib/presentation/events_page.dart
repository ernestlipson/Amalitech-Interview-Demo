import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/employee_model.dart';
import '../utility/utility.dart';

class EventsApp extends StatelessWidget {
  final String jsonData;

  const EventsApp({super.key, required this.jsonData});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Events App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EventsPage(jsonData: jsonData),
    );
  }
}

class EventsPage extends StatefulWidget {
  final String jsonData;

  const EventsPage({super.key, required this.jsonData});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  late List<Employee> employees;
  late Map<String, List<Event>> groupedEvents;

  @override
  void initState() {
    super.initState();
    List<dynamic> jsonList = json.decode(widget.jsonData);
    employees = jsonList.map((json) => Employee.fromJson(json)).toList();
    groupedEvents = EventUtility.groupEventsByMonth(employees);
    log("Grouped Events: $groupedEvents");
    log("Birthday Event: ${employees.first.anniversaryString}");
  }

  @override
  Widget build(BuildContext context) {
    var months = groupedEvents.keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Events',
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: months.length,
        itemBuilder: (context, index) {
          String month = groupedEvents.keys.elementAt(index);
          List<Event> events = groupedEvents[month]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    month,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontSize: 23, fontWeight: FontWeight.bold),
                  )),
              ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: events.length,
                itemBuilder: (context, eventIndex) {
                  Event event = events[eventIndex];
                  String formattedDate = formatDateWithSuffix(event.date);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedDate,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54),
                      ),
                      ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
                        leading: CircleAvatar(
                          radius: 26,
                          backgroundColor: Theme.of(context).colorScheme.error,
                          child: Text(
                            event.title[0].toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          event.title,
                          style: const TextStyle(fontSize: 17),
                        ),
                        subtitle: Row(children: [
                          Icon(event.icon, color: Colors.black54),
                          const SizedBox(width: 18),
                          Text(event.subtitle,
                              style: const TextStyle(color: Colors.black54))
                        ]),
                      ),
                      const SizedBox(height: 10)
                    ],
                  );
                },
              ),
              const SizedBox(height: 18) // Space between months
            ],
          );
        },
      ),
    );
  }
}

String formatDateWithSuffix(DateTime date) {
  String day = getDayWithSuffix(date.day);

  String formattedDate = DateFormat("MMMM, yyyy").format(date);

  return "$day $formattedDate";
}

String getDayWithSuffix(int day) {
  if (day >= 11 && day <= 13) {
    return "${day}th";
  }

  switch (day % 10) {
    case 1:
      return "${day}st";
    case 2:
      return "${day}nd";
    case 3:
      return "${day}rd";
    default:
      return "${day}th";
  }
}
