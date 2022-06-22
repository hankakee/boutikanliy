import "package:flutter/material.dart";

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 310.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Image.asset(
                  "eboutik.png",
                  width: 200.0,
                ),
              ],
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
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
                      // imel section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, bottom: 7.0),
                        child: const Text(
                          "Imel",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                            controller: emailController,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Antre imel ou la...",
                              border: InputBorder.none,
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 2, color: const Color(0XFF707070)))),
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
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                  width: 2, color: const Color(0XFF707070)))),
                      GestureDetector(
                        onTap: () {
                          print("Submit api data");
                        },
                        child: Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            width: double.infinity,
                            height: 50.0,
                            child: const Center(
                              child: Text(
                                "Konekte",
                                style: TextStyle(color: Color(0XFFFFFFFF)),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF994CFC),
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      // padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      // child: ElevatedButton(
                      //     onPressed: () {}, child: const Text("Konekte"))),
                    ],
                  ),
                ],
              ),
            ),
          )),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [Image.asset("cmp.png", width: 120.0)],
          ),
        ],
      ),
    ));
  }
}
