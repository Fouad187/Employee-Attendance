
import 'package:attendance/Models/location_model.dart';
import 'package:attendance/Providers/location_services.dart';
import 'package:attendance/Providers/modal_hud.dart';
import 'package:attendance/Widgets/attendance_information.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
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
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<Modal>(context).isChange,
        color: Colors.black54,
        child: Padding(
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
                      final modalInstance = Provider.of<Modal>(context, listen: false);
                      modalInstance.changeIsLoading(true);
                      await instance.getLocation();
                      modalInstance.changeIsLoading(false);
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
                        instance.checkOut();
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
      ),
    );
  }
}
