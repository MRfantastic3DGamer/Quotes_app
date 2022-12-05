import 'dart:convert';

import 'package:hive/hive.dart';

class Quote extends HiveObject {
  @HiveField(0)
  late String id;
  @HiveField(1)
  bool favorite = false;
  @HiveField(2)
  late String content;
  @HiveField(3)
  late String author;
  @HiveField(4)
  late List<dynamic> tags;
  @HiveField(5)
  late String authorId;
  @HiveField(6)
  late String authorSlug;
  @HiveField(7)
  late int length;
  @HiveField(8)
  late String dateAdded;
  @HiveField(9)
  late String dateModified;

  Quote.quote() {
    author = "author";
    content = "content";
    authorId = "authorId";
    authorSlug = "authorSlug";
    dateAdded = "dateAdded";
    dateModified = "dateModified";
    id = "id";
    length = 10;
    tags = ["ad", "ad"];
  }

  Quote({
    required this.id,
    required this.content,
    required this.author,
    required this.tags,
    required this.authorId,
    required this.authorSlug,
    required this.dateAdded,
    required this.dateModified,
    required this.length,
  });
  Quote.fromJson(Map<String, dynamic> m) {
    id = m["_id"];
    content = m["content"];
    author = m["author"];
    tags = m["tags"];
    authorId = m["authorId"];
    authorSlug = m["authorSlug"];
    length = m["length"];
    dateAdded = m["dateAdded"];
    dateModified = m["dateModified"];
  }

  String toJSONEncodable() {
    Map<String, dynamic> m = {};

    m["_id"] = id;
    m["content"] = content;
    m["author"] = author;
    m["tags"] = tags;
    m["authorId"] = authorId;
    m["authorSlug"] = authorSlug;
    m["length"] = length;
    m["dateAdded"] = dateAdded;
    m["dateModified"] = dateModified;

    return jsonEncode(m);
  }
}

class QuoteAdapter extends TypeAdapter<Quote> {
  @override
  Quote read(BinaryReader reader) {
    return Quote.fromJson(jsonDecode(reader.readString())
        // id: reader.readString(),
        // author: reader.readString(),
        // authorId: reader.readString(),
        // authorSlug: reader.readString(),
        // content: reader.readString(),
        // dateAdded: reader.readString(),
        // dateModified: reader.readString(),
        // length: reader.readInt(),
        // tags: reader.readList(),
        );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, Quote obj) {
    writer.writeString(obj.toJSONEncodable());
  }
}
