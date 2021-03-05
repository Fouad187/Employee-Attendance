import 'package:attendance/Models/attendance_model.dart';
import 'package:attendance/Models/location_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class LocationServices extends ChangeNotifier {
  Location location = Location(
    locationName: 'Office 1',
    radius: 5.0,
    longitude: 31.3122344,
    latitude: 30.3138392,
  );

  double distanceInMeters = 0.0;
  bool inRange=false;
  bool isAttend=false;
  Attendance attendance;
  var currentPosition;

  GetLocation() async
  {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) {
          currentPosition=value;
          GetDistance(startLatitude: value.latitude, startLongitude: value.longitude);
        }
    );

    /*
    await Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.best).listen((event) {
         currentPosition=value;
     GetDistance(startLatitude: event.latitude , startLongitude: event.longitude);
   });
    */
  }

  GetDistance({double startLatitude, double startLongitude }) {
    distanceInMeters = Geolocator.distanceBetween(
        startLatitude, startLongitude, location.latitude, location.longitude).floorToDouble();
    CheckinRange(distanceInMeters);
  }
  CheckinRange(double distance) {

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
  CheckOut() {
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
