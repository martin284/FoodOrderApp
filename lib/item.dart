class Item {
  String name;
  String imageUrl;

  Item(this.name, this.imageUrl);

  factory Item.fromJson(dynamic json) {
    return Item(json["name"] as String, json["url"] as String);
  }
}
