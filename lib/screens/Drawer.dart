import "package:flutter/material.dart";

class CustomizedDrawer extends StatelessWidget {
  const CustomizedDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  // TODO load image from profile
                  child: Text("Profile"),
                  // profileUser == "profile"
                  //     ? Image.network(
                  //         profileUser,
                  //         loadingBuilder: (BuildContext context, Widget child,
                  //             ImageChunkEvent? loadingProgress) {
                  //           if (loadingProgress == null) {
                  //             return child;
                  //           }
                  //           return Center(
                  //             child: CircularProgressIndicator(
                  //               value: loadingProgress.expectedTotalBytes !=
                  //                       null
                  //                   ? loadingProgress.cumulativeBytesLoaded /
                  //                       loadingProgress.expectedTotalBytes!
                  //                   : null,
                  //             ),
                  //           );
                  //         },
                  //       )
                  //     : const Text("ImageProfile"),
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
