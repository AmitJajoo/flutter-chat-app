

import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view_model/services/session_manager.dart';


class ProfileController with ChangeNotifier{

  XFile? _image;
  XFile? get image => _image;
  DatabaseReference ref = FirebaseDatabase.instance.ref('Users');
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

   final ImagePicker picker = ImagePicker();

   bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

    // Pick an image
    void imagePickerFromCameraAndGallery(BuildContext context , ImageSource source)async{
            final XFile? pickedImage = await picker.pickImage(source: source);
            if(pickedImage!=null){
              _image = XFile(pickedImage.path);
              uploadImage();
              notifyListeners();
            }
    }
   


 void pickImage(context){
    showDialog(
      context: context, builder: (context) {
      return AlertDialog(
        content: SizedBox(
        height: 120,
        child: Column(
          children: [
            ListTile(
              onTap: (){
                imagePickerFromCameraAndGallery(context,ImageSource.camera);
                Navigator.pop(context);
              },
              title:const Text("Camera"),
              leading:const Icon(CupertinoIcons.camera),
            ),
            ListTile(
              onTap: (){
                imagePickerFromCameraAndGallery(context,ImageSource.gallery);
                Navigator.pop(context);
              },
              title:const Text("Gallery"),
              leading:const Icon(Icons.image_outlined),
            )
          ],
        ),
      ),
      );
    });
  }

  void uploadImage() async{
    setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref('/profileImage ${SessionController().userId}');
    firebase_storage.UploadTask uploadTask = storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);
    final newUrl =await storageRef.getDownloadURL();
    ref.child(SessionController().userId.toString()).update({
      'profile':newUrl
    }).then((value) {
      setLoading(false);
      Utils.toastMessage('Profile Uploaded');
      _image = null;
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
    });
    
  }
}