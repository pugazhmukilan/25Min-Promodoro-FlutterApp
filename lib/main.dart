import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:promodoro/Screens/Homepage/HomePage.dart';
import 'package:promodoro/Screens/Homepage/ThemeIcon.dart';
import 'package:promodoro/Screens/bloc/timer_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Constants.dart' as co;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('sessionsdatabase'); // Example box initialization
  // Load theme, default to false if null
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ThemeMode _themeMode = ThemeMode.dark; // Initial theme mode

  @override
  void initState() {
    super.initState();
    _loadTheme(); // Load theme from SharedPreferences on startup
  }

  Future<void> _loadTheme() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final bool? isDarkPref = pref.getBool("dark");
    setState(() {
      _themeMode = isDarkPref == true ? ThemeMode.dark : ThemeMode.light;
    });
  }

  // Function to toggle theme
  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
    _saveTheme(); // Save the new theme to SharedPreferences
  }

  Future<void> _saveTheme() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool("dark", _themeMode == ThemeMode.dark);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerBloc(),
      child: MaterialApp(
        theme: ThemeData.light(), // Light theme
        darkTheme: ThemeData.dark(), // Dark theme
        themeMode: _themeMode, // Current theme mode
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Homepage(
              toggleTheme: toggleTheme, // Pass the toggle function
            ),
          ),
        ),
      ),
    );
  }
}
