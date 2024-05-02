import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/constant/colors.dart';
import 'package:todo_app/data/auth_data.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback show;

  const SignUpScreen({super.key, required this.show});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();

  final email = TextEditingController();
  final password = TextEditingController();
  final passwordConfirm = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode1.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              image(),
              SizedBox(
                height: 50,
              ),
              formField(email, _focusNode1, 'Email', Icons.email),
              SizedBox(
                height: 10,
              ),
              formField(password, _focusNode2, 'Password', Icons.password),
              SizedBox(
                height: 10,
              ),
              formField(passwordConfirm, _focusNode3, 'Password Confirm',
                  Icons.password),
              SizedBox(
                height: 8,
              ),
              signInButton(),
              SizedBox(
                height: 20,
              ),
              signUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Padding signInButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(color: Colors.grey[700], fontSize: 14),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: widget.show,
            child: Text(
              "Login",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget signUpButton() {
    return GestureDetector(
      onTap: () {
        AuthenticationRemote()
            .register(email.text, password.text, passwordConfirm.text);
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 15),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(10)),
        child: Text(
          'Sign Up',
          style: TextStyle(
              fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget formField(TextEditingController _controller, FocusNode _focusNode,
      String typeName, IconData iconData) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        style: TextStyle(fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
            prefixIcon: Icon(
              iconData,
              color: _focusNode.hasFocus ? Colors.green : Color(0xffc5c5c5c),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: typeName,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color(0xffc5c5c5c), width: 2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.green, width: 2))),
      ),
    );
  }

  Widget image() {
    return Container(
      color: Colors.green,
      width: double.infinity,
      height: 300,
      child: Center(
          child: Text(
        'TO DO APP',
        style: TextStyle(fontSize: 24),
      )),
    );
  }
}
