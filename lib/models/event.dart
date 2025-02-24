import 'package:flutter/material.dart';

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
