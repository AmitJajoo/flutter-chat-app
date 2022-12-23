import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/component/input_text_field.dart';
import 'package:tech_media/res/component/round_button.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view_model/signup/sign_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final userController = TextEditingController();
  final userFocusNode = FocusNode();

  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();

  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userController.dispose();
    userFocusNode.dispose();

    emailController.dispose();
    emailFocusNode.dispose();

    passwordController.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: ChangeNotifierProvider(
              create: (_) => SignUpController(),
              child: Consumer<SignUpController>(
                  builder: (context, provider, child) {
                return SingleChildScrollView(
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
                        "Enter your email address\nto register your account",
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
                                    myController: userController,
                                    focusNode: userFocusNode,
                                    onFiledSubmittedValue: (value) {},
                                    keyboardType: TextInputType.text,
                                    obscureText: false,
                                    hint: 'Username',
                                    onValidator: (value) {
                                      return value.isEmpty
                                          ? 'Enter Username'
                                          : null;
                                    }),
                                InputTextField(
                                    myController: emailController,
                                    focusNode: emailFocusNode,
                                    onFiledSubmittedValue: (value) {},
                                    keyboardType: TextInputType.emailAddress,
                                    obscureText: false,
                                    hint: 'Email',
                                    onValidator: (value) {
                                      return value.isEmpty
                                          ? 'Enter email'
                                          : null;
                                    }),
                                InputTextField(
                                    myController: passwordController,
                                    focusNode: passwordFocusNode,
                                    onFiledSubmittedValue: (value) {},
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    hint: 'Password',
                                    onValidator: (value) {
                                      return value.isEmpty
                                          ? 'Enter password'
                                          : null;
                                    }),
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                      RoundButton(
                          title: "Sign Up",
                          loading: provider.loading,
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              provider.signUp(
                                  context,
                                  userController.text,
                                  emailController.text,
                                  passwordController.text);
                            }
                          }),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.loginView);
                        },
                        child: Text.rich(TextSpan(
                            text: "Already have an account ? ",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontSize: 15),
                            children: [
                              TextSpan(
                                  text: 'Login',
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
                );
              }),
            )),
      ),
    );
  }
}
