import 'package:flutter/cupertino.dart';

import 'item.dart';

class Model {
  String category;
  List<Item> items;
  String imageUrl;

  Model(this.category, this.items,this.imageUrl);

  factory Model.fromJson(dynamic json) {
    List<dynamic> dynList = json["items"];
    List<Item> itemList = List<Item>();
    dynList.forEach((element) {
      Item item = Item.fromJson(element);
      itemList.add(item);
    });
    return Model(json["category"] as String, itemList,json["imageUrl"] as String);
  }

  String toString(){
    return "{category: $category}";
  }
}
