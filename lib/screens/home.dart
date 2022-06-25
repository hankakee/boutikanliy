import "package:flutter/material.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String profileUser = "";
  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  final storage = const FlutterSecureStorage();

  void loadProfile() async {
    dynamic avatar = await storage.read(key: "avatar");
    print("avatar in this bro");
    print(avatar);
    if (avatar != null) {
      setState(() => {profileUser = avatar});
    } else {
      profileUser = "profile";
    }
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
              child: Center(
                child: Container(
                    margin: const EdgeInsets.only(top: 90.0),
                    width: 150.0,
                    height: 150.0,
                    // TODO load image from profile
                    child: Text("Profile"),
                    // profileUser == "profile"
                    //     ? Image.network(
                    //         profileUser,
                    //         loadingBuilder: (BuildContext context, Widget child,
                    //             ImageChunkEvent? loadingProgress) {
                    //           if (loadingProgress == null) {
                    //             return child;
                    //           }
                    //           return Center(
                    //             child: CircularProgressIndicator(
                    //               value: loadingProgress.expectedTotalBytes !=
                    //                       null
                    //                   ? loadingProgress.cumulativeBytesLoaded /
                    //                       loadingProgress.expectedTotalBytes!
                    //                   : null,
                    //             ),
                    //           );
                    //         },
                    //       )
                    //     : const Text("ImageProfile"),
                    decoration: const BoxDecoration(shape: BoxShape.circle)),
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("banner.png"), fit: BoxFit.cover),
              ),
              height: 250.0,
              width: double.infinity,
            ),
            ListTile(
                onTap: () {
                  // callbackReplay("loose");
                },
                title: const Text(
                  "Konekte",
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
                title: const Text("Lis pwodui",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0))),
            ListTile(
                onTap: () {
                  // print("soti hangman tile");
                  // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                title: const Text("Dekonekte",
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
      body: SingleChildScrollView(
        child: Container(
          height: 900.0,
          padding: const EdgeInsets.only(top: 20.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: double.infinity,
                    // color: Colors.tealAccent,
                    child: const Text(
                      "Kategori vedèt",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.grey, fontSize: 17.0),
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 9.0),
                  width: double.infinity,
                  height: 120.0,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Brother 1"),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 9.0, bottom: 9.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    width: double.infinity,
                    height: 120.0,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Brother 2"),
                    )),
                Flexible(
                  child: GridView.count(
                    primary: false,
                    // padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    crossAxisCount: 2,
                    children: [
                      Container(
                        color: Color.fromARGB(255, 59, 88, 255),
                        child: Text("Texte 1"),
                        padding: EdgeInsets.all(4.0),
                      ),
                      Container(
                        color: Color.fromARGB(255, 247, 0, 115),
                        child: Text("Texte 2"),
                        padding: EdgeInsets.all(4.0),
                      ),
                    ],
                  ),
                ),
                //Container pwodui
                Container(
                    width: double.infinity,
                    // color: Colors.tealAccent,
                    child: const Text(
                      "Pwodui vedèt",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.grey, fontSize: 17.0),
                    )),
                Container(
                  child: Flexible(
                    child: GridView.count(
                      primary: false,
                      // padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                      crossAxisCount: 2,
                      children: [
                        Container(
                          color: Color.fromARGB(255, 59, 88, 255),
                          child: Text("Texte 1"),
                          padding: EdgeInsets.all(4.0),
                        ),
                        Container(
                          color: Color.fromARGB(255, 247, 0, 115),
                          child: Text("Texte 2"),
                          padding: EdgeInsets.all(4.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0XFFF9BF16),
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.shopping_cart),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
