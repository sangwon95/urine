
import 'package:flutter/material.dart';

class Event {
  final DateTime dateTime;
  final String userID;
  final String name;
  final String position;
  final String title;
  final String subTitle;
  bool isApprove;
  final Color color;

  Event({
    required this.name,
    required this.position,
    required this.dateTime,
    required this.userID,
    required this.title,
    required this.subTitle,
    required this.color,
    this.isApprove = false,
  });
}