import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qwickscan/data/models/item.dart';
import 'package:qwickscan/presentation/widgets/item_widget.dart';
import 'package:qwickscan/services/blocs/item/item_bloc.dart';

import '../../data/models/cart.dart';
import '../../utils/themes.dart';
import 'object_detection/item_scanner.dart';
import 'qr_code_display.dart';

class CartScreenHistory extends StatelessWidget {
  static const routename = "/cart-history";
  @override
  Widget build(BuildContext context) {
    final cart = ModalRoute.of(context).settings.arguments as Cart;
    return BlocProvider(
      create: (context) => ItemBloc(),
      child: CartScreenHistoryBuilder(
        cart: cart,
      ),
    );
  }
}

class CartScreenHistoryBuilder extends StatefulWidget {
  final Cart cart;

  const CartScreenHistoryBuilder({Key key, this.cart}) : super(key: key);
  @override
  _CartScreenHistoryBuilderState createState() =>
      _CartScreenHistoryBuilderState();
}

class _CartScreenHistoryBuilderState extends State<CartScreenHistoryBuilder> {
  ScrollController _hideButtonController;
  ItemBloc _itemBloc;
  TextEditingController _titleController;

  bool _isVisible = true;

  @override
  void initState() {
    super.initState();

    _itemBloc = BlocProvider.of<ItemBloc>(context);

    _titleController = TextEditingController(text: widget.cart.cartName);

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
    _itemBloc.close();
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
        builder: (context) => ItemScanScreen(
          cameras: cameras,
          cartId: widget.cart.cartId,
        ),
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
      body: BlocListener<ItemBloc, ItemState>(
        cubit: _itemBloc,
        listener: (context, state) {},
        child: BlocBuilder<ItemBloc, ItemState>(
          cubit: _itemBloc,
          builder: (context, state) {
            if (state is ItemInitial) {
              _itemBloc.add(GetCartItems(
                cartId: widget.cart.cartId,
              ));
            } else if (state is FetchItemsFailure) {
              return errorWidget(state.message);
            } else if (state is ItemLoading) {
              return buildLoadingWidget();
            } else if (state is FetchItemsSuccess) {
              return buildSuccessUI(context, state.items);
            }
            print(state.toString());
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

  CustomScrollView buildSuccessUI(BuildContext context, Items items) {
    final itemList = items.items.reversed.toList();
    return CustomScrollView(
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
              enabled: false,
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
                  'TOTAL: ₹${items.totalPrice}',
                  style: MediumHeadingText,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        (itemList.length == 0)
            ? SliverToBoxAdapter(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.38,
                  alignment: Alignment.center,
                  child: Text(
                    'Tap + to start adding items',
                    style: SmallGreyText,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : SliverAnimatedList(
                initialItemCount: itemList.length,
                itemBuilder: (context, index, animation) {
                  return SlideTransition(
                    position: animation.drive(
                      Tween(begin: Offset(0, 10), end: Offset(0, 0)),
                    ),
                    child: ItemWidget(
                      item: itemList[index],
                    ),
                  );
                },
              )
      ],
    );
  }
}
