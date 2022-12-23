import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(SessionController().userId.toString()),
      actions: [
        IconButton(onPressed: (){
          FirebaseAuth auth = FirebaseAuth.instance;
          auth.signOut().then((value) {
            SessionController().userId = '';
            Navigator.pushNamed(context, RouteName.loginView);
          });
        }, icon: Icon(Icons.logout_outlined))
      ],
      ),
      body: Column()
      
       );
 
  }
}