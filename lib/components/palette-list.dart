import 'package:flutter/material.dart';

List <int> colorPaletteIndices = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];

MaterialColor getMaterialColor(Color color) {
  List strengths = <double> [0.05];
  Map swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1, len = 9; i <= len; i++) {
    strengths.add(0.1 * i);
  }

  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
    1);
  });

  return MaterialColor(color.value, swatch);
}

class PaletteListView extends StatefulWidget {
  final Color customColor;
  PaletteListView({Key key, this.customColor}) : super(key: key);
  @override
  _PaletteListViewState createState() => _PaletteListViewState();
}

class _PaletteListViewState extends State<PaletteListView> {
  List <Widget> getListPalette(Color color)
  {
    List<Widget> list = new List<Widget>();
    MaterialColor matColor = getMaterialColor(color);
    for(var i = 0; i < colorPaletteIndices.length; i++){
      list.add(new Container (
          decoration: new BoxDecoration (
            color: matColor[colorPaletteIndices[i]]
          ),
          child: new ListTile (
              leading: const Icon(Icons.color_lens),
              title: Text('Color ${[colorPaletteIndices[i]]}')
          )
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: getListPalette(widget.customColor),
    );
  }
}
