import 'package:boutikanliy/screens/allproducts.dart';
import "package:flutter/material.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:boutikanliy/services/server_config.dart';
import "package:boutikanliy/services/api.dart";
import "package:boutikanliy/services/storage.dart";
import 'custom_drawer.dart';
import 'package:boutikanliy/services/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String profileUser = "profile";
  String nameclient = "N/A";
  String mailclient = "N/A";
  late List<Widget> tabCategory = [];
  late List tabProducts = [];
  late List<int> shoppingCartTab = [];
  late List<int> favoritesTab = [];
  bool loaded = false;
  @override
  void initState() {
    loadProfile();
    getCategories();
    getProducts();
    getShoppingCart();
    getFavorites();
    super.initState();
  }

  int selectedIndex = 1;

  final storage = const FlutterSecureStorage();
  String formatTitle(String textDesc) {
    if (textDesc.length > 13) {
      return textDesc.substring(0, 13) + "...";
    }
    return textDesc;
  }

  void loadProfile() async {
    dynamic avatar = await storage.read(key: "avatar");
    dynamic namex = await storage.read(key: "name");
    dynamic emailex = await storage.read(key: "email");
    if (avatar != null) {
      setState(() =>
          {profileUser = avatar, nameclient = namex, mailclient = emailex});
    } else {
      profileUser = "profile";
    }
  }

  void getProducts() async {
    var result = await APIService.get(
        ServerConfig.apiUrl + "products?offset=0&limit=6", null);
    setState(() => {tabProducts = result, loaded = true});
    // print(tabProducts);
  }

  void getShoppingCart() async {
    var shop = await Storage.showCart();
    List<int> idLists = [];
    for (var k = 0; k < shop.length; k++) {
      idLists.add(shop[k][0] as int);
    }
    setState(() => {shoppingCartTab = idLists});
  }

  void getFavorites() async {
    var shop = await Storage.showFavs();
    List<int> idLists = [];
    for (var k = 0; k < shop.length; k++) {
      idLists.add(shop[k][0] as int);
    }
    setState(() => {favoritesTab = idLists});
  }

  void getCategories() async {
    var result = await APIService.get(ServerConfig.apiUrl + "categories", null);
    // print("men result yo:");
    // print(result);
    // print(result[4]['image']);
    List<Widget> tmptabwidget = [];
    for (int i = 0; i < 2; i++) {
      tmptabwidget.add(
        Container(
          margin: const EdgeInsets.only(bottom: 9.0),
          width: double.infinity,
          height: 200.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(children: [
              Container(
                width: double.infinity,
                height: 190.0,
                child: Image.network(result[i]["image"], fit: BoxFit.cover),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.only(left: 6.0),
                  color: Constants.cardsColor,
                  child: Text(
                    result[i]["name"],
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Constants.primaryAppColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ]),
          ),
          decoration: BoxDecoration(
            color: Constants.cardsColor,
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
                height: 130.0,
                child: Image.network(result[3]["image"], fit: BoxFit.cover),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    result[3]["name"],
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Constants.primaryAppColor,
                        fontWeight: FontWeight.bold),
                  )),
            ]),
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Constants.cardsColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Container(
            child: Column(children: [
              Container(
                width: double.infinity,
                height: 130.0,
                child: Image.network(result[4]["image"], fit: BoxFit.cover),
              ),
              Container(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  result[4]["name"],
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Constants.primaryAppColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ]),
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Constants.cardsColor,
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

  Widget akeyInnerScreen(context) {
    return SingleChildScrollView(
      child: Container(
        height: 1600,
        padding: const EdgeInsets.only(top: 40.0),
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
                padding: const EdgeInsets.only(top: 40.0),
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
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  crossAxisCount: 2,
                  children: tabProducts.map((pr) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 9.0),
                      width: double.infinity,
                      height: 230.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          GestureDetector(
                            onTap: () {
                              // actionsprods("view", id);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 90.0,
                              child: Image.network(pr['images'][1],
                                  fit: BoxFit.cover),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              Constants.formatTitle(pr['title']),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Constants.primaryAppColor,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 1.0),
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                    pr['price'].toString() + "HTG",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Constants.primaryAppColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Positioned(
                                  right: 4.0,
                                  top: 4.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      Storage.addtoFavorites(pr);
                                      setState(() {
                                        favoritesTab.contains(pr['id'])
                                            ? favoritesTab.removeWhere(
                                                (el) => el == pr['id'])
                                            : favoritesTab.add(pr['id']);
                                      });
                                    },
                                    child: Icon(
                                        favoritesTab.contains(pr['id'])
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 22.0,
                                        color: favoritesTab.contains(pr['id'])
                                            ? Colors.pinkAccent
                                            : Colors.grey),
                                  ), //Icon
                                ),
                                Positioned(
                                  left: 4.0,
                                  top: 4.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      Storage.addtoCart(pr);
                                      setState(() {
                                        shoppingCartTab.contains(pr['id'])
                                            ? shoppingCartTab.removeWhere(
                                                (el) => el == pr['id'])
                                            : shoppingCartTab.add(pr['id']);
                                      });
                                    },
                                    child: Icon(
                                        shoppingCartTab.contains(pr['id'])
                                            ? Icons.shopping_cart_rounded
                                            : Icons.shopping_cart_outlined,
                                        size: 25.0,
                                        color:
                                            shoppingCartTab.contains(pr['id'])
                                                ? Constants.secondaryAppColor
                                                : Colors.grey),
                                  ), //Icon
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                      decoration: BoxDecoration(
                        color: Constants.cardsColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }).toList()),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AllProducts()));
              },
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Wè plis pwodui...",
                        style: TextStyle(
                            color: Constants.primaryAppColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.playlist_add_outlined,
                          color: Constants.primaryAppColor)
                    ],
                  )),
            )
          ]),
        ),
      ),
    );
  }

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
              icon: Icon(Icons.favorite),
              label: 'Favori',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Akèy',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_sharp),
              label: 'Panye',
            ),
          ],
          selectedItemColor: Constants.primaryAppColor,
          currentIndex: selectedIndex,
          onTap: _changeIndex),
      drawer: CustomizedDrawer()
          .buildDrawerOwn(context, profileUser, nameclient, mailclient),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Constants.primaryAppColor,
        // elevation: 0,
        // leading: IconButton(
        //   icon: Icon(Icons.menu_sharp),
        //   onPressed: CustomizedDrawer().build(context),
        // ),
        actions: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Storage.removeKey("cart");
              },
              child: Text(
                "PEYE",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Constants.primaryAppColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
        leadingWidth: 40.0,
        iconTheme: IconThemeData(color: Constants.primaryAppColor),
        title: Container(
          width: 120,
          child: Image.asset('eboutik.png', fit: BoxFit.cover),
        ),
      ),
      body: Container(
          child: selectedIndex == 1
              ? loaded == false
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Constants.primaryAppColor,
                      ),
                    )
                  : akeyInnerScreen(context)
              : (selectedIndex == 0
                  ? Center(child: Text("Favori"))
                  : Center(child: Text("Panye")))),
    );
  }
}
