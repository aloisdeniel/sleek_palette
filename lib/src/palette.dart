import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleek_palette/src/palette_data.dart';

import 'loaders.dart';

class SleekPalette extends StatefulWidget {
  final SleekPaletteData data;
  final Widget child;
  final SleekPaletteLoader loader;
  final String preferenceKey;

  static const defaultPreferenceKey = 'sleek_palette';

  const SleekPalette({
    Key key,
    this.data,
    this.loader,
    this.preferenceKey = defaultPreferenceKey,
    @required this.child,
  })  : assert(preferenceKey != null),
        super(key: key);

  SleekPalette.fromUrl({
    Key key,
    SleekPaletteData data,
    @required String url,
    Map<String, String> headers,
    String preferenceKey = defaultPreferenceKey,
    @required Widget child,
  }) : this(
          key: key,
          data: data,
          child: child,
          preferenceKey: preferenceKey,
          loader: () => paletteUrlLoader(url, headers: headers),
        );

  static SleekPaletteData of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<SleekPaletteProvider>();
    if (provider == null) return SleekPaletteData.fallback();
    return provider.value;
  }

  static _SleekPaletteState _findState(BuildContext context) {
    final state = context.findAncestorStateOfType<_SleekPaletteState>();
    if (state == null)
      throw Exception('No SleekPalette found in the widget tree');
    return state;
  }

  static Future<void> updateFromUrl(
    BuildContext context,
    String url, {
    Map<String, String> headers,
    bool saveToPreferences = true,
  }) {
    return _findState(context).updateFromLoader(
      () => paletteUrlLoader(url, headers: headers),
      saveToPreferences: saveToPreferences,
    );
  }

  static Future<void> updateFromPreferences(BuildContext context) {
    return _findState(context).updateFromPreferences();
  }

  static Future<void> update(
    BuildContext context,
    SleekPaletteData palette, {
    bool saveToPreferences = true,
  }) {
    return _findState(context).update(
      palette,
      saveToPreferences: saveToPreferences,
    );
  }

  @override
  _SleekPaletteState createState() => _SleekPaletteState();
}

class _SleekPaletteState extends State<SleekPalette> {
  SleekPaletteData _data;

  @override
  void initState() {
    if (widget.data != null) {
      _data = widget.data;
    }

    _initAsync();
    super.initState();
  }

  Future<void> _initAsync() async {
    try {
      await updateFromPreferences();
    } catch (e) {
      print('Failed to load palette from preferences');
    }
    if (widget.loader != null) {
      await updateFromLoader(widget.loader);
    }
  }

  Future<void> update(
    SleekPaletteData palette, {
    bool saveToPreferences = true,
  }) async {
    if (saveToPreferences) {
      final json = jsonEncode(palette.toJson());
      final preferences = await SharedPreferences.getInstance();
      await preferences.setString(widget.preferenceKey, json);
    }
    this.setState(() => this._data = palette);
  }

  Future<void> updateFromLoader(
    SleekPaletteLoader load, {
    bool saveToPreferences = true,
  }) async {
    final palette = await load();
    if (palette != null) {
      update(
        palette,
        saveToPreferences: saveToPreferences,
      );
    }
  }

  Future<void> updateFromPreferences() async {
    final preferences = await SharedPreferences.getInstance();
    final json = preferences.getString(widget.preferenceKey);
    if (json != null) {
      final palette = SleekPaletteData.fromJson(jsonDecode(json));
      this.setState(() => this._data = palette);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SleekPaletteProvider(
      value: _data ?? SleekPaletteData.fallback(),
      child: widget.child,
    );
  }
}

class SleekPaletteProvider extends InheritedWidget {
  final SleekPaletteData value;

  SleekPaletteProvider({
    Key key,
    @required this.value,
    @required Widget child,
  })  : assert(value != null),
        super(child: child, key: key);

  @override
  bool updateShouldNotify(SleekPaletteProvider oldWidget) {
    return value != oldWidget.value;
  }
}
