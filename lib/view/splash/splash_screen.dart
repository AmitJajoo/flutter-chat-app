import 'package:flutter/material.dart';
import 'package:tech_media/res/fonts.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
             Image(image: AssetImage('assets/images/logo.jpg')),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 20),
                child: Center(child: Text('Tech Brothers Media aaa' , style: TextStyle(fontFamily: AppFonts.sfProDisplayBold , fontSize: 40, fontWeight: FontWeight.w700),)),
              )
            ],
          )
      ),
    );
  }
}
