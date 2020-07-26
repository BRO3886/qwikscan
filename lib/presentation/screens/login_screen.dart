import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/blocs/login/login_bloc.dart';
import '../../utils/themes.dart';
import '../widgets/show_up.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  static const routename = "/login";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(),
        preferredSize: Size.fromHeight(40),
      ),
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: LoginScreenBuilder(),
      ),
    );
  }
}

class LoginScreenBuilder extends StatefulWidget {
  @override
  _LoginScreenBuilderState createState() => _LoginScreenBuilderState();
}

class _LoginScreenBuilderState extends State<LoginScreenBuilder> {
  final _formkey = GlobalKey<FormState>();

  LoginBloc _loginBloc;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _loginBloc = BlocProvider.of<LoginBloc>(context);

    return BlocListener(
      cubit: _loginBloc,
      listener: (context, state) {
        if (state is LoginFailed) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => AlertDialog(
              title: Text('Error'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              content: Text(state.msg),
              actions: <Widget>[
                FlatButton(
                  child: Text('UNDERSTOOD'),
                  textColor: Purple,
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              ],
            ),
          );
        } else if (state is LoginSuccess) {
          final snackbar = SnackBar(
            elevation: 0.5,
            content: Text(
              'Logged in successfully',
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
            () => Navigator.of(context)
                .pushReplacementNamed(HomeScreen.routename),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        cubit: _loginBloc,
        builder: (context, state) => buildUI(context, state),
      ),
    );
  }

  Widget buildUI(BuildContext context, LoginState state) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          elevation: 0,
          title: ShowUp(
            child: Text('QwickScan'),
            delay: Duration(milliseconds: 100),
          ),
          floating: true,
          snap: true,
          titleSpacing: -40,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: ShowUp(
              delay: Duration(milliseconds: 150),
              child: Text(
                'WE MAKE SHOPPING EASY',
                style: SmallGreyText,
              ),
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
            child: ShowUp(
              delay: Duration(milliseconds: 200),
              child: Form(
                key: _formkey,
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
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'john@example.com',
                      ),
                      validator: (String value) {
                        if (value == '') {
                          return 'This field is required';
                        }
                        if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(value)) {
                          return 'Please enter correct email';
                        }
                      },
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
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: '••••••',
                      ),
                      validator: (value) {
                        if (value == '') {
                          return 'This field is required';
                        }
                        if (value.length < 6) {
                          return 'Password length must be atleast 6 characters long';
                        }
                      },
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
                    (state is LoginLoading)
                        ? Center(
                            child: LinearProgressIndicator(
                              backgroundColor: Grey,
                            ),
                          )
                        : Container(
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
                              onPressed: () {
                                if (_formkey.currentState.validate()) {
                                  SystemChannels.textInput
                                      .invokeMethod('TextInput.hide');
                                  _loginBloc.add(
                                    LoginIniated(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                                }
                              },
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
          ),
        )
      ],
    );
  }
}
