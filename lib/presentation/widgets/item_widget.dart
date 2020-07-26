import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/item.dart';
import '../../utils/themes.dart';

class ItemWidget extends StatelessWidget {
  final Item item;

  const ItemWidget({Key key, this.item}) : super(key: key);

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
          onTap: null,
          child: Container(
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Text(
                '${item.itemName}',
                style: MediumHeadingText,
              ),
              leading: ClipRRect(
                borderRadius: borderRadius8,
                child: Image.network(
                  item.itemImageUrl,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('QTY: ${item.itemQuantity} | ₹ ${item.itemPrice}'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'SUBTOTAL: ₹ ${item.itemQuantity * item.itemPrice}',
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  radius: 16,
                  foregroundColor: Colors.white,
                  child: Icon(Icons.delete),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
