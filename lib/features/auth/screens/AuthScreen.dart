import 'package:amazon_clone_1/common/Custom_button.dart';
import 'package:amazon_clone_1/common/Custom_textfield.dart';
import 'package:amazon_clone_1/constants/GlobalVariables.dart';
import 'package:amazon_clone_1/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';

enum Auth {
  Signup,
  Signin,
}

class Auth_Screen extends StatefulWidget {
  static const String routename = '/auth-screen';

  const Auth_Screen({super.key});

  @override
  State<Auth_Screen> createState() => _Auth_ScreenState();
}

class _Auth_ScreenState extends State<Auth_Screen> {
  Auth _auth = Auth.Signup;
  final _sign_up_key = GlobalKey<FormState>();
  final _sign_in_key = GlobalKey<FormState>();
  final Auth_Services auth = Auth_Services();
  final TextEditingController _Email_controller = TextEditingController();
  final TextEditingController _Pass_controller = TextEditingController();
  final TextEditingController _Name_controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _Email_controller.dispose();
    _Pass_controller.dispose();
    _Name_controller.dispose();
  }

  void signupUser() {
    auth.Signup(
        email: _Email_controller.text,
        password: _Pass_controller.text,
        name: _Name_controller.text,
        context: context);
  }

  void signinUser() {
    auth.signInUser(
        email: _Email_controller.text,
        password: _Pass_controller.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Welcome',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
            ),
            ListTile(
              tileColor: _auth == Auth.Signup
                  ? Colors.white
                  : GlobalVariables.greyBackgroundCOlor,
              title: Text(
                'Create Account',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                value: Auth.Signup,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(() {
                    print("$_auth" + "value ");
                    _auth = val!;
                  });
                },
              ),
            ),
            if (_auth == Auth.Signup)
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(8.0),
                child: Form(
                  key: _sign_up_key,
                  child: Column(
                    children: [
                      Custom_textfield(
                        controller: _Name_controller,
                        hintext: "Name",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Custom_textfield(
                        controller: _Email_controller,
                        hintext: "Email",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Custom_textfield(
                        controller: _Pass_controller,
                        hintext: "Password",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Custom_button(
                          text: "Sign up",
                          onpress: () {
                            if (_sign_up_key.currentState!.validate()) {
                              signupUser();
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ListTile(
              tileColor: _auth == Auth.Signin
                  ? Colors.white
                  : GlobalVariables.greyBackgroundCOlor,
              title: Text(
                'Sign-in.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                value: Auth.Signin,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(() {
                    print("$_auth" + "value");
                    _auth = val!;
                  });
                },
              ),
            ),
            if (_auth == Auth.Signin)
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(8.0),
                child: Form(
                  key: _sign_in_key,
                  child: Column(
                    children: [
                      Custom_textfield(
                        controller: _Email_controller,
                        hintext: "Email",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Custom_textfield(
                        controller: _Pass_controller,
                        hintext: "Password",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Custom_button(
                          text: "Sign up",
                          onpress: () {
                            signinUser();
                          }),
                    ],
                  ),
                ),
              ),
          ],
        ),
      )),
    );
  }
}
