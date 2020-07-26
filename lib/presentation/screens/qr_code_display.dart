import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qwickscan/services/utils/shared_prefs_custom.dart';
import 'package:qwickscan/utils/themes.dart';

class QRDisplayScreen extends StatefulWidget {
  static const routename = "/qr-display";

  final String cartId;

  const QRDisplayScreen(this.cartId);

  @override
  _QRDisplayScreenState createState() => _QRDisplayScreenState();
}

class _QRDisplayScreenState extends State<QRDisplayScreen> {
  bool _loading = true;
  String id = 'sid';

  @override
  void initState() {
    super.initState();

    _getuserId();
  }

  _getuserId() async {
    setState(() {
      _loading = true;
    });
    final sp = SharedPrefs();
    String uid = await sp.getUserID();
    setState(() {
      id = uid;
      _loading = false;
    });
  }

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
            _loading
                ? CircularProgressIndicator()
                : QrImage(
                    data: widget.cartId,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
          ],
        ),
      ),
    );
  }
}
