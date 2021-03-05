import 'package:attendance/Providers/location_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttendanceInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final instance=Provider.of<LocationServices>(context);
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(15),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name : ${instance.attendance.name}'),
            SizedBox(height: 10,),
            Text('Location : ${instance.attendance.locationName}'),
            SizedBox(height: 10,),
            Row(
              children: [
                Text('Status : '),
                Text(instance.attendance.type , style: TextStyle(color: instance.attendance.type=='Check in' ? Colors.green : Colors.red),)
              ],
            ),
            SizedBox(height: 10,),
            Text('Time : ${instance.attendance.time.format(context)}'),
            SizedBox(height: 10,),
            Text('Date : ${instance.attendance.date.year}-${instance.attendance.date.month}-${instance.attendance.date.day}'),
            SizedBox(height: 10,),
            Text('Current Latitude : ${instance.attendance.currentLatitude}'),
            SizedBox(height: 10,),
            Text('Current Longitude : ${instance.attendance.currentLongitude}'),
          ],
        ),
      ),
    );
  }
}
