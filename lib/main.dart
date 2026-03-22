import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const PriceRadarApp());
}
class PriceRadarApp extends StatelessWidget {
  const PriceRadarApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PriceRadar',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: const Color(0xFF00BCD4),
        scaffoldBackgroundColor: const Color(0xFF0A0E14),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D1117),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color(0xFF00E5FF),
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
          iconTheme: IconThemeData(color: Color(0xFF00E5FF)),
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF131920),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xFF0D1117),
          indicatorColor: const Color(0xFF00BCD4).withOpacity(0.2),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00BCD4),
            foregroundColor: Colors.black,
            elevation: 4,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF131920),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF1E2A35)),
          enabledBorder: OutlineInputBorder(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF00BCD4), width: 2),
          hintStyle: TextStyle(color: Colors.grey[600]),
          prefixIconColor: const Color(0xFF00BCD4),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
          headlineMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          bodyLarge: TextStyle(color: Color(0xFFB0BEC5)),
          bodyMedium: TextStyle(color: Color(0xFF8899A6)),
        dividerColor: const Color(0xFF1E2A35),
      ),
      home: const SplashScreen(),
    );
  }
