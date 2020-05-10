import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class Signture extends StatefulWidget {
  @override
  _SigntureState createState() => _SigntureState();
}

class _SigntureState extends State<Signture> {
  // Explicit
  ui.Image image;
  bool isImageLoaded = false;
  bool status = true;
  GlobalKey canvasKey = GlobalKey();

  // Method

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<Null> init() async {
    final ByteData byteData = await rootBundle.load('images/cityhorizon.jpg');
    image = await loadImage(Uint8List.view(byteData.buffer));
  }

  Future<ui.Image> loadImage(List<int> list) async {
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(list, (result) {
      setState(() {
        status = false;
        isImageLoaded = true;
      });
      return completer.complete(result);
    });
    return completer.future;
  }

  //   takeScreenShot() async{
  //   RenderRepaintBoundary boundary = canvasKey.currentContext.findRenderObject();
  //   ui.Image image = await boundary.toImage();
  //   final directory = (await getApplicationDocumentsDirectory()).path;
  //   ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //   Uint8List pngBytes = byteData.buffer.asUint8List();
  //   print(pngBytes);
  //   File imgFile =new File('$directory/screenshot.png');
  //   imgFile.writeAsBytes(pngBytes);
  // }

  // takescrshot() async {
  // RenderRepaintBoundary boundary = canvasKey.currentContext.findRenderObject();
  // var image = await boundary.toImage();
  // var byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  // var pngBytes = byteData.buffer.asUint8List();
  // print('pngBytes===================>>>>>$pngBytes');
  // }

  void _saveToImage() async {
    print('in _saveToImage');
    RenderRepaintBoundary boundary =
        canvasKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 5.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    print('pngBytes============>>>>>>>$pngBytes');
    _showImage(pngBytes);
  }

  void _showImage(Uint8List imageBytes) {
    showDialog(
        context: canvasKey.currentContext,
        barrierDismissible: true,
        builder: (BuildContext context2) => new Center(
              child: new Container(
                  decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.green, width: 5.0),
                    color: Colors.blue,
                  ),
                  child: new Image(
                    image: new MemoryImage(imageBytes),
                    fit: BoxFit.contain,
                  )),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('draw over image and save..!'),
      // ),
      // body: image == null ? showProcess() : showImage(),

      body: SafeArea(
        child: Stack(
          children: <Widget>[
            showImage(),
            showButton(),
          ],
        ),
      ),
    );
  }

  Widget showButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 8.0, 50.0, 20.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: OutlineButton(
                  borderSide: BorderSide(color: Colors.white),
                  onPressed: () {
                    print('Clear');
                    setState(() {});
                  },
                  child: Text(
                    'Clear',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: OutlineButton(
                  borderSide: BorderSide(color: Colors.white),
                  onPressed: () {
                    print('Save');
                    saveProcess();
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> saveProcess() async {
    var object = await this.recordProcess;
    print('object === ${object.toString()}');
    // return AlertDialog(
    //   content: Image.memory(object),
    // );
  }


  // # get
  Future<ui.Image> get recordProcess async {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    var size = context.size;
    // painter.paint(canvas, size);
    print('done');
    return recorder
        .endRecording()
        // .toImage(size.width.floor(), size.height.floor());
        .toImage(300, 300);
  }

  showImageNow() async {
    print('saveProcess==================>>>>>>>>>>>>>>>>>>>>>>$saveProcess');
  }

  Center showProcess() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget showImage() {
    ImageEditor imageEditor = ImageEditor(image: image);
    if (this.isImageLoaded) {
      return GestureDetector(
        onPanDown: (details) {
          print('This is PanDown');
          imageEditor.update(details.localPosition);
          canvasKey.currentContext.findRenderObject().markNeedsPaint();
        },
        onPanUpdate: (details) {
          print('This is PanUpdate');
          imageEditor.update(details.localPosition);
          canvasKey.currentContext.findRenderObject().markNeedsPaint();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: CustomPaint(
            key: canvasKey,
            painter: imageEditor,
          ),
        ),
      );
    } else {
      return showProcess();
    }
    // return Center(
    //   child: Text('Have Picture'),
    // );
  }
}

class ImageEditor extends CustomPainter {
  ui.Image image;

  ImageEditor({this.image});

  List<Offset> points = List();

  final Paint painter = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.fill;

  void clear() {
    points.clear();
  }

  void update(Offset offset) {
    points.add(offset);
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(image, Offset(0.0, 0.0), Paint());
    for (var offset in points) {
      canvas.drawCircle(offset, 5, painter);
    }
  }

  @override
  bool shouldRepaint(CustomPainter customPainter) {
    return true;
    // throw UnimplementedError();
  }
}

class SignaturePainter extends CustomPainter {
  // [SignaturePainter] receives points through constructor
  // @points holds the drawn path in the form (x,y) offset;
  // This class responsible for drawing only
  // It won't receive any drag/touch events by draw/user.
  List<Offset> points = <Offset>[];

  SignaturePainter({this.points});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
