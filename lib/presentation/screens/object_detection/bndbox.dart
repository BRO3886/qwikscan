import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qwickscan/presentation/screens/object_detection/items_detected.dart';

import '../../../services/blocs/item/item_bloc.dart';
import '../../../utils/constants.dart';

class BoundBox extends StatelessWidget {
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  final String model;
  final String cartId;
  BoundBox(
    this.results,
    this.previewH,
    this.previewW,
    this.screenH,
    this.screenW,
    this.model,
    this.cartId,
  );
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemBloc(),
      child: BoundBox(
        results,
        previewH,
        previewW,
        screenH,
        screenW,
        model,
        cartId,
      ),
    );
  }
}

class BoundBoxBuilder extends StatefulWidget {
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  final String model;
  final String cartId;

  BoundBoxBuilder(
    this.results,
    this.previewH,
    this.previewW,
    this.screenH,
    this.screenW,
    this.model,
    this.cartId,
  );

  @override
  _BoundBoxBuilderState createState() => _BoundBoxBuilderState();
}

class _BoundBoxBuilderState extends State<BoundBoxBuilder> {
  ItemBloc _itemBloc;

  @override
  void initState() {
    _itemBloc = BlocProvider.of<ItemBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderBoxes() {
      return widget.results.map((re) {
        var _x = re["rect"]["x"];
        var _w = re["rect"]["w"];
        var _y = re["rect"]["y"];
        var _h = re["rect"]["h"];
        var scaleW, scaleH, x, y, w, h;

        if (widget.screenH / widget.screenW >
            widget.previewH / widget.previewW) {
          scaleW = widget.screenH / widget.previewH * widget.previewW;
          scaleH = widget.screenH;
          var difW = (scaleW - widget.screenW) / scaleW;
          x = (_x - difW / 2) * scaleW;
          w = _w * scaleW;
          if (_x < difW / 2) w -= (difW / 2 - _x) * scaleW;
          y = _y * scaleH;
          h = _h * scaleH;
        } else {
          scaleH = widget.screenW / widget.previewW * widget.previewH;
          scaleW = widget.screenW;
          var difH = (scaleH - widget.screenH) / scaleH;
          x = _x * scaleW;
          w = _w * scaleW;
          y = (_y - difH / 2) * scaleH;
          h = _h * scaleH;
          if (_y < difH / 2) h -= (difH / 2 - _y) * scaleH;
        }

        return Positioned(
          left: math.max(0, x),
          top: math.max(0, y),
          width: w,
          height: h,
          child: CupertinoContextMenu(
            actions: <Widget>[
              CupertinoContextMenuAction(
                isDefaultAction: true,
                child: Text('Quick Add'),
                trailingIcon: Icons.add,
                onPressed: () {
                  final data = {
                    "item_name": "${re["detectedClass"]}",
                    "item_price": 100,
                    "cart_id": widget.cartId,
                    "item_quantity": 1,
                    "item_image_url": items_detected[
                            "${re["detectedClass"]}"] ??
                        "https://pbs.twimg.com/profile_images/1187814172307800064/MhnwJbxw_400x400.jpg"
                  };
                  _itemBloc.add(AddItem(data: data));
                  Navigator.pop(context);
                },
              ),
              CupertinoContextMenuAction(
                trailingIcon: Icons.library_add,
                child: Text('Select items to add'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoContextMenuAction(
                isDestructiveAction: true,
                child: Text('Cancel'),
                trailingIcon: Icons.cancel,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
            child: Container(
              padding: EdgeInsets.only(top: 5.0, left: 5.0),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  // border: Border.all(
                  //   color: Colors.grey,
                  //   width: 3.0,
                  // ),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(),
                  child: Text(
                    "${re["detectedClass"]} (${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%)",
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList();
    }

    List<Widget> _renderStrings() {
      double offset = -10;
      return widget.results.map((re) {
        offset = offset + 14;
        return Positioned(
          left: 10,
          top: offset,
          width: widget.screenW,
          height: widget.screenH,
          child: Text(
            "${re["label"]} ${(re["confidence"] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              color: Color.fromRGBO(37, 213, 253, 1.0),
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList();
    }

    List<Widget> _renderKeypoints() {
      var lists = <Widget>[];
      widget.results.forEach((re) {
        var list = re["keypoints"].values.map<Widget>((k) {
          var _x = k["x"];
          var _y = k["y"];
          var scaleW, scaleH, x, y;

          if (widget.screenH / widget.screenW >
              widget.previewH / widget.previewW) {
            scaleW = widget.screenH / widget.previewH * widget.previewW;
            scaleH = widget.screenH;
            var difW = (scaleW - widget.screenW) / scaleW;
            x = (_x - difW / 2) * scaleW;
            y = _y * scaleH;
          } else {
            scaleH = widget.screenW / widget.previewW * widget.previewH;
            scaleW = widget.screenW;
            var difH = (scaleH - widget.screenH) / scaleH;
            x = _x * scaleW;
            y = (_y - difH / 2) * scaleH;
          }
          return Positioned(
            left: x - 6,
            top: y - 6,
            width: 100,
            height: 12,
            child: Container(
              child: Text(
                "● ${k["part"]}",
                style: TextStyle(
                  color: Color.fromRGBO(37, 213, 253, 1.0),
                  fontSize: 12.0,
                ),
              ),
            ),
          );
        }).toList();

        lists..addAll(list);
      });

      return lists;
    }

    return Stack(
      children: widget.model == mobilenet
          ? _renderStrings()
          : widget.model == posenet ? _renderKeypoints() : _renderBoxes(),
    );
  }
}
