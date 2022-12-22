import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:tech_media/utils/utils.dart';

class SignUpController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void signUp(String username, String email, String password) async {
    try {
      setLoading(true);
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        ref.child(value.user!.uid).set({
          'uid':value.user!.uid,
          'username':username,
          'email':email,
          'onlineStatus':'noOne',
          'phone':'',
          'profile':''
        }).then((value) {
          Utils.toastMessage("User Created Sucessfully");
          setLoading(false);
        }).onError((error, stackTrace) {
          Utils.toastMessage(error.toString());
          setLoading(false);
        });
      }).onError((error, stackTrace) {
        Utils.toastMessage(error.toString());
        setLoading(false);
      });
    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
  }
}
