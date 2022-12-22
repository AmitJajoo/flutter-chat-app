import 'package:flutter/material.dart';
import 'package:tech_media/res/component/input_text_field.dart';
import 'package:tech_media/res/component/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputTextField(
              myController: emailController,
              focusNode: emailFocusNode,
              onFiledSubmittedValue: (value){},
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              hint: 'Email',
              onValidator: (value){
                    return value.isEmpty ? 'Enter email' : null;
              }),
            RoundButton(title: "Login", onPress: (){})
          ],
        ),
      ),
    );
  }
}