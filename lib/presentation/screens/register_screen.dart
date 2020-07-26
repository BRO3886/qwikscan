import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qwickscan/presentation/screens/login_screen.dart';

import '../../services/blocs/register/register_bloc.dart';
import '../../utils/themes.dart';
import '../widgets/show_up.dart';
import 'home_screen.dart';

class RegisterScreen extends StatelessWidget {
  static const routename = "/register";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(),
        preferredSize: Size.fromHeight(40),
      ),
      body: BlocProvider(
        create: (context) => RegisterBloc(),
        child: RegisterScreenBuilder(),
      ),
    );
  }
}

class RegisterScreenBuilder extends StatefulWidget {
  @override
  _RegisterScreenBuilderState createState() => _RegisterScreenBuilderState();
}

class _RegisterScreenBuilderState extends State<RegisterScreenBuilder> {
  final _formkey = GlobalKey<FormState>();

  RegisterBloc _registerBloc;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _registerBloc.close();
    super.dispose();
  }

  Map<String, String> userData = {
    "name": "",
    "email": "",
    "password": "",
    "image_url":
        "https://avatars0.githubusercontent.com/u/12408595?s=460&u=fde60061cf6167c0c911af11175ecd0a0fe903c2&v=4",
    "phone_number": ""
  };

  @override
  Widget build(BuildContext context) {
    _registerBloc = BlocProvider.of<RegisterBloc>(context);

    return BlocListener(
      cubit: _registerBloc,
      listener: (context, state) {
        if (state is RegisterFailed) {
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
        } else if (state is RegisterSuccess) {
          final snackbar = SnackBar(
            elevation: 0.5,
            content: Text(
              'Registration Successful',
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
      child: BlocBuilder<RegisterBloc, RegisterState>(
        cubit: _registerBloc,
        builder: (context, state) => buildUI(context, state),
      ),
    );
  }

  Widget buildUI(BuildContext context, RegisterState state) {
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
            height: MediaQuery.of(context).size.height * 0.05,
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
                      'REGISTER',
                      style: BigHeadingText,
                    ),
                    Container(
                      width: 80,
                      height: 4,
                      decoration: BoxDecoration(
                          color: Purple, borderRadius: borderRadius8),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'NAME',
                      style: NormalLightText,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      autocorrect: true,
                      keyboardType: TextInputType.text,
                      controller: _nameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Jon Doe',
                      ),
                      validator: (String value) {
                        if (value == '') {
                          return 'This field is required';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
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
                        prefixIcon: Icon(Icons.alternate_email),
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
                      'PHONE',
                      style: NormalLightText,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        hintText: '8860986398',
                      ),
                      validator: (String value) {
                        value.trim();
                        if (value == '') {
                          return 'This field is required';
                        }
                        if (value.length > 10) {
                          return 'Enter 10 digit phone number';
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
                    (state is RegisterLoading)
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
                              child: Text('REGISTER'),
                              textColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: borderRadius8,
                              ),
                              onPressed: () {
                                if (_formkey.currentState.validate()) {
                                  SystemChannels.textInput
                                      .invokeMethod('TextInput.hide');

                                  userData["name"] = _nameController.text;
                                  userData["password"] =
                                      _passwordController.text;
                                  userData["email"] = _emailController.text;
                                  userData["phone_number"] =
                                      _phoneController.text;
                                  _registerBloc.add(
                                    RegisterInitated(userData: userData),
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
                        onPressed: () => Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routename),
                        child: RichText(
                          text: TextSpan(
                            style: SmallGreyText,
                            children: [
                              TextSpan(
                                text: 'ALREADY HAVE AN ACCOUNT? ',
                              ),
                              TextSpan(
                                text: 'LOGIN',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
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
