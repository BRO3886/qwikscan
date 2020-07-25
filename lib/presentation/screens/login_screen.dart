import 'package:flutter/material.dart';

import '../../utils/themes.dart';

class LoginScreen extends StatelessWidget {
  static const routename = "/login";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(),
        preferredSize: Size.fromHeight(40),
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0,
            title: Text('QwickScan'),
            floating: true,
            snap: true,
            titleSpacing: -40,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Text(
                'WE MAKE SHOPPING EASY',
                style: SmallGreyText,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'LOGIN',
                      style: BigHeadingText,
                    ),
                    Container(
                      width: 72,
                      height: 4,
                      decoration: BoxDecoration(
                          color: Purple, borderRadius: borderRadius8),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'EMAIL',
                      style: NormalLightText,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'john@example.com',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'PASSWORD',
                      style: NormalLightText,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: '••••••',
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: borderRadius8,
                      ),
                      child: Text(
                        'FORGOT PASSWORD?',
                        style: SmallGreyText.copyWith(
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 52,
                      child: RaisedButton(
                        color: Yellow,
                        child: Text('LOGIN'),
                        textColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: borderRadius8,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: borderRadius8,
                        ),
                        onPressed: () {},
                        child: RichText(
                          text: TextSpan(
                            style: SmallGreyText,
                            children: [
                              TextSpan(
                                text: 'DONT HAVE AN ACCOUNT? ',
                              ),
                              TextSpan(
                                text: 'SIGN UP',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
