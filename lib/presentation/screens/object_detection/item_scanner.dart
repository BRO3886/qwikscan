import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:qwickscan/services/blocs/item/item_bloc.dart';
import 'package:tflite/tflite.dart';

import '../../../utils/constants.dart';
import '../../../utils/themes.dart';
import 'bndbox.dart';
import 'camera.dart';

class ItemScanScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String cartId;

  ItemScanScreen({@required this.cameras, @required this.cartId});

  @override
  _ItemScanScreenState createState() => _ItemScanScreenState();
}

class _ItemScanScreenState extends State<ItemScanScreen> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = yolo;
  bool _modelLoading = true;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  loadModel() async {
    setState(() {
      _modelLoading = true;
    });
    String res;
    switch (_model) {
      case yolo:
        res = await Tflite.loadModel(
          model: "assets/tflite/yolov2_tiny.tflite",
          labels: "assets/tflite/yolov2_tiny.txt",
        );
        break;
    }
    print(res);
    setState(() {
      _modelLoading = false;
    });
  }

  // onSelect(model) {
  //   setState(() {
  //     _model = model;
  //   });
  //   loadModel();
  // }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  void dispose() {
    _recognitions.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: _modelLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Camera(
                  widget.cameras,
                  _model,
                  setRecognitions,
                ),
                BoundBox(
                  _recognitions == null ? [] : _recognitions,
                  math.max(_imageHeight, _imageWidth),
                  math.min(_imageHeight, _imageWidth),
                  screen.height,
                  screen.width,
                  _model,
                  widget.cartId,
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: 16,
                  child: IconButton(
                    icon: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    // color: Colors.red,
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ),
              ],
            ),
    );
  }
}
