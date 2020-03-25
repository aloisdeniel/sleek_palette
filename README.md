<img src="https://github.com/aloisdeniel/sleek_palette/raw/master/sleek_palette_logo.png" width="100%">

<p>
  <a href="https://pub.dartlang.org/packages/sleek_palette"><img src="https://img.shields.io/pub/v/sleek_palette.svg"></a>
  <a href="https://www.buymeacoffee.com/aloisdeniel">
    <img src="https://img.shields.io/badge/$-donate-ff69b4.svg?maxAge=2592000&amp;style=flat">
  </a>
</p>

An opiniated color palette.

<img height="214" src="https://github.com/aloisdeniel/sleek_palette/raw/master/images/examples.png">

## Install

Add the dependency to your `pubspec.yaml` :

```yaml
dependencies:
    sleek_palette: <version>
```

## Quick start

```dart
SleekPalette(
    child: Builder((context) {
            final palette = SleekPalette.of(context);
            return Container(
                color: palette.danger
                child: Text(
                    'Warning', 
                    style: TextStyle(
                        color: palette.danger.variants.invert,
                    ),
                ),
            )
        },
    ),
)
```

## Usage

### Defining a palette

#### Constant

```dart
SleekPalette(
    data: const SleekPaletteData(
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
    ),
    child: <your app>,
)
```

#### Distant

The theme can be loaded asynchronously from a json file. The loaded palette is then stored in shared preferences and loaded automatically when the app is started.

```dart
SleekPalette.fromUrl(
    url: SleekPaletteData.fromUrl('https://company.com/theme.json')
    data: SleekPaletteData.fallback(), // Used while loading
    child: <your app>,
)
```

### Reading a palette

To read a color value from the palette use `SleekPalette.of`.

```dart
final palette = SleekPalette.of(context);
return Text(
    'Stay home!', 
    style: TextStyle(
        color: palette.danger,
    ),
);
```

The [derived_color](https://github.com/aloisdeniel/derived_colors) package is also automatically imported to access color variants through extensions.

```dart
final palette = SleekPalette.of(context);
return Container(
    color:  palette.danger,
    child: Text(
        'Stay home!', 
        style: TextStyle(
            color: palette.danger.variants.invert,
        ),
    ),
);
```

### Updating palette

You can update the current palette at any time. By default, the new palette is saved to preferences and automatically loaded on app launch.

```dart
SleekPalette.update(context, 
    SleekPaletteData(
        //...
    ),
);
```

You can also update the palette from a distant one.

```dart
await SleekPalette.updateFromUrl(context, 'https://company.com/theme.json');
```

## Thanks

Thanks to the [bulma](https://bulma.io) framework team for the inspiration.
