import "package:flutter/material.dart";

class CustomizedDrawer {
  // final String picture;
  // const CustomizedDrawer({Key? key, required this.picture});
  CustomizedDrawer();

  Widget buildDrawerOwn(BuildContext context, String pic) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            // color: const Color(0xFF994CFC),
            // padding: const EdgeInsets.only(left: 20.0, top: 50.0),
            child: Center(
              child: Container(
                  margin: const EdgeInsets.only(top: 90.0),
                  width: 150.0,
                  height: 150.0,
                  child: Image.network(pic),
                  decoration: const BoxDecoration(shape: BoxShape.circle)),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("banner.png"), fit: BoxFit.cover),
            ),
            height: 250.0,
            width: double.infinity,
          ),
          ListTile(
              onTap: () {
                // callbackReplay("loose");
              },
              title: const Text(
                "Konekte",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              )),
          ListTile(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const EdScreen()));
                print("Ed klike");
              },
              title: const Text("Lis pwodui",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0))),
          ListTile(
              onTap: () {
                // print("soti hangman tile");
                // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
              title: const Text("Dekonekte",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0))),
        ],
      ),
    );
  }
}
