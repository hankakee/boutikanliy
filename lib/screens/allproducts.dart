import 'package:flutter/material.dart';
import 'package:boutikanliy/services/constants.dart';
import 'package:boutikanliy/services/server_config.dart';
import "package:boutikanliy/services/api.dart";

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  late List tabProducts = [];
  bool loaded = false;
  @override
  void initState() {
    getProducts();
    super.initState();
  }

  void getProducts() async {
    try {
      var result = await APIService.get(
          ServerConfig.apiUrl + "products?offset=0&limit=100", null);
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
        backgroundColor: Constants.primaryAppColor,
      ),
      body: SingleChildScrollView(
        child: loaded == false
            ? Center(
                child: Container(
                padding: EdgeInsets.only(top: 300),
                child: CircularProgressIndicator(
                  color: Constants.primaryAppColor,
                ),
              ))
            : Container(
                height: 18000,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
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
                      // color: Colors.amber,
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
                                              // actionsprods("favo", id);
                                            },
                                            child: const Icon(Icons.favorite,
                                                size: 22.0,
                                                color: Colors.pinkAccent),
                                          ), //Icon
                                        ),
                                        Positioned(
                                          left: 4.0,
                                          top: 4.0,
                                          child: GestureDetector(
                                            onTap: () {
                                              // actionsprods("cart", id);
                                              // setState(() {
                                              //   iscart;
                                              // });
                                            },
                                            child: Icon(
                                                Icons.shopping_cart_rounded,
                                                size: 25.0,
                                                color: Colors.grey),
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
                      

                      // tabProducts.map(
                      //           (el) => Products().cardProduct(el["images"][1]),
                      //           Constants.formatTitle(el["title"]),
                      //           el[i]["price"].toString() + "\$",
                      //           el[i]["id"]))