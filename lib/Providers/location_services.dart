import 'package:attendance/Models/attendance_model.dart';
import 'package:attendance/Models/location_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class LocationServices extends ChangeNotifier {

  //Set Location
  Location location = Location(
    locationName: 'Office 1',
    radius: 5.0,
    longitude: 31.3122344,
    latitude: 30.3138392,
  );

  bool inRange=false;   // to detect if user in range
  bool isAttend=false;  // to detect if user attended before or not
  Attendance attendance; // Object of attendance
  var currentPosition;

  /*
    Get Location Function get user location by Geolocator package and pass the location to
    calculate distance between the location and office
   */
  getLocation() async
  {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) {
          currentPosition=value;
          getDistance(startLatitude: value.latitude, startLongitude: value.longitude);
        }
    ).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: 'can\'t get current location now' , toastLength: Toast.LENGTH_LONG);
    });
  }

  // get distance in meter between two location and pass value to check if in range or not

  getDistance({double startLatitude, double startLongitude }) {
    double distanceInMeters = Geolocator.distanceBetween(
        startLatitude, startLongitude, location.latitude, location.longitude).floorToDouble();
    checkInRange(distanceInMeters);
  }

  /*
   Check if user in range which set by the manager and if in range
   fill the attendance object with information needed and if else
   show message to user
   */
  checkInRange(double distance) {

    if (distance <= location.radius)
      {
        inRange=true;
        isAttend=true;
        attendance=Attendance(
          locationName: location.locationName,
          name: 'Fouad Abd-Elaziz',
          time: TimeOfDay.now(),
          type: 'Check in',
          date: DateTime.now(),
          currentLatitude: currentPosition.latitude,
          currentLongitude:  currentPosition.longitude,
        );
        notifyListeners();
      }
    else
      {
        inRange=false;
        Fluttertoast.showToast(msg: 'You are outside the specified range', toastLength: Toast.LENGTH_LONG);
        notifyListeners();
      }
  }

  /*
    in this function i check if user attended ? make checkout and update his attendance object
    and if else show message to user tell him he did'nt check in first
   */
  checkOut() {
    inRange=false;
    if(attendance !=null)
      {
        attendance.date=DateTime.now();
        attendance.time= TimeOfDay.now();
        attendance.type='Check out';
        attendance.currentLatitude=currentPosition.latitude;
        attendance.currentLongitude=currentPosition.longitude;
      }
    else
      {
        Fluttertoast.showToast(msg: 'Please Check in first' , toastLength: Toast.LENGTH_LONG);
      }
    notifyListeners();
  }
}
