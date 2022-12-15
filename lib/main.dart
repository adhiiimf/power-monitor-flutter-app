import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:acpwrmonitorapp/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SysColors {
  SysColors._();
  static const Color blackColor = Color.fromRGBO(30, 30, 30, 1);
  static const Color greyColor = Color.fromRGBO(210, 210, 210, 1);
  static const Color whiteColor = Color.fromRGBO(255, 255, 255, 1);
  static const Color greenColor = Color.fromRGBO(2, 199, 69, 1);
  static const Color redColor = Color.fromRGBO(234, 35, 35, 1);
  static const Color orangeColor = Color.fromRGBO(255, 203, 69, 1);
  static const Color orangedarkColor = Color.fromRGBO(255, 159, 69, 1);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final SP_URL = dotenv.env['SUPABASE_URL'].toString();
  final SP_API = dotenv.env['SUPABASE_KEY'].toString();
  await Supabase.initialize(
    url: SP_URL,
    anonKey: SP_API,
    debug: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'FrancoisOne',
          backgroundColor: Color.fromARGB(255, 46, 44, 44)),
      debugShowCheckedModeBanner: false,
      title: 'Power Meter Apps',
      home: HomePage(),
    );
  }
}
