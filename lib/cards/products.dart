import 'package:flutter/material.dart';
import 'package:boutikanliy/services/constants.dart';

class Products {
  Widget cardProduct(image, title, price, id, actionsprods) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9.0),
      width: double.infinity,
      height: 230.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          GestureDetector(
            onTap: () {
              actionsprods("view", id);
            },
            child: Container(
              width: double.infinity,
              height: 90.0,
              child: Image.network(image, fit: BoxFit.cover),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              Constants.formatTitle(title),
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
                    price.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Constants.primaryAppColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  right: 4.0,
                  top: 4.0,
                  child: GestureDetector(
                    onTap: () {
                      actionsprods("favo", id);
                    },
                    child: const Icon(Icons.favorite,
                        size: 22.0, color: Colors.pinkAccent),
                  ), //Icon
                ),
                Positioned(
                  left: 4.0,
                  top: 4.0,
                  child: GestureDetector(
                    onTap: () {
                      actionsprods("cart", id);
                    },
                    child: const Icon(Icons.shopping_cart_rounded,
                        size: 25.0, color: Colors.grey),
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
  }
}
