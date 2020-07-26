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
          onTap: () {},
          child: Container(
            child: ListTile(
              title: Text(
                '${item.itemName}',
                style: MediumHeadingText,
              ),
              subtitle: Text(format.format(item.createdAt)),
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
