import 'package:flutter/material.dart';
import 'package:tech_media/res/component/input_text_field.dart';
import 'package:tech_media/res/component/round_button.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();

  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();

    passwordController.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  "Welcome to the App",
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  "Enter your email address\nto connect to your account",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.06, bottom: height * 0.01),
                      child: Column(
                        children: [
                          InputTextField(
                              myController: emailController,
                              focusNode: emailFocusNode,
                              onFiledSubmittedValue: (value) {
                                Utils.fieldFocus(
                                    context, emailFocusNode, passwordFocusNode);
                              },
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              hint: 'Email',
                              onValidator: (value) {
                                return value.isEmpty ? 'Enter email' : null;
                              }),
                          InputTextField(
                              myController: passwordController,
                              focusNode: passwordFocusNode,
                              onFiledSubmittedValue: (value) {},
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              hint: 'Password',
                              onValidator: (value) {
                                return value.isEmpty ? 'Enter email' : null;
                              }),
                        ],
                      ),
                    )),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password",
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 15, decoration: TextDecoration.underline),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                RoundButton(title: "Login", onPress: () {}),
                SizedBox(
                  height: height * 0.03,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.signUpView);
                  },
                  child: Text.rich(TextSpan(
                      text: "Don't have an account ? ",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 15),
                      children: [
                        TextSpan(
                            text: 'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    fontSize: 15,
                                    decoration: TextDecoration.underline))
                      ])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
