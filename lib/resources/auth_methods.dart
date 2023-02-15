import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthenticationMethods {
  //Below code of line used for Firebase Authentication.
  final FirebaseAuth _authentication = FirebaseAuth.instance;
  //Below code of line used for user credential add into database.
  final FirebaseFirestore _databaseStorage = FirebaseFirestore.instance;

//Below the Funtion is used for sign up a user by authentication.
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String userName,
      required String bio,
      required Uint8List image}) async {
    String res = "Some Error Occurd";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          userName.isNotEmpty ||
          bio.isNotEmpty) {
        //Users Register with below the code .
        UserCredential credential = await _authentication
            .createUserWithEmailAndPassword(email: email, password: password);
        // print(credential.user!.uid);

        String photoURL = await StorageMethods()
            .uploadImageToStorage("Profile Picture", image, false);
        //Add user to our Database for knowing exists or many kin of operation handling.
        _databaseStorage.collection("Users").doc(credential.user!.uid).set({
          "username": userName,
          "email": email,
          "password": password,
          "bio": bio,
          "followers": [],
          "following": [],
          "photoURL": photoURL
        });

        /*

      ***another way to configure document id changes

        _databaseStorage.collection("Users").add({
          "username": userName,
          "email": email,
          "password": password,
          "bio": bio,
          "followers": [],
          "following": [],
          "uid":credential.user!.uid
        });

        */

        res = "success";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

// logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _authentication.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }
}
