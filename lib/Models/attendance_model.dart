import 'package:flutter/material.dart';

class Attendance
{
  String name;
  DateTime date;
  String type;
  TimeOfDay time;
  String locationName;
  double  currentLatitude;
  double  currentLongitude;

  Attendance({this.name, this.date, this.type, this.time, this.locationName, this.currentLatitude, this.currentLongitude});
}