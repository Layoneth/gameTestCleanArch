import 'dart:convert';
import 'package:floor/floor.dart';

@entity
class GameModel {
    GameModel({
      required this.id,
      required this.category,
      required this.cover,
      required this.createdAt,
      required this.firstReleaseDate,
      required this.name,
      required this.slug,
      required this.status,
      required this.summary,
      required this.updatedAt,
      required this.url,
      required this.checksum,
      required this.parentGame,
      required this.rating,
    });

    @primaryKey
    final int id;
    final int? category;
    final int? cover;
    final int? createdAt;
    final int? firstReleaseDate;
    final String name;
    final String? slug;
    final int? status;
    final String? summary;
    final int? updatedAt;
    final String? url;
    final String? checksum;
    final int? parentGame;
    final double? rating;

    factory GameModel.fromJson(String str) => GameModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    static List<GameModel> fromJsonList(List<dynamic> jsonList) {
      List<GameModel> games = [];
      for (var json in jsonList) {
        games.add(GameModel.fromMap(json));
      }
      return games;
    }

    factory GameModel.fromMap(Map<String, dynamic> json) => GameModel(
        id: json["id"],
        category: json["category"],
        cover: json["cover"],
        createdAt: json["created_at"],
        firstReleaseDate: json["first_release_date"],
        name: json["name"],
        slug: json["slug"],
        status: json["status"],
        summary: json["summary"],
        updatedAt: json["updated_at"],
        url: json["url"],
        checksum: json["checksum"],
        parentGame: json["parent_game"],
        rating: json["rating"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "category": category,
        "cover": cover,
        "created_at": createdAt,
        "first_release_date": firstReleaseDate,
        "name": name,
        "slug": slug,
        "status": status,
        "summary": summary,
        "updated_at": updatedAt,
        "url": url,
        "checksum": checksum,
        "parent_game": parentGame,
        "rating": rating,
    };
}
