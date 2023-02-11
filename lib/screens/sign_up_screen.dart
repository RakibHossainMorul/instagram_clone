import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_input_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  Uint8List? _picture;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
  }

  //Below function define for pick image from gallery.
  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _picture = image;
    });
  }

  void signUpUser() async {
    //For loading start by true value
    setState(() {
      _isLoading = true;
    });
    String response = await AuthenticationMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        userName: _userNameController.text,
        bio: _bioController.text,
        image: _picture!);
//For Loading End
    setState(() {
      _isLoading = false;
    });

    if (response != "success") {
      showSnackBar(context, response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 4,
              child: Container(),
            ),
            //Logo
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              color: primaryColor,
              height: 64,
            ),
            const SizedBox(
              height: 64,
            ),
            Stack(
              children: [
                _picture != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_picture!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage:
                            NetworkImage('https://i.stack.imgur.com/l60Hf.png'),
                        backgroundColor: Colors.red,
                      ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: () {
                      selectImage();
                    },
                    icon: const Icon(Icons.add_a_photo),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),

            //Email Text Field
            TextFieldInput(
                textEditingController: _emailController,
                hintText: "Give Your Email Address",
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 25,
            ),
            TextFieldInput(
                textEditingController: _bioController,
                hintText: "Give Your Bio",
                textInputType: TextInputType.text),
            const SizedBox(
              height: 25,
            ),
            TextFieldInput(
                textEditingController: _userNameController,
                hintText: "Give Your User Name ex: james",
                textInputType: TextInputType.text),
            const SizedBox(
              height: 25,
            ),
            //Password Field
            TextFieldInput(
              textEditingController: _passwordController,
              hintText: "Password",
              textInputType: TextInputType.text,
              isPass: true,
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              //Below the code used for Applying the funtion to Sign Up or Authentication
              onTap: () => signUpUser(),
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  color: blueColor,
                ),
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text("Sign Up"),
              ),
            ),
            const SizedBox(
              height: 12,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text("Already have account?"),
                ),
                GestureDetector(
                  onTap: (() {}),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
            Flexible(
              flex: 10,
              child: Container(),
            ),
          ],
        ),
      )),
    );
  }
}
