import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

class ColorJsonConverter implements JsonConverter<Color, Object> {
  const ColorJsonConverter();

  @override
  Color fromJson(Object json) {
    if (json is double) {
      return Color(json.toInt());
    }
    if (json is int) {
      return Color(json);
    }

    return json as Color;
  }

  @override
  Object toJson(Color object) {
    return object.value;
  }
}
