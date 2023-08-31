import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_service/screens/auth_screen/auth_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color.fromRGBO(7, 0, 255, 1),
        ),
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.ubuntu(fontSize: 32),
          headlineMedium: GoogleFonts.ubuntu(fontSize: 22, color: Colors.black),
          labelLarge: GoogleFonts.ubuntu(
            fontSize: 17,
            color: Colors.white,
          ),
          bodyLarge: GoogleFonts.roboto(
            fontSize: 64,
            color: Colors.white,
          ),
          bodyMedium: GoogleFonts.roboto(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
      home: const AuthScreen(),
    );
  }
}
