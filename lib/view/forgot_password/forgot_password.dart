import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/component/input_text_field.dart';
import 'package:tech_media/res/component/round_button.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view_model/forget_password/forget_password_controller.dart';
import 'package:tech_media/view_model/login/login_controller.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
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
                  "Forgot Password",
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  "Enter your email address\nto recover your password",
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
                          
                              },
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              hint: 'Email',
                              onValidator: (value) {
                                return value.isEmpty ? 'Enter email' : null;
                              }),
                          
                        ],
                      ),
                    )),
                
                const SizedBox(
                  height: 40,
                ),
                ChangeNotifierProvider(create: (_)=>ForgetPasswordController(),
                child: Consumer<ForgetPasswordController>(builder: (context,provider,child){
                  return RoundButton(
                    title: "Recover", 
                  loading: provider.loading,
                  onPress: () {
                    if(_formKey.currentState!.validate()){
                      provider.forgotPassword(context, emailController.text);
                    }
                  });
                }),
                ),
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
