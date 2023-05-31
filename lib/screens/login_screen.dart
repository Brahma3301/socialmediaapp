import 'package:flutter/material.dart';
import 'package:socialapp/screens/signup_screen.dart';

import '../resources/auth_method.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../widgets/my_buttton.dart';
import '../widgets/my_textfield.dart';
import '../widgets/show_snackbar.dart';
import '../widgets/square_tile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //text editing controller

  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  void loginUser() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    String res = await AuthMethods().loginUser(
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
    );
    Navigator.pop(context);
    if (res == "success") {
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

  void navigatetoSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignUp()));
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
              const SizedBox(height: 50),
              //logo
              Icon(
                Icons.leaderboard_outlined,
                size: 100,
              ),
              SizedBox(height: 50),

              //welcom back,you've been missed
              Text(
                "Project101!",
                style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
              ),
              const SizedBox(height: 25),

              //username textfield
              MyTextField(
                controller: _emailcontroller,
                hintText: 'Username',
                obscureText: false,
              ),
              const SizedBox(height: 10),

              //password textfield
              MyTextField(
                controller: _passwordcontroller,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              //forgot password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey.shade900),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              //sign in
              MyButton(
                onTap: loginUser,
                text: 'Sign In',
              ),

              const SizedBox(height: 50),
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
                        'Or continue with',
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
              const SizedBox(height: 50),

              //google+apple sign in
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //google button
                  Squaretile(onTap: () {}, imagepath: 'lib/images/google.png'),

                  const SizedBox(width: 10),
                  //apple button
                  Squaretile(imagepath: 'lib/images/apple.png'),
                ],
              ),
              const SizedBox(
                height: 50,
              ),

              //not a member? sign up now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member?'),
                  SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: navigatetoSignUp,
                    child: Text(
                      'Register now',
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
