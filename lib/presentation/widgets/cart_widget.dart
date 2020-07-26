import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qwickscan/data/models/cart.dart';
import 'package:qwickscan/presentation/screens/cart_screen_history.dart';

import '../../utils/themes.dart';

class CartWidget extends StatelessWidget {
  final Cart cart;

  const CartWidget({Key key, this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var format = DateFormat.yMMMEd();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Material(
        color: Grey,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius12,
        ),
        child: InkWell(
          borderRadius: borderRadius12,
          onTap: () => Navigator.of(context).pushNamed(
            CartScreenHistory.routename,
            arguments: cart,
          ),
          child: Container(
            child: ListTile(
              title: Text(
                '${cart.cartName}',
                style: MediumHeadingText,
              ),
              subtitle: Text(format.format(cart.createdAt)),
              trailing: CircleAvatar(
                backgroundColor: Purple,
                radius: 16,
                foregroundColor: Colors.white,
                child: Icon(Icons.navigate_next),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
