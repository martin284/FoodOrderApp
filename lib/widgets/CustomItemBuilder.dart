import 'package:flutter/material.dart';

class CustomItemBuilder extends StatelessWidget {
  String name;
  String url;

  CustomItemBuilder(this.name, this.url);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(
          color: Colors.white,
          width: width / 3,
          height: width / 3,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image(
                  image: NetworkImage(url),
                  width: width / 6,
                  height: width / 6,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(name),
              ]),
        ),
        Container(
          width: width / 3,
          height: width / 3,
          child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("2",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.red)),
              )),
        )
      ],
    );
  }
}
