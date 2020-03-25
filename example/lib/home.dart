import 'package:example/palettes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sleek_palette/sleek_palette.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final palette = SleekPalette.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: palette.primary,
        title: Text('SleekPalette'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ExamplePaletteTile(ExamplePalette.sleek()),
            ExamplePaletteTile(ExamplePalette.bulma()),
            ExamplePaletteTile(ExamplePalette.foundation()),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    Example(
                      'primary',
                      palette.primary,
                    ),
                    Example(
                      'secondary',
                      palette.secondary,
                    ),
                    Example(
                      'info',
                      palette.info,
                    ),
                    Example(
                      'warning',
                      palette.warning,
                    ),
                    Example(
                      'danger',
                      palette.danger,
                    ),
                    Example(
                      'success',
                      palette.success,
                    ),
                    Example(
                      'white',
                      palette.white,
                    ),
                    Example(
                      'light',
                      palette.light,
                    ),
                    Example(
                      'grey',
                      palette.dark,
                    ),
                    Example(
                      'dark',
                      palette.dark,
                    ),
                    Example(
                      'black',
                      palette.dark,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Example extends StatelessWidget {
  final Color color;
  final String name;

  const Example(this.name, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: color.variants.light, width: 10),
      ),
      padding: EdgeInsets.all(10),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(color: color.variants.invert, fontSize: 8),
      ),
    );
  }
}

class ExamplePaletteTile extends StatelessWidget {
  final ExamplePalette palette;

  ExamplePaletteTile(this.palette) : super(key: Key(palette.name));

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(palette.name),
      onTap: () {
        if (palette.palette != null) {
          SleekPalette.update(context, palette.palette);
        } else {
          SleekPalette.updateFromUrl(context, palette.url);
        }
      },
    );
  }
}
