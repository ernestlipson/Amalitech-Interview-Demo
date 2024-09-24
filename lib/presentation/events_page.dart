import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

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
        title: const Text('Events'),
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
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  month,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: events.length,
                itemBuilder: (context, eventIndex) {
                  Event event = events[eventIndex];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: Theme.of(context).colorScheme.error,
                      child: Text(
                        event.title[0].toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(event.title),
                    subtitle: Text(event.subtitle),
                  );
                },
              ), // Space between months
            ],
          );
        },
      ),
    );
  }
}
