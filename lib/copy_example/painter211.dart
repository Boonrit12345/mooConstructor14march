// https://pub.dev/packages/painter2#-example-tab-

import 'package:flutter/material.dart';
import 'package:painter2/painter2.dart';
import 'dart:typed_data';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class PainterPage extends StatefulWidget {
  @override
  _PainterPageState createState() => _PainterPageState();
}

class _PainterPageState extends State<PainterPage> {
  bool _finished;
  PainterController _controller;

  @override
  void initState() {
    super.initState();
    _finished = false;
    _controller = newController();
  }

  // class ย่อยระบุค่าเริ่มต้น
  PainterController newController() {
    PainterController controller = PainterController();
    controller.thickness = 5.0; // ค่าขนาดเริ่มต้น.ปากกา
    controller.backgroundColor = Colors.white; // ค่าสีเริ่มต้น.พื้นหลัง
    controller.drawColor = Colors.red; // ค่าสีเริ่มต้น.ปากกา
    controller.backgroundImage = Image.network(
        'https://cdn.pixabay.com/photo/2020/04/20/18/10/cinema-5069314_960_720.jpg');
    return controller;
  }

  // # BUILD MAIN
  @override
  Widget build(BuildContext context) {
    // # appBar function
    List<Widget> actions;
    if (_finished) {
      actions = <Widget>[
        IconButton(
          icon: Icon(Icons.content_copy),
          tooltip: 'New Painting',
          onPressed: () => setState(() {
            _finished = false;
            _controller = newController();
          }),
        ),
      ];
    } else {
      actions = <Widget>[
        IconButton(
          icon: Icon(Icons.undo),
          tooltip: 'Undo',
          onPressed: () {
            if (_controller.canUndo) _controller.undo();
          },
        ),
        IconButton(
          icon: Icon(Icons.redo),
          tooltip: 'Redo',
          onPressed: () {
            if (_controller.canRedo) _controller.redo();
          },
        ),
        IconButton(
          icon: Icon(Icons.delete),
          tooltip: 'Clear',
          onPressed: () => _controller.clear(),
        ),
        IconButton(
            icon: Icon(Icons.check_box, size: 30.0, color: Colors.yellow),
            onPressed: () async {
              setState(() {
                _finished = true;
              });
              Uint8List bytes = await _controller.exportAsPNGBytes();

              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text('View your image'),
                  ),
                  body: Container(
                    color: Colors.grey,
                    child: Image.memory(bytes),
                  ),
                );
              }));
            }),
      ];
    }

    // START
    return Scaffold(
      appBar: AppBar(
          title: Text(''),
          actions: actions,
          bottom: PreferredSize(
            child: DrawBar(_controller),
            preferredSize: Size(MediaQuery.of(context).size.width, 30.0),
          )),
      body: buildBodyCenter(),
    );
  }

  Center buildBodyCenter() {
    return Center(
        child: AspectRatio(aspectRatio: 3 / 2, child: Painter(_controller)));
  }
}

// ส่วนแสดง tool เขียนภาพ (พู่กัน+ถังสี)
class DrawBar extends StatelessWidget {
  final PainterController _controller;
  DrawBar(this._controller);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
              child: Slider(
            value: _controller.thickness,
            onChanged: (value) => setState(() {
              _controller.thickness = value;
            }),
            min: 1.0,
            max: 20.0,
            activeColor: Colors.white,
            inactiveColor: Colors.grey,
            label: '${_controller.thickness}',
          ));
        })),
        ColorPickerButton(_controller, false),
        // ColorPickerButton(_controller, true),
      ],
    );
  }
}

class ColorPickerButton extends StatefulWidget {
  final PainterController _controller;
  final bool _background;

  ColorPickerButton(this._controller, this._background);

  @override
  _ColorPickerButtonState createState() => new _ColorPickerButtonState();
}

class _ColorPickerButtonState extends State<ColorPickerButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_iconData, color: _color),
      tooltip:
          widget._background ? 'Change background color' : 'Change draw color',
      onPressed: () => _pickColor(),
    );
  }

  void _pickColor() {
    Color pickerColor = _color;
    Navigator.of(context)
        .push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return Scaffold(
                  appBar: AppBar(
                    title: Text('Pick color'),
                  ),
                  body: Container(
                      alignment: Alignment.center,
                      child: ColorPicker(
                        pickerColor: pickerColor,
                        onColorChanged: (Color c) => pickerColor = c,
                      )));
            }))
        .then((_) {
      setState(() {
        _color = pickerColor;
      });
    });
  }

  Color get _color => widget._background
      ? widget._controller.backgroundColor
      : widget._controller.drawColor;

  IconData get _iconData =>
      widget._background ? Icons.format_color_fill : Icons.edit;

  set _color(Color color) {
    if (widget._background) {
      widget._controller.backgroundColor = color;
    } else {
      widget._controller.drawColor = color;
    }
  }
}
