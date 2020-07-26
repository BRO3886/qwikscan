import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/models/cart.dart';
import '../../services/blocs/cart/cart_bloc.dart';
import '../../services/utils/shared_prefs_custom.dart';
import '../../utils/themes.dart';
import '../widgets/cart_widget.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routename = "/home";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(),
      child: HomeScreenBuilder(),
    );
  }
}

class HomeScreenBuilder extends StatefulWidget {
  @override
  _HomeScreenBuilderState createState() => _HomeScreenBuilderState();
}

class _HomeScreenBuilderState extends State<HomeScreenBuilder> {
  CartBloc _cartBloc;

  ScrollController _hideButtonController;
  bool _isVisible = true;

  String name = "there";

  @override
  void initState() {
    super.initState();
    SharedPrefs().getName().then((value) {
      setState(() {
        name = value;
      });
    });

    _cartBloc = BlocProvider.of<CartBloc>(context);

    _cartBloc.add(FetchAllCarts());

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
    _cartBloc.close();
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
            onPressed: () {
              var format = DateFormat.yMMMEd();
              _cartBloc.add(
                CreateCart(name: 'Cart ${format.format(DateTime.now())}'),
              );
              // SliverAnimatedList.of(context).inser
            },
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
      body: BlocListener<CartBloc, CartState>(
        cubit: _cartBloc,
        listener: (context, state) {
          if (state is CartCreateLoading) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (ctx) => AlertDialog(
                  title: Text('Creating your Cart'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  content: Text('Loading...'),
                ),
              );
            });
          } else if (state is CartCreateSuccess) {
            Navigator.of(context).pop();
            final snackbar = SnackBar(
              elevation: 0.5,
              content: Text(
                'Cart created successfully',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Rubik',
                ),
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Yellow,
            );
            Scaffold.of(context).showSnackBar(snackbar);
            Future.delayed(
              Duration(seconds: 2),
              () {
                _cartBloc.add(FetchAllCarts());
                _cartBloc.close();
                Navigator.of(context).pushNamed(
                  CartScreen.routename,
                  arguments: state.cart,
                );
              },
            );
          }
        },
        child: BlocBuilder<CartBloc, CartState>(
          cubit: _cartBloc,
          builder: (context, state) {
            if (state is CartInitial) {
              _cartBloc.add(FetchAllCarts());
              return buildLoadingWidget();
            } else if (state is CartFetchLoading) {
              return buildLoadingWidget();
            } else if (state is AllCartFetchFailure) {
              return errorWidget(state.message);
            } else if (state is AllCartFetchSucess) {
              return buildSuccessUI(state.carts);
            }
            return buildLoadingWidget();
          },
        ),
      ),
    );
  }

  Widget errorWidget(String message) {
    return CustomScrollView(
      physics: NeverScrollableScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          elevation: 0,
          title: Text('Hi, $name'),
          floating: true,
          snap: true,
          titleSpacing: -40,
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.38,
          ),
        ),
        SliverToBoxAdapter(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLoadingWidget() {
    return CustomScrollView(
      physics: NeverScrollableScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          elevation: 0,
          title: Text('Hi, $name'),
          floating: true,
          snap: true,
          titleSpacing: -40,
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.38,
          ),
        ),
        SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }

  Widget buildSuccessUI(AllCarts carts) {
    final cartlist = carts.carts.reversed.toList();
    return CustomScrollView(
      controller: _hideButtonController,
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          elevation: 0,
          title: Text('Hi, $name'),
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
        (carts.carts.length == 0)
            ? SliverToBoxAdapter(
                child: Center(
                  child: Text('No carts found'),
                ),
              )
            : SliverAnimatedList(
                initialItemCount: cartlist.length,
                itemBuilder: (context, index, animation) {
                  return SlideTransition(
                    position: animation.drive(
                      Tween(begin: Offset(0, 10), end: Offset(0, 0)),
                    ),
                    child: CartWidget(cart: cartlist[index]),
                  );
                },
              )
      ],
    );
  }
}
