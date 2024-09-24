import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'presentation/events_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String jsonData = await rootBundle.loadString('assets/data_json.json');
  log("jsonData: ${jsonData.runtimeType}");
  runApp(EventsApp(jsonData: jsonData));
}
