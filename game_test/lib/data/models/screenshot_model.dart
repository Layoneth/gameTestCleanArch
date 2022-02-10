import 'dart:convert';

import 'package:floor/floor.dart';

@entity
class ScreenshotModel {
    ScreenshotModel({
      required this.id,
      required this.game,
      required this.height,
      required this.imageId,
      required this.url,
      required this.width,
    });

    @primaryKey
    final int id;
    final int game;
    final int height;
    final String imageId;
    final String url;
    final int width;

    factory ScreenshotModel.fromJson(String str) => ScreenshotModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    static List<ScreenshotModel> fromJsonList(List<dynamic> jsonList) {
      List<ScreenshotModel> games = [];
      for (var json in jsonList) {
        games.add(ScreenshotModel.fromMap(json));
      }
      return games;
    }

    factory ScreenshotModel.fromMap(Map<String, dynamic> json) => ScreenshotModel(
        id: json["id"],
        game: json["game"],
        height: json["height"],
        imageId: json["image_id"],
        url: json["url"],
        width: json["width"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "game": game,
        "height": height,
        "image_id": imageId,
        "url": url,
        "width": width,
    };
}
