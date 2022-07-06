import 'package:flutter/material.dart';
import 'package:boutikanliy/services/constants.dart';
import 'package:boutikanliy/services/server_config.dart';
import "package:boutikanliy/services/api.dart";
import "package:boutikanliy/services/storage.dart";
import "home.dart";
import 'peye.dart';

class Categories extends StatefulWidget {
  final String category;
  final int id;
  const Categories({Key? key, required this.category, required this.id})
      : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late List tabProducts = [];
  late List<int> shoppingCartTab = [];
  late List<int> favoritesTab = [];
  late List tabProductsbycategory = [];

  bool loaded = false;
  @override
  void initState() {
    getProducts();
    getShoppingCart();
    getFavorites();
    super.initState();
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

  void getProducts() async {
    int category = widget.id;
    try {
      var result = await APIService.get(
          ServerConfig.apiUrl +
              "categories/" +
              category.toString() +
              "/products?offset=0&limit=20",
          null);
      setState(() => {tabProductsbycategory = result, loaded = true});
      print("Done with products category");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            // width: 120,
            child: Text(
          "Kategori: " + widget.category,
          style: const TextStyle(color: Colors.white, fontSize: 17),
        )),
        actions: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Peye()));
                  },
                  child: const Text(
                    "PEYE",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )
        ],
        leading: GestureDetector(
            onTap: () {
              // Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Home(title: "Eboutikoo")));
              print("refresh from another");
            },
            child: const Icon(Icons.arrow_circle_left_outlined)),
        backgroundColor: Constants.primaryAppColor,
      ),
      body: SingleChildScrollView(
        child: loaded == false
            ? Center(
                child: Container(
                padding: const EdgeInsets.only(top: 300),
                child: CircularProgressIndicator(
                  color: Constants.primaryAppColor,
                ),
              ))
            : Container(
                height: 5000,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(top: 40.0),
                        width: double.infinity,
                        child: Text(
                          "Pwodui nan kategori: " + widget.category,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 17.0),
                        )),
                    const SizedBox(
                        child: Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                    )),
                    Container(
                      // color: Colors.amber,
                      child: GridView.count(
                          shrinkWrap: true,
                          primary: false,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                          crossAxisCount: 2,
                          children: tabProductsbycategory.map((pr) {
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
                                                color:
                                                    Constants.primaryAppColor,
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
                                                    : favoritesTab
                                                        .add(pr['id']);
                                              });
                                            },
                                            child: Icon(
                                                favoritesTab.contains(pr['id'])
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                size: 22.0,
                                                color: favoritesTab
                                                        .contains(pr['id'])
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
                                                shoppingCartTab
                                                        .contains(pr['id'])
                                                    ? shoppingCartTab
                                                        .removeWhere((el) =>
                                                            el == pr['id'])
                                                    : shoppingCartTab
                                                        .add(pr['id']);
                                              });
                                            },
                                            child: Icon(
                                                shoppingCartTab
                                                        .contains(pr['id'])
                                                    ? Icons
                                                        .shopping_cart_rounded
                                                    : Icons
                                                        .shopping_cart_outlined,
                                                size: 22.0,
                                                color: shoppingCartTab
                                                        .contains(pr['id'])
                                                    ? Constants
                                                        .secondaryAppColor
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
                  ],
                ),
              ),
      ),
    );
  }
}
