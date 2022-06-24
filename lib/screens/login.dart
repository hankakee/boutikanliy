import "package:flutter/material.dart";
import "../services/mesaj.dart";
import 'dart:async';
import 'Home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool disableButton = true;
  TextEditingController itilizateController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
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
                          // Itilizatè section
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(
                                top: 5.0, left: 10.0, bottom: 7.0),
                            child: const Text(
                              "Itilizatè",
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
                                  hintText: "Antre non itilizatè ou a...",
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
                              child: TextFormField(
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
                                  hintText: "Antre modpas ou la...",
                                  border: InputBorder.none,
                                ),
                              ),
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
                                    print("clicked");
                                    Map data = {
                                      "username": itilizateController.text,
                                      "password": pwdController.text
                                    };

                                    if (data["username"] == "" ||
                                        data["password"] == "") {
                                      ManagerMesaj().showMesaj2(context,
                                          "Itilizate oswa modpas la pa valid!!!");
                                    } else {
                                      //correct redirect to pages
                                      print("Correct bro");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const Home(
                                                    title: "Eboutikoo",
                                                  )));
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
