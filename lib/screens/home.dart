import 'dart:ui';

import "package:flutter/material.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:boutikanliy/services/server_config.dart';
import "package:boutikanliy/services/api.dart";
import 'drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String profileUser = "";
  late List<Widget> tabCategory = [];
  late List<Widget> tabProducts = [];
  final cardsColor = Colors.grey[300];
  Color primaryAppColor = Color(0XFF994CFC);
  @override
  void initState() {
    loadProfile();
    getCategories();
    getProducts();
    super.initState();
  }

  int selectedIndex = 1;

  final storage = const FlutterSecureStorage();

  void loadProfile() async {
    dynamic avatar = await storage.read(key: "avatar");
    if (avatar != null) {
      setState(() => {profileUser = avatar});
    } else {
      profileUser = "profile";
    }
  }

  void getProducts() async {
    var result = await APIService.get(
        ServerConfig.apiUrl + "products?offset=0&limit=6", null);

    // print("men result yo:");
    // print(result[0]);
    // print(result.length);
    List<Widget> tmpProductswidget = [];
    for (int i = 0; i < 6; i++) {
      tmpProductswidget.add(
        Container(
          margin: const EdgeInsets.only(bottom: 9.0),
          width: double.infinity,
          height: 230.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Container(
                width: double.infinity,
                height: 90.0,
                // child: Text("Brother 2"),
                child: Image.network(result[i]["category"]["image"],
                    fit: BoxFit.cover),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  formatTitle(result[i]["title"]),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: primaryAppColor,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 1.0),
                child: Stack(
                  children: [
                    Positioned(
                      right: 4.0,
                      top: 4.0,
                      child: Icon(Icons.favorite,
                          size: 18.0, color: primaryAppColor), //Icon
                    ),
                    Container(
                      width: double.infinity,
                      // color: Colors.red,
                      child: Text(
                        result[i]["price"].toString() + "\$",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: primaryAppColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: 4.0,
                      top: 4.0,
                      child: Icon(Icons.shopping_bag_rounded,
                          size: 25.0, color: Colors.grey), //Icon
                    ),
                  ],
                ),
              ),
            ]),
          ),
          decoration: BoxDecoration(
            color: cardsColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      );
    }
    // print(tmpProductswidget);
    setState(() => {
          if (tmpProductswidget.isNotEmpty)
            {tabProducts = List.from(tmpProductswidget)}
        });
  }

  String formatTitle(String textDesc) {
    if (textDesc.length > 15) {
      return textDesc.substring(0, 15) + "...";
    }
    return textDesc;
  }

  void getCategories() async {
    var result = await APIService.get(ServerConfig.apiUrl + "categories", null);
    // print("men result yo:");
    // print(result);
    // print(result[4]['image']);
    List<Widget> tmptabwidget = [];
    // result.map((e) => {print(e.toString())});
    for (int i = 0; i < 2; i++) {
      tmptabwidget.add(
        Container(
          margin: const EdgeInsets.only(bottom: 9.0),
          width: double.infinity,
          height: 200.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Container(
                width: double.infinity,
                height: 140.0,
                child: Image.network(result[i]["image"], fit: BoxFit.cover),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  result[i]["name"],
                  style: TextStyle(
                      fontSize: 15.0,
                      color: primaryAppColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ]),
          ),
          decoration: BoxDecoration(
            color: cardsColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      );
    }

    tmptabwidget.add(Container(
      child: GridView.count(
        primary: false,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        crossAxisCount: 2,
        shrinkWrap: true,
        children: [
          // const SizedBox(
          //   child: Padding(padding: EdgeInsets.only(top: 5.0)),
          // ),
          Container(
            child: Column(children: [
              Container(
                width: double.infinity,
                height: 120.0,
                child: Image.network(result[3]["image"], fit: BoxFit.cover),
              ),
              Container(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(result[3]["name"]),
              ),
            ]),
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: cardsColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Container(
            child: Column(children: [
              Container(
                width: double.infinity,
                height: 120.0,
                child: Image.network(result[4]["image"], fit: BoxFit.cover),
              ),
              Container(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(result[4]["name"]),
              ),
            ]),
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: cardsColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    ));
    // print(tmptabwidget);
    // print(MediaQuery.of(context).size.height);
    if (tmptabwidget.isNotEmpty) {
      setState(() => {tabCategory = List.from(tmptabwidget)});
    }
  }

  Widget akeyInnerScreen() {
    return Container(
      // 1400.0,
      height: 1400,
      padding: const EdgeInsets.only(top: 20.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(children: [
          // -------------------- 2 box category-----------------------------------------
          Container(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              width: double.infinity,
              child: const Text(
                "Kategori vedèt",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.grey, fontSize: 17.0),
              )),
          //generated boxes
          ...tabCategory,
          Container(
              padding: const EdgeInsets.only(top: 60.0),
              width: double.infinity,
              child: const Text(
                "Pwodui vedèt",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.grey, fontSize: 17.0),
              )),
          const SizedBox(
              child: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
          )),
          Container(
              child: GridView.count(
                  shrinkWrap: true,
                  primary: false,
                  // padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  crossAxisCount: 2,
                  children: tabProducts)),
        ]),
      ),
    );
  }

  static List<Widget> _widgetOptions = <Widget>[
    Container(
      // 1400.0,
      height: 1400,
      padding: const EdgeInsets.only(top: 20.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(children: [
          // -------------------- 2 box category-----------------------------------------
          Container(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              width: double.infinity,
              child: const Text(
                "Kategori vedèt",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.grey, fontSize: 17.0),
              )),
          //generated boxes
          ...tabCategory,
          Container(
              padding: const EdgeInsets.only(top: 60.0),
              width: double.infinity,
              child: const Text(
                "Pwodui vedèt",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.grey, fontSize: 17.0),
              )),
          const SizedBox(
              child: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
          )),
          Container(
              child: GridView.count(
                  shrinkWrap: true,
                  primary: false,
                  // padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  crossAxisCount: 2,
                  children: tabProducts)),
        ]),
      ),
    );
    Text(
      'Index 1: Favori',
    ),
    Text(
      'Index 2: Panye',
    )
  ];

  void _changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow),
              label: 'Akèy',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.playlist_play),
              label: 'Favori',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Panye',
            ),
          ],
          selectedItemColor: primaryAppColor,
          currentIndex: selectedIndex,
          onTap: _changeIndex),
      drawer: const CustomizedDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: primaryAppColor,
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(Icons.menu_sharp),
        //   onPressed: CustomizedDrawer().build(context),
        // ),
        iconTheme: IconThemeData(color: primaryAppColor),
        title: SizedBox(
          width: 200,
          child: Image.asset('eboutik.png', fit: BoxFit.cover),
        ),

        // bottom: TabBar(
        //   tabs: [
        //     Tab(
        //         child: Text(
        //       'Akèy',
        //       style: TextStyle(color: primaryAppColor),
        //     )),
        //     Tab(
        //         child: Text(
        //       'Favori',
        //       style: TextStyle(color: primaryAppColor),
        //     )),
        //     Tab(
        //         child: Text(
        //       'Panye',
        //       style: TextStyle(color: primaryAppColor),
        //     )),
        //   ],
        // ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(selectedIndex),
      ),
    );
  }
}
