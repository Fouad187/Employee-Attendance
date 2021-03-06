import 'package:attendance/Providers/location_services.dart';
import 'package:attendance/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Providers/modal_hud.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocationServices>(create: (context) =>LocationServices() ,),
        ChangeNotifierProvider<Modal>(create: (context) => Modal(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
