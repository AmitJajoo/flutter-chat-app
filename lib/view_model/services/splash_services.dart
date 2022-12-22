import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:tech_media/utils/routes/route_name.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    Timer(const Duration(seconds: 3), () => Navigator.pushNamed(context, RouteName.loginView));
  }
}
