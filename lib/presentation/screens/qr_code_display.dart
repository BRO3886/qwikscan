import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qwickscan/utils/themes.dart';

class QRDisplayScreen extends StatelessWidget {
  static const routename = "/qr-display";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Scan QR'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Scan this QR at the counter to checkout',
              style: SmallGreyText,
            ),
            QrImage(
              data: 'siddverma1999@gmail.com',
              version: QrVersions.auto,
              size: 200.0,
            ),
          ],
        ),
      ),
    );
  }
}
