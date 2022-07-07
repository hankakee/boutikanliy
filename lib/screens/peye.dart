import "package:flutter/material.dart";
import 'package:boutikanliy/services/constants.dart';
import 'package:boutikanliy/services/server_config.dart';
import "package:boutikanliy/services/api.dart";
import "package:boutikanliy/services/storage.dart";
import "home.dart";
import 'detailsproducts.dart';

class Peye extends StatefulWidget {
  const Peye({Key? key}) : super(key: key);

  @override
  State<Peye> createState() => _PeyeState();
}

class _PeyeState extends State<Peye> {
  late List<Widget> tabCategory = [];
  late List tabProducts = [];
  late List<int> shoppingCartTab = [];
  late double totalpricart;
  // late List<int> favoritesTab = [];
  List<int> removedCartTab = [];

  bool loaded = false;

  void getProducts() async {
    // var result = await APIService.get(
    //     ServerConfig.apiUrl + "products?offset=0&limit=6", null);

    var result = await Storage.showCart();
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
    double lotprice = 0;
    for (var k = 0; k < result.length; k++) {
      lotprice += (result[k][3] as double);
    }
    setState(
        () => {totalpricart = lotprice, tabProducts = result, loaded = true});
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

  // void getFavorites() async {
  //   var shop = await Storage.showFavs();
  //   List<int> idLists = [];
  //   for (var k = 0; k < shop.length; k++) {
  //     idLists.add(shop[k][0] as int);
  //   }
  //   setState(() => {favoritesTab = idLists});
  // }

  @override
  void initState() {
    // getFavorites();
    getProducts();
    getShoppingCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Peye..."),
        actions: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 10),
            // child: GestureDetector(
            //   onTap: () {
            //     // Storage.removeKey("cart");
            //   },
            //   child: const Text(
            //     "PEYE",
            //     style: TextStyle(
            //         fontSize: 16.0,
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
          )
        ],
        leading: GestureDetector(
            onTap: () {
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
                height: 10000,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(top: 40.0),
                        width: double.infinity,
                        child: Text(
                          "Peye kotni panye'w la : (" +
                              (tabProducts.length - removedCartTab.length)
                                  .toString() +
                              ") pwodui",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 17.0),
                        )),
                    Container(
                        padding: const EdgeInsets.only(top: 4.0),
                        width: double.infinity,
                        child: Text(
                          "Total : " + (totalpricart).toString() + " HTG",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Constants.primaryAppColor,
                              fontSize: 17.0),
                        )),
                    const SizedBox(
                        child: Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                    )),
                    Container(
                      // color: Colors.amber,
                      child: Column(
                          children: tabProducts.map((pr) {
                        return !(removedCartTab.contains(pr[0]))
                            ? Container(
                                margin: const EdgeInsets.only(bottom: 6.0),
                                width: double.infinity,
                                height: 80.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(children: [
                                    Container(
                                      padding: const EdgeInsets.only(top: 6.0),
                                      child: Text(
                                        Constants.formatDescription(pr[1]),
                                        textAlign: TextAlign.left,
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
                                              pr[3].toString() + "HTG",
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
                                            top: -4.0,
                                            child: GestureDetector(
                                              onTap: () {
                                                print("Sote msyeu");
                                                setState(() {
                                                  Storage.removeFromCart(pr);
                                                  removedCartTab
                                                      .add(pr[0] as int);
                                                  totalpricart -= pr[3];
                                                });
                                              },
                                              child: Icon(
                                                  Icons.shopping_cart_rounded,
                                                  size: 30.0,
                                                  color: Constants
                                                      .secondaryAppColor),
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
                    Container(
                      padding: const EdgeInsets.only(bottom: 7.0),
                      child: Column(children: [
                        SizedBox(
                          child: Image.asset("assets/paypall.png"),
                          // width: 120,
                        ),
                        SizedBox(
                          child: Image.asset("assets/moncash.png"),
                          // width: 120,
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
