// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';

List<Item> itemFromJson(String str) => List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

String itemToJson(List<Item> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Item {
  String model;
  int pk;
  Fields fields;

  Item({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    model: json["model"],
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  int user;
  String image;
  String name;
  String artist;
  int amount;
  DateTime dateAdded;
  int rating;
  String description;

  Fields({
    required this.user,
    required this.image,
    required this.name,
    required this.artist,
    required this.amount,
    required this.dateAdded,
    required this.rating,
    required this.description,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    user: json["user"],
    image: json["image"],
    name: json["name"],
    artist: json["artist"],
    amount: json["amount"],
    dateAdded: DateTime.parse(json["date_added"]),
    rating: json["rating"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "image": image,
    "name": name,
    "artist": artist,
    "amount": amount,
    "date_added": "${dateAdded.year.toString().padLeft(4, '0')}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')}",
    "rating": rating,
    "description": description,
  };
}
