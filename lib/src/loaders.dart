import 'dart:convert';

import 'package:sleek_palette/src/palette_data.dart';
import 'package:http/http.dart' as http;

typedef Future<SleekPaletteData> SleekPaletteLoader();

Future<SleekPaletteData> paletteUrlLoader(String url,
    {Map<String, String> headers}) async {
  final data = await http.get(url, headers: headers);
  if (data.body != null) {
    return SleekPaletteData.fromJson(jsonDecode(data.body));
  }
  throw Exception('Palette url loading failed (${data.statusCode})');
}
