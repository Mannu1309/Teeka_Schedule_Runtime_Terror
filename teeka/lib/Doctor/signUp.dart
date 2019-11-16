import 'package:flutter/material.dart';
import 'package:teeka/Widgets/styles.dart';
import 'package:teeka/Widgets/widgets.dart';
import 'package:teeka/Widgets/title.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController idController, passController;

  @override
  void initState() {
    super.initState();
    idController = new TextEditingController();
    passController = new TextEditingController();
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "Enter a valid email";
    } else {
      return null;
    }
  }

  loginClick() {
    Navigator.push(
      context,
      MaterialPageRoute(
        // builder: (context) => Dashboard(),
        fullscreenDialog: true,
      ),
    );
  }

  signupClick() {}

  @override
  Widget build(BuildContext context) {
    return Form(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset(
                'assets/symbol.png',
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Text(
                "Teeka Schedule",
                style: Styles(context).title().copyWith(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                    ),
              )
            ],
          ),
          ListTile(
            dense: true,
            title: title(context: context, text: "Login"),
          ),
          padding(
            formFields(
              controller: idController,
              context: context,
              validator: (String str) {
                return null;
              },
              hintText: "User Id",
            ),
          ),
          padding(
            formFields(
              context: context,
              controller: passController,
              hintText: "Password",
              validator: validateEmail,
              obscureText: true,
            ),
          ),
          padding(
            button(
              context: context,
              function: loginClick,
              text: "Login",
            ),
          ),
        ],
      ),
    );
  }
}
