
import 'package:attendance/Models/location_model.dart';
import 'package:attendance/Providers/location_services.dart';
import 'package:attendance/Widgets/attendance_information.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final instance=Provider.of<LocationServices>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Attendance'),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            instance.isAttend ? instance.inRange ? Center(child: Text('Your Are Check in' , style: TextStyle(color: Colors.green , fontWeight: FontWeight.bold , fontSize: 20),)) :
            Center(child: Text('You Are Checked out', style: TextStyle(color: Colors.red , fontWeight: FontWeight.bold , fontSize: 20))) : Container(),
            SizedBox(height: 20,),
            Center(
              child: Container(
                width: 200,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('Check in' , style: TextStyle(color: Colors.white),),
                  color: Colors.blue,
                  onPressed: () async {
                    await instance.GetLocation();
                  },
                )
              ),
            ),
            Center(
              child: Container(
                  width: 200,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('Check out' , style: TextStyle(color: Colors.white),),
                    color: Colors.blue,
                    onPressed: () {
                      instance.CheckOut();
                    },
                  )
              ),
            ),
            SizedBox(height: 50,),
            instance.isAttend ? Text('Attendance : ' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),) : Container(),
            SizedBox(height: 10,),
            instance.isAttend ? AttendanceInformation() : Container(),
          ],
        ),
      ),
    );
  }
}
