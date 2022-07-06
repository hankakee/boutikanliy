import 'package:flutter/material.dart';
import 'screens/Home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BoutikAnliy());
}

class BoutikAnliy extends StatefulWidget {
  const BoutikAnliy({Key? key}) : super(key: key);

  @override
  State<BoutikAnliy> createState() => _BoutikAnliyState();
}

class _BoutikAnliyState extends State<BoutikAnliy> {
  @override
  void initState() {
    readToken();
    super.initState();
  }

  final storage = const FlutterSecureStorage();
  String tokenuser = "notoken";
  void readToken() async {
    dynamic tu = await storage.read(key: "access_token");
    setState(() => {tokenuser = tu});
    // print(tokenuser);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EBoutikoo',
      debugShowCheckedModeBanner: false,
      home: Container(
        child:
            // tokenuser == "notoken"
            //     ? const Login()
            const Home(title: 'EBoutikoo'),
      ),
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
    );
  }
}
