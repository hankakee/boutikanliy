import 'package:flutter/material.dart';
import 'screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EBoutikoo',
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: const Login(),
      // home: const MyHomePage(title: 'EBoutikoo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              // color: const Color(0xFF994CFC),
              // padding: const EdgeInsets.only(left: 20.0, top: 50.0),
              // child: const Text(
              //   "Hangman",
              //   style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       color: Colors.white,
              //       fontSize: 30.0),
              // ),
              child: Image.asset('banner.png', fit: BoxFit.cover),
              height: 250.0,
            ),
            ListTile(
                onTap: () {
                  // callbackReplay("loose");
                },
                title: const Text(
                  "Rejwe",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                )),
            ListTile(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const EdScreen()));
                  print("Ed klike");
                },
                title: const Text("Ed",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0))),
            ListTile(
                onTap: () {
                  // print("soti hangman tile");
                  // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                title: const Text("Kite",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0))),
          ],
        ),
      ),

      appBar: AppBar(
        backgroundColor: const Color(0XFF994CFC),
        title: SizedBox(
          width: 200,
          child: Image.asset('eboutik.png', fit: BoxFit.cover),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // SizedBox(
            //   width: 300,
            //   height: 100,
            //   child: Image.asset('banner.png', fit: BoxFit.cover),
            // ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0XFFF9BF16),
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.shopping_cart),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
