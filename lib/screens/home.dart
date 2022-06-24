import "package:flutter/material.dart";
import '../services/Drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(Icons.menu_sharp),
        //   onPressed: CustomizedDrawer().build(context),
        // ),
        iconTheme: const IconThemeData(color: Color(0XFF994CFC)),
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
