import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class Storage {
// Create storage
  static const storage = FlutterSecureStorage();

  static void addtoCart(Map prod) async {
    // / Read value
    String? value = await storage.read(key: "cart");
    //freahman cart
    // print("value");
    // print(value);
    if (value == null) {
      List tc = [];
      tc.add(
        [
          prod['id'],
          prod['title'],
          prod['images'][1],
          prod['price'],
          prod['description'],
          prod['category']['name']
        ],
      );
      String encodedTab = jsonEncode(tc);
      await storage.write(key: "cart", value: encodedTab);
    } else {
      print("Contains read all data and merge it");
      //read all data and merge it
      List tmptabCart = [];
      List tabCart = jsonDecode(value);
      List idLists = [];
      for (var k = 0; k < tabCart.length; k++) {
        idLists.add(tabCart[k][0] as int);
      }
      if (idLists.contains(prod['id'])) {
        var ltTab = [];
        for (var i = 0; i < tabCart.length; i++) {
          if (!(tabCart[i][0] == prod['id'])) {
            ltTab.add(tabCart[i]);
          }
        }
        await storage.write(key: "cart", value: jsonEncode(ltTab));
      } else {
        // print('Pa la non zanmi');
        tabCart.add([
          prod['id'],
          prod['title'],
          prod['images'][1],
          prod['price'],
          prod['description'],
          prod['category']['name']
        ]);

        for (var i = 0; i < tabCart.length; i++) {
          tmptabCart.add(tabCart[i]);
        }
        tmptabCart.add(prod);
        await storage.write(key: "cart", value: jsonEncode(tabCart));
      }
      print("Contains card");
      showCart();
    }
  }

  static Future<List<dynamic>> showCart() async {
    String? value = await storage.read(key: "cart");
    print("------------------show cart------------------------------------");
    print("cart");
    print(value);
    List tabCart = [];
    if (value != null) {
      tabCart = jsonDecode(value);
      print("tabCart.length");
      print(tabCart.length);
    }
    return tabCart;
  }

  static Future<List<dynamic>> showFavs() async {
    String? value = await storage.read(key: "favs");
    print("------------------show cart------------------------------------");
    print("favs");
    print(value);
    List tabFavs = [];
    if (value != null) {
      tabFavs = jsonDecode(value);
      print("showFavs.length");
      print(tabFavs.length);
    }
    return tabFavs;
  }

  static void removeKey(cle) async {
    await storage.delete(key: cle);
    await storage.delete(key: "favs");
    print('removed: ' + cle);
  }

  // ---------------------------------------------------favorites----------------------------

  static void addtoFavorites(Map prod) async {
    // / Read value
    String? value = await storage.read(key: "favs");
    //freahman cart
    // print("value");
    // print(value);
    if (value == null) {
      List tc = [];
      tc.add(
        [
          prod['id'],
          prod['title'],
          prod['images'][1],
          prod['price'],
          prod['description'],
          prod['category']['name']
        ],
      );
      String encodedTab = jsonEncode(tc);
      await storage.write(key: "favs", value: encodedTab);
    } else {
      print("Contains read all data and merge it");
      //read all data and merge it
      List tmptabFavs = [];
      List tabFavs = jsonDecode(value);
      List idLists = [];
      for (var k = 0; k < tabFavs.length; k++) {
        idLists.add(tabFavs[k][0] as int);
      }
      if (idLists.contains(prod['id'])) {
        var ltTab = [];
        for (var i = 0; i < tabFavs.length; i++) {
          if (!(tabFavs[i][0] == prod['id'])) {
            ltTab.add(tabFavs[i]);
          }
        }
        await storage.write(key: "favs", value: jsonEncode(ltTab));
      } else {
        // print('Pa la non zanmi');
        tabFavs.add([
          prod['id'],
          prod['title'],
          prod['images'][1],
          prod['price'],
          prod['description'],
          prod['category']['name']
        ]);

        for (var i = 0; i < tabFavs.length; i++) {
          tmptabFavs.add(tabFavs[i]);
        }
        tmptabFavs.add(prod);
        await storage.write(key: "favs", value: jsonEncode(tabFavs));
      }
      print("Contains favs");
      showFavs();
    }
  }
}
