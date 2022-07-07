import 'package:boutikanliy/services/storage.dart';
import "package:flutter/material.dart";
import '../screens/allproducts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../screens/login.dart';
import "package:boutikanliy/services/mesaj.dart";

class CustomizedDrawer {
  final cardsColor = Colors.grey[300];
  final storage = const FlutterSecureStorage();
  Color primaryAppColor = const Color(0XFF994CFC);
  @override
  // void initState() {
  //   readToken();
  //   super.initState();
  // }
  // final storage = const FlutterSecureStorage();

  // String tokenuser = "notoken";
  //   dynamic tu = await storage.read(key: "access_token");
  // void readToken() async {
  //   setState(() => {tokenuser = tu});
  //   // print(tokenuser);
  // }

  // final String picture;
  // const CustomizedDrawer({Key? key, required this.picture});
  CustomizedDrawer();

  Widget buildDrawerOwn(
      BuildContext context, String pic, String nameclient, String mailclient) {
    return Container(
      child: Drawer(
        child: ListView(
          children: [
            Container(
                padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: primaryAppColor,
                  ),
                )),
            Container(
              // color: const Color(0xFF994CFC),
              // padding: const EdgeInsets.only(left: 20.0, top: 50.0),
              child: Center(
                child: Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    width: 200.0,
                    height: 200.0,
                    child: Column(
                      children: [
                        SizedBox(
                            height: 40,
                            child: Image.asset("assets/eboutik.png")),
                        pic == 'profile'
                            ? Icon(Icons.supervised_user_circle_sharp,
                                size: 90.0, color: primaryAppColor)
                            : Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(pic),
                                      fit: BoxFit.cover),
                                ),
                              ),
                        Center(
                          child: Text(
                            nameclient,
                            style: TextStyle(
                                fontSize: 15.0, color: primaryAppColor),
                          ),
                        ),
                        Center(
                          child: Text(
                            mailclient,
                            style: TextStyle(
                                fontSize: 15.0, color: primaryAppColor),
                          ),
                        )
                      ],
                    )),
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/bannerlog.png"),
                    fit: BoxFit.cover),
              ),
              height: 250.0,
              width: double.infinity,
            ),
            ListTile(
                //check if token exist
                onTap: () async {
                  dynamic tu = await storage.read(key: "access_token");
                  Navigator.pop(context);
                  if (tu == null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  } else {
                    ManagerMesaj().showMesaj2(context,
                        "Ou konekte deja ,eseye dekonekte pito!", true, 3);
                  }
                },
                title: Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.lock_open,
                          size: 17,
                        )),
                    const Text(
                      "Konekte",
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ],
                )),
            ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AllProducts()));
                },
                title: Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.list,
                          size: 17,
                        )),
                    const Text(
                      "Lis pwodui",
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ],
                )),
            ListTile(
                onTap: () async {
                  dynamic tu = await storage.read(key: "access_token");
                  // print(tu);
                  if (tu == null) {
                    Navigator.pop(context);
                    ManagerMesaj().showMesaj2(
                        context,
                        "Ou pat janm konekte non,klike sou konekte...",
                        true,
                        3);
                  } else {
                    Storage.removeKey("access_token");
                    Storage.removeKey("avatar");
                    Storage.removeKey("email");
                    Storage.removeKey("name");
                    Storage.removeKey("cart");
                    Storage.removeKey("favs");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                    ManagerMesaj().showMesaj2(context,
                        "Ou fek dekonekte la,na rewè anko...", true, 3);
                  }
                },
                title: Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(right: 10),
                        child: const Icon(
                          Icons.door_back_door,
                          size: 17,
                        )),
                    const Text(
                      "Dekonekte",
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
