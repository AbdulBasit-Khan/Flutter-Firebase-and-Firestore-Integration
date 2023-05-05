import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/ui/auth/login_screen.dart';
import 'package:firebase_tutorial/ui/firestore/firestore_list_screen.dart';
import 'package:firebase_tutorial/ui/posts/post_screen.dart';
import 'package:firebase_tutorial/ui/upload_image.dart';
import 'package:flutter/material.dart';

class SplashServices{

  void isLogin(BuildContext context){
    FirebaseAuth _auth=FirebaseAuth.instance;
    final user = _auth.currentUser;
    if(user!=null){
      Timer(const Duration(seconds:3), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => UploadImageScreen()));
      });
    }
    else{
      Timer(const Duration(seconds:3), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    }

  }
}