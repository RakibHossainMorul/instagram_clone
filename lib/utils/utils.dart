// ignore_for_file: unused_import, avoid_print

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//Define a function for pick image from gallery
pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return file.readAsBytes();
  }
  print("No Image Selected");
}

//This is using for if not sign up and why not sign up details
showSnackBar(BuildContext context, String content) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
