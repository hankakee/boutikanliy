import 'package:flutter/material.dart';
import 'package:boutikanliy/services/constants.dart';
import 'package:boutikanliy/services/server_config.dart';
import "package:boutikanliy/services/api.dart";
import 'package:boutikanliy/cards/products.dart';

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
                            return Products().cardProduct(
                                pr['images'][1],
                                Constants.formatTitle(pr['title']),
                                pr['price'].toString() + "\$",
                                pr['id'], (value, id) {
                              print("Le avl: " + value + "" + id.toString());
                            });
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