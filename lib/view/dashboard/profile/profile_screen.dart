

import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/component/round_button.dart';
import 'package:tech_media/view_model/profile/profile_controller.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ref = FirebaseDatabase.instance.ref('Users');
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>ProfileController(),
      child: Consumer<ProfileController>(
        builder: (context, provider, child) {
        return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:const EdgeInsets.symmetric(horizontal: 15),
          child: StreamBuilder(
            stream: ref.child(SessionController().userId.toString()).onValue,
            builder: (context,AsyncSnapshot snapshot) {
              if(!snapshot.hasData){
                return const Center(child: CircularProgressIndicator(),);
              }else if(snapshot.hasData){
                Map<dynamic,dynamic> map = snapshot.data.snapshot.value;
                return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             const SizedBox(height: 20,),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Container(    
                        decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(
                          color: AppColors.secondaryTextColor,
                        )),
                        width: 130,
                        height: 130,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: provider.image == null ? map['profile'] == ''? Icon(CupertinoIcons.person,size: 40,): Image(
                            image: NetworkImage(map['profile']),
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(child: CircularProgressIndicator(),);
                            },
                            errorBuilder: (context, error, stackTrace) =>const Icon(Icons.error_outline,color: AppColors.alertColor,),
                          ):Stack(
                            children: [
                              Image.file(File(provider.image!.path).absolute, fit: BoxFit.cover,),
                              const Center(child: CircularProgressIndicator())
                            ],
                          ),
                          ),
                        ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                        provider.pickImage(context);
                    },
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: AppColors.primaryIconColor,
                      child: Icon(CupertinoIcons.add,color: AppColors.whiteColor,)),
                  )
                ],
              ),
              const SizedBox(height: 40,),
              ResuableRow(title: 'Username', value: map['username'], iconData: CupertinoIcons.profile_circled),
              ResuableRow(title: 'Phone', value: map['phone'] == '' ? 'xxx-xxx-xxxx':map['phone'], iconData: CupertinoIcons.phone),
              ResuableRow(title: 'Email', value: map['email'], iconData: Icons.email_outlined),
             const SizedBox(height: 40,),
              RoundButton(title: 'Logout', onPress: (){})
            ],
          );
          
              }
              else{
                return Text("Something went wrong",style: Theme.of(context).textTheme.subtitle1);
              }
          },)
         ),
      ),
    );
  
      },),
    );
  }
}


class ResuableRow extends StatelessWidget {
  final String title,value;
  final IconData iconData;
  const ResuableRow({super.key, required this.title,required this.value, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title,style: Theme.of(context).textTheme.subtitle2,),
          trailing: Text(value,style: Theme.of(context).textTheme.subtitle2,),
          leading: Icon(iconData,color: AppColors.primaryIconColor,),
        ),
        Divider(color: AppColors.dividedColor.withOpacity(0.4),)
      ],
    );
  }
}