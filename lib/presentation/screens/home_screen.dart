import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../utils/themes.dart';
import '../widgets/card_widget.dart';

class HomeScreen extends StatefulWidget {
  static const routename = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _hideButtonController;
  bool _isVisible = true;
  @override
  void initState() {
    super.initState();
    _hideButtonController = ScrollController();
    _hideButtonController.addListener(() {
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
    });
  }

  @override
  void dispose() {
    super.dispose();
    _hideButtonController.dispose();
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
            onPressed: () {},
            label: Row(
              children: <Widget>[
                Text(
                  'Start Shopping',
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
            title: Text('Hi, Rithik'),
            floating: true,
            snap: true,
            titleSpacing: -40,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Previous Orders',
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

// AnimatedList(
//                     initialItemCount: 10,
//                     itemBuilder: (context, index, animation) {
//                       return SlideTransition(
//                         position: animation.drive(
//                           Tween(begin: Offset(0, 10), end: Offset(0, 0)),
//                         ),
//                         child: CartWidget(),
//                       );
//                     },
//                   )
