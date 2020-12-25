import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_custom_color_palette/components/palette-list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Custom Color Palette',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Custom Color Palette'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool lightTheme = true;
  Color currentColor = Colors.indigo;

  void changeColor(Color color) => setState(() => currentColor = color);

  @override
  Widget build(BuildContext context) {

    return Theme(
      data: lightTheme ? ThemeData.light() : ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            child: Text('Flutter Custom Color Palette Example'),
            onDoubleTap: () => setState(() => lightTheme = !lightTheme),
          )
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: RaisedButton(
                    elevation: 3.0,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            titlePadding: const EdgeInsets.all(0.0),
                            contentPadding: const EdgeInsets.all(0.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            content: SingleChildScrollView(
                              child: SlidePicker(
                                pickerColor: currentColor,
                                onColorChanged: changeColor,
                                paletteType: PaletteType.rgb,
                                enableAlpha: false,
                                displayThumbColor: true,
                                showLabel: false,
                                showIndicator: true,
                                indicatorBorderRadius:
                                const BorderRadius.vertical(
                                  top: const Radius.circular(25.0),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text('Tap to change color'),
                    color: currentColor,
                    textColor: useWhiteForeground(currentColor)
                        ? const Color(0xffffffff)
                        : const Color(0xff000000),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 20),
              child: Row(
                children: <Widget>[
                  Text('Color Palette', style: TextStyle(fontSize: 30),)
                ],
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: PaletteListView(customColor: currentColor),
            )
          ],
        ),
      ),
    );
  }
}
