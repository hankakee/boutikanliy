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
  late List<Widget> tabwidget = [];

  @override
  void initState() {
    super.initState();
    loadProfile();
    getCategories();
  }

  final storage = const FlutterSecureStorage();

  void loadProfile() async {
    dynamic avatar = await storage.read(key: "avatar");
    if (avatar != null) {
      setState(() => {profileUser = avatar});
    } else {
      profileUser = "profile";
    }
  }

  void getCategories() async {
    var result = await APIService.get(ServerConfig.apiUrl + "categories", null);
    print("men result yo:");
    // print(result);

    List<Widget> tmptabwidget = [];
    // result.map((e) => {print(e.toString())});
    for (int i = 0; i < 2; i++) {
      tmptabwidget.add(
        Container(
          margin: const EdgeInsets.only(bottom: 9.0),
          width: double.infinity,
          height: 120.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(result[i]["name"]),
          ),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 22, 96, 156),
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
                child: Text(result[3]["name"]),
              ),
            ]),
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 74, 0, 247),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Container(
            child: Column(children: [
              Container(
                width: double.infinity,
                height: 120.0,
                child: Image.network(result[4]['image'], fit: BoxFit.cover),
              ),
              Container(
                child: Text(result[4]["name"]),
              ),
            ]),
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 74, 0, 247),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    ));
    // print(tmptabwidget);
    if (tmptabwidget.isNotEmpty) {
      setState(() => {tabwidget = List.from(tmptabwidget)});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomizedDrawer(),
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
            child: Column(children: [
              // -------------------- 2 box category-----------------------------------------
              Container(
                  width: double.infinity,
                  // color: Colors.tealAccent,
                  child: const Text(
                    "Kategori vedèt",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.grey, fontSize: 17.0),
                  )),

              ///generated boxes
              ///
              ///
              ///
              ...tabwidget,

              ///
              ///
              ///
              //2 box grid category

              // -----------------------------------------------------
            ]),
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
