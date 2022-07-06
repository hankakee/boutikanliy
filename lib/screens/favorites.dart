import "package:flutter/material.dart";
import 'package:boutikanliy/services/constants.dart';
import "package:boutikanliy/services/storage.dart";
import "home.dart";
import 'detailsproducts.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  late List<Widget> tabCategory = [];
  late List tabProducts = [];
  late List<int> shoppingCartTab = [];
  late List<int> favoritesTab = [];
  List<int> removedFavTab = [];

  bool loaded = false;

  void getProducts() async {
    // var result = await APIService.get(
    //     ServerConfig.apiUrl + "products?offset=0&limit=6", null);

    var result = await Storage.showFavs();
    print("============show favs====================");
    //       prod['id'],
    //       prod['title'],
    //       prod['images'][1],
    //       prod['price'],
    //       prod['description'],
    //       prod['category']['name']
    print(result);
    print(result.length);
    print("================================");
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

  @override
  void initState() {
    getFavorites();
    getProducts();
    getShoppingCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                height: 2000,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(top: 40.0),
                        width: double.infinity,
                        child: Text(
                          "Pwodui'w pi remen yo (" +
                              (tabProducts.length - removedFavTab.length)
                                  .toString() +
                              ") ",
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
                          children: tabProducts.map((pr) {
                            return !(removedFavTab.contains(pr[0]))
                                ? Container(
                                    margin: const EdgeInsets.only(bottom: 9.0),
                                    width: double.infinity,
                                    height: 230.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Details(
                                                            idprod: pr[0])));
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 90.0,
                                            child: Image.network(pr[2],
                                                fit: BoxFit.cover),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Text(
                                            Constants.formatTitle(pr[1]),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color:
                                                    Constants.primaryAppColor,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(top: 1.0),
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                child: Text(
                                                  pr[3].toString() + "HTG",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Constants
                                                          .primaryAppColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Positioned(
                                                right: 4.0,
                                                top: 4.0,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    print("Sote msyeu");
                                                    setState(() {
                                                      // getFavorites();
                                                      // favoritesTab.removeWhere(
                                                      //     (el) => el == pr[0]);
                                                      Storage.removeFromFavs(
                                                          pr);
                                                      removedFavTab
                                                          .add(pr[0] as int);
                                                    });
                                                  },
                                                  child: const Icon(
                                                      Icons.favorite,
                                                      size: 22.0,
                                                      color: Colors.pinkAccent),
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
                                  )
                                : const Text("");
                          }).toList()),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
