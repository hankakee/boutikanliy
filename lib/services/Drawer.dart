import "package:flutter/material.dart";

class CustomizedDrawer extends StatelessWidget {
  const CustomizedDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('hi'),
      leading: IconButton(
        icon: Icon(Icons.accessible),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
    ));
  }
}
