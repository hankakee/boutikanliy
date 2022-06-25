import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BoutikAnliy());
}

class BoutikAnliy extends StatelessWidget {
  const BoutikAnliy({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EBoutikoo',
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      // home: const Login(),
      home: const Home(title: 'EBoutikoo'),
    );
  }
}
