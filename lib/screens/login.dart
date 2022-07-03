import "package:flutter/material.dart";
import "package:boutikanliy/services/mesaj.dart";
import "package:boutikanliy/services/api.dart";
import 'dart:async';
import 'Home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:boutikanliy/services/server_config.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();

  void initState() {}
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool disableButton = true;

  TextEditingController itilizateController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  final storage = const FlutterSecureStorage();

  // check login
  void auth(dynamic data, context) async {
    print(ServerConfig.apiUrl);
    var response =
        await APIService.post(ServerConfig.apiUrl + 'auth/login', body: data);
    print(response);
    if (response != null && response['access_token'] != null) {
      await storage.write(key: "access_token", value: response['access_token']);
      //get profile user //
      dynamic valuetoken = await storage.read(key: "access_token");
      //find profile
      // print("valuetoken: " + valuetoken.toString());/
      if (valuetoken == null) {
        ManagerMesaj()
            .showMesaj2(context, "Tanpri eseye konekte talè...", true);
      }
      var resp2 = await APIService.get(
          ServerConfig.apiUrl + "auth/profile", valuetoken);
      print("resp2");
      print(resp2['id']);
      // print(resp2);
      await storage.write(key: "id", value: resp2["id"].toString());
      await storage.write(key: "email", value: resp2["email"].toString());
      await storage.write(key: "name", value: resp2["name"].toString());
      await storage.write(key: "avatar", value: resp2["avatar"].toString());
      if (resp2 != null) {
        ManagerMesaj().showMesaj2(
            context,
            "Byenvini " +
                resp2["name"].toString() +
                " men sa'n pote pou ou jodi a!",
            true);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const Home(
                      title: "Eboutikoo",
                    )));
      }
    } else {
      ManagerMesaj().showMesaj2(context, "Kont sa pa valid...", true);
    }
  }

  String findProfile() {
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 700.0,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 250.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Image.asset(
                        "eboutik.png",
                        width: 250.0,
                      ),
                    )
                  ],
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                  image: DecorationImage(
                      image: AssetImage("bannerlog.png"), fit: BoxFit.cover),
                ),
              ),
              Container(
                  child: Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              padding:
                                  const EdgeInsets.only(top: 5.0, bottom: 5.0),
                              child: Column(
                                children: const [
                                  Text(
                                    " - BYENVINI ANKO - ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  Text(
                                    "Nou pral dekouvri pwodui'w remen yo",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 10.0),
                                  )
                                ],
                              )),
                          // Imèl section
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(
                                top: 5.0, left: 10.0, bottom: 7.0),
                            child: const Text(
                              "Imèl",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                              ),
                            ),
                          ),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              // height: 55.0,
                              child: TextFormField(
                                controller: itilizateController,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
                                  hintText: "Antre imèl ou a...",
                                  icon: Icon(Icons.email,
                                      color: Color(0xFF994CFC)),
                                  border: InputBorder.none,
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 2,
                                      color: const Color(0XFF707070)))),
                          // modpas section
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(
                                left: 10.0, bottom: 7.0, top: 25.0),
                            child: const Text(
                              "Modpas",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(children: [
                                TextFormField(
                                  //pwds/
                                  obscureText: true,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  // /pwds
                                  controller: pwdController,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.lock,
                                        color: const Color(0xFF994CFC)),
                                    hintText: "Antre modpas ou la...",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ]),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 2,
                                      color: const Color(0XFF707070)))),
                          GestureDetector(
                            onTap: disableButton
                                ? () {
                                    setState(() {
                                      disableButton = false;
                                    });
                                    Timer(const Duration(seconds: 2), () {
                                      setState(() => disableButton = true);
                                    });
                                    // print("clicked");
                                    Map dataLogin = {
                                      "email": itilizateController.text.trim(),
                                      "password": pwdController.text.trim()
                                    };

                                    if (dataLogin["username"] == "" ||
                                        dataLogin["password"] == "") {
                                      ManagerMesaj().showMesaj2(
                                          context,
                                          "Itilizate oswa modpas la pa valid!!!",
                                          false);
                                    } else {
                                      // check login
                                      print("klike bouton sa...");
                                      auth(dataLogin, context);
                                    }
                                  }
                                : null,
                            child: Container(
                                margin: const EdgeInsets.only(top: 25.0),
                                width: double.infinity,
                                height: 50.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Konekte",
                                      style: TextStyle(
                                          color: Color(0XFFFFFFFF),
                                          fontSize: 18.0),
                                    ),
                                    Icon(Icons.lock, color: Colors.white),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: disableButton
                                      ? const Color(0xFF994CFC)
                                      : const Color.fromARGB(
                                          255, 100, 100, 100),
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
