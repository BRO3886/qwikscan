import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qwickscan/presentation/screens/object_detection/item_scanner.dart';
import 'package:qwickscan/presentation/screens/qr_code_display.dart';

import '../../utils/themes.dart';
import '../widgets/card_widget.dart';

class CartScreen extends StatefulWidget {
  static const routename = "/cart";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ScrollController _hideButtonController;

  TextEditingController _titleController =
      TextEditingController(text: 'Cart 24 July 2020');

  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _hideButtonController = ScrollController();

    _hideButtonController.addListener(
      () {
        if (_hideButtonController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (_isVisible == true) {
            // print("$_isVisible up");
            setState(() {
              _isVisible = false;
            });
          }
        } else {
          if (_hideButtonController.position.userScrollDirection ==
              ScrollDirection.forward) {
            if (_isVisible == false) {
              // print("$_isVisible down");
              setState(() {
                _isVisible = true;
              });
            }
          }
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _hideButtonController.dispose();
  }

  _openCameraScreen() async {
    List<CameraDescription> cameras;
    try {
      cameras = await availableCameras();
    } on CameraException catch (e) {
      print('Error: $e.code\nError Message: $e.message');
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => ItemScanScreen(cameras: cameras),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: borderRadius12.add(
            BorderRadius.circular(20),
          ),
          boxShadow: _isVisible
              ? [
                  BoxShadow(
                    blurRadius: 32,
                    offset: Offset(0, 5),
                    color: Color.fromRGBO(149, 149, 149, 0.63),
                  ),
                ]
              : null,
        ),
        duration: Duration(milliseconds: 200),
        height: _isVisible ? 50 : 0,
        width: _isVisible ? 160 : 0,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: _isVisible ? 1 : 0,
          child: FloatingActionButton.extended(
            isExtended: true,
            hoverColor: Colors.black87,
            elevation: 0,
            splashColor: Color(0xFFD1932D),
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: _openCameraScreen,
            label: Row(
              children: <Widget>[
                Text(
                  'Add Items',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: PreferredSize(
        child: Container(),
        preferredSize: Size.fromHeight(40),
      ),
      body: CustomScrollView(
        controller: _hideButtonController,
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0,
            leading: IconButton(
              icon: CircleAvatar(
                backgroundColor: Yellow,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              onPressed: () => Navigator.maybePop(context),
            ),
            actions: <Widget>[
              IconButton(
                icon: CircleAvatar(
                  backgroundColor: Purple,
                  child: Icon(
                    Icons.border_all,
                    color: Colors.white,
                  ),
                ),
                onPressed: () =>
                    Navigator.of(context).pushNamed(QRDisplayScreen.routename),
              ),
            ],
            floating: true,
            snap: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                maxLines: 2,
                minLines: 1,
                expands: false,
                controller: _titleController,
                style: PurpleHeadingText.copyWith(fontSize: 20),
                decoration: InputDecoration(
                  filled: false,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'TOTAL: \$500',
                    style: MediumHeadingText,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          SliverAnimatedList(
            initialItemCount: 10,
            itemBuilder: (context, index, animation) {
              return SlideTransition(
                position: animation.drive(
                  Tween(begin: Offset(0, 10), end: Offset(0, 0)),
                ),
                child: CartWidget(),
              );
            },
          )
        ],
      ),
    );
  }
}
