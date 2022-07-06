import 'package:flutter/material.dart';
import 'package:boutikanliy/services/constants.dart';
import 'package:boutikanliy/services/server_config.dart';
import "package:boutikanliy/services/api.dart";
import "package:boutikanliy/services/storage.dart";
import "home.dart";
import 'peye.dart';

class Details extends StatefulWidget {
  final int idprod;
  const Details({Key? key, required this.idprod}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late Map tabProducts;
  late List<int> shoppingCartTab = [];
  late List<int> favoritesTab = [];
  bool loaded = false;
  @override
  void initState() {
    getShoppingCart();
    getFavorites();
    getProducts();
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
    try {
      int thisidprod = widget.idprod;
      var result = await APIService.get(
          ServerConfig.apiUrl + "products/" + thisidprod.toString(), null);
      setState(() => {
            loaded = true,
            if (result.isNotEmpty)
              {
                tabProducts = result,
              }
          });
      print("Done with products");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detay"),
        actions: [
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
                height: 1000,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(top: 40.0),
                        width: double.infinity,
                        child: const Text(
                          "Detay Pwodui",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.grey, fontSize: 17.0),
                        )),
                    const SizedBox(
                        child: Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                    )),
                    Container(
                      margin: const EdgeInsets.only(bottom: 9.0),
                      width: double.infinity,
                      height: 290.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          GestureDetector(
                            onTap: () {
                              // actionsprods("view", id);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 160.0,
                              child: Image.network(tabProducts['images'][1],
                                  fit: BoxFit.cover),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              (tabProducts['title']),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Constants.primaryAppColor,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              Constants.formatDescription(
                                  tabProducts['description']),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: Constants.primaryAppColor,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                    tabProducts['price'].toString() + "HTG",
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
                                      Storage.addtoFavorites(tabProducts);
                                      setState(() {
                                        favoritesTab.contains(tabProducts['id'])
                                            ? favoritesTab.removeWhere(
                                                (el) => el == tabProducts['id'])
                                            : favoritesTab
                                                .add(tabProducts['id']);
                                      });
                                    },
                                    child: Icon(
                                        favoritesTab.contains(tabProducts['id'])
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 22.0,
                                        color: favoritesTab
                                                .contains(tabProducts['id'])
                                            ? Colors.pinkAccent
                                            : Colors.grey),
                                  ), //Icon
                                ),
                                // Positioned(
                                //   left: 4.0,
                                //   top: 4.0,
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       Storage.addtoCart(tabProducts);
                                //       setState(() {
                                //         shoppingCartTab
                                //                 .contains(tabProducts['id'])
                                //             ? shoppingCartTab.removeWhere(
                                //                 (el) => el == tabProducts['id'])
                                //             : shoppingCartTab
                                //                 .add(tabProducts['id']);
                                //       });
                                //     },
                                //     child: Icon(
                                //         shoppingCartTab
                                //                 .contains(tabProducts['id'])
                                //             ? Icons.shopping_cart_rounded
                                //             : Icons.shopping_cart_outlined,
                                //         size: 22.0,
                                //         color: shoppingCartTab
                                //                 .contains(tabProducts['id'])
                                //             ? Constants.secondaryAppColor
                                //             : Colors.grey),
                                //   ), //Icon
                                // ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                      decoration: BoxDecoration(
                        color: Constants.cardsColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: shoppingCartTab.contains(widget.idprod)
            ? Constants.secondaryAppColor
            : Colors.grey,
        child: const Icon(
          Icons.shopping_cart_rounded,
        ),
        onPressed: () {
          Storage.addtoCart(tabProducts);
          setState(() {
            shoppingCartTab.contains(widget.idprod)
                ? shoppingCartTab.removeWhere((el) => el == widget.idprod)
                : shoppingCartTab.add(widget.idprod);
          });
        },
      ),
    );
  }
}
