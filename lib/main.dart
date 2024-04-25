import 'package:flutter/material.dart';

import 'package:aplicacion_productos/screens/screens.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: 'login',
      routes: {
        'login': (_)=>LoginScreen(),
        'home': (_)=>HomeScreen(),
      },
    );
  }
}