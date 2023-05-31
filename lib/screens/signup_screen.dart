import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/resources/auth_method.dart';
import 'package:socialapp/screens/login_screen.dart';
import 'package:socialapp/utils/utils.dart';
import 'package:socialapp/widgets/show_snackbar.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../widgets/my_buttton.dart';
import '../widgets/my_textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _biocontroller = TextEditingController();
  final _usernamecontroller = TextEditingController();
  Uint8List? _image;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _biocontroller.dispose();
    _passwordcontroller.dispose();
    _usernamecontroller.dispose();
  }

  void selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    String res = await AuthMethods().signUpUser(
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
      username: _usernamecontroller.text,
      bio: _biocontroller.text,
      file: _image,
    );
    Navigator.pop(context);

    if (res == "Success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
              webScreenLayout: WebScreenLayout(),
              mobileScreenLayout: MobileScreenLayout()),
        ),
      );
    } else {
      showSnackBar(context, res);
    }
  }

  void navigatetologinScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              //logo
              Icon(
                Icons.leaderboard_outlined,
                size: 50,
              ),
              SizedBox(height: 25),

              //avatar
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                            "https://1fid.com/wp-content/uploads/2022/06/no-profile-picture-6-1024x1024.jpg",
                          ),
                        ),
                  Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(
                          Icons.add_a_photo,
                        ),
                      ))
                ],
              ),

              const SizedBox(height: 25),
              //username textfield
              MyTextField(
                controller: _usernamecontroller,
                hintText: 'Username',
                obscureText: false,
              ),
              const SizedBox(height: 10),

              //email textfield
              MyTextField(
                controller: _emailcontroller,
                hintText: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              //bio textfield
              MyTextField(
                controller: _biocontroller,
                hintText: 'Bio',
                obscureText: false,
              ),
              const SizedBox(height: 10),

              //password textfield
              MyTextField(
                controller: _passwordcontroller,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 25),

              //sign in
              MyButton(
                onTap: signUpUser,
                text: 'Sign Up',
              ),

              const SizedBox(height: 25),
              //or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '----',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              //google+apple sign in

              const SizedBox(
                height: 25,
              ),

              //not a member? sign up now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account ?'),
                  SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: navigatetologinScreen,
                    child: Text(
                      'Login now',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
