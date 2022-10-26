import 'package:flutter/material.dart';
import 'package:sqflite_tutorial/src/home/data/repository/sql_database.dart';
import 'package:sqflite_tutorial/src/home/presentation/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // 채널(native)간 비동기 보장
  SqlDataBase(); // database execute
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

