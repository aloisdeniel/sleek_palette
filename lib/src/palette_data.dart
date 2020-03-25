import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'utilities/color_json_converter.dart';

part 'palette_data.freezed.dart';
part 'palette_data.g.dart';

@freezed
abstract class SleekPaletteData with _$SleekPaletteData {
  const factory SleekPaletteData({
    @required @ColorJsonConverter() Color primary,
    @required @ColorJsonConverter() Color secondary,
    @required @ColorJsonConverter() Color info,
    @required @ColorJsonConverter() Color success,
    @required @ColorJsonConverter() Color danger,
    @required @ColorJsonConverter() Color warning,
    @required @ColorJsonConverter() Color dark,
    @required @ColorJsonConverter() Color light,
    @required @ColorJsonConverter() Color black,
    @required @ColorJsonConverter() Color grey,
    @required @ColorJsonConverter() Color white,
  }) = _SleekPaletteData;

  factory SleekPaletteData.fallback() => const SleekPaletteData(
        primary: Color(0xFF5D3BE8),
        info: Color(0xFF3C39EE),
        secondary: Color(0xFF396BEE),
        danger: Color(0xFFEE394E),
        success: Color(0xFF3AC281),
        warning: Color(0xFFFFC369),
        dark: Color(0xFF323232),
        light: Color(0xFFEFEFEF),
        white: Color(0xFFFCFCFC),
        black: Color(0xFF090909),
        grey: Color(0xFF6A6A6A),
      );

  factory SleekPaletteData.fromJson(Map<String, dynamic> json) =>
      _$SleekPaletteDataFromJson(json);
}
