import "package:flutter/material.dart";
import "../services/mesaj.dart";

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController itilizateController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 730.0,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 300.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
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
                        children: [
                          // Itilizatè section
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(
                                top: 30.0, left: 10.0, bottom: 7.0),
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
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return '';
                                //     //  Itilizatè la obligatwa
                                //   }
                                //   return null;
                                // },
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
                            onTap: () {
                              print("Submit api data");
                              if (_formKey.currentState!.validate()) {
                                print("est valid");
                                Map data = {
                                  "username": itilizateController.text,
                                  "password": pwdController.text
                                };
                                print(data["username"]);
                                if (data["username"] == " ") {
                                  ManagerMesaj().showMesaj2(context,
                                      "First test Non itilizate ou antre a pa valid!!!");
                                } else {}
                              } else {
                                ManagerMesaj().showMesaj2(context,
                                    "Non itilizate ou antre a pa valid!!!");
                              }
                            },
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
                                  color: const Color(0xFF994CFC),
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
