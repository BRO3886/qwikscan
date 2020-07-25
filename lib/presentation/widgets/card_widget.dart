import 'package:flutter/material.dart';

import '../../utils/themes.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Material(
        color: Grey,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius12,
        ),
        child: InkWell(
          borderRadius: borderRadius12,
          onTap: () {},
          child: Container(
            child: ListTile(
              title: Text(
                'Cart Name',
                style: MediumHeadingText,
              ),
              subtitle: Text('24 JULY 2020'),
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
