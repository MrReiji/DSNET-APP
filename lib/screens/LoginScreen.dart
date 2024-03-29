import 'package:dorm_gym/models/ConnectionHandler.dart';
import 'package:dorm_gym/widgets/ComplexDrawer.dart';
import 'package:flutter/material.dart';

import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    Map<String, String> data;

    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 30.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    child: Image.asset(
                      "assets\\images\\dsnet-logo-small.png",
                      fit: BoxFit.contain,
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 25.0, right: 25.0, top: 10, bottom: 10),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: TextButton(
                onPressed: () {
                  //TODO FORGOT PASSWORD SCREEN GOES HERE
                },
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  data = {
                    '_username': _emailController.text,
                    '_password': _passwordController.text,
                  };
                  ConnectionHandler.loginFunction(data, context).then((succes) {
                    if (succes) {
                      print("Logged in!");
                      // _emailController.text = "";
                      // _passwordController.text = "";
                      Navigator.of(context).pushNamed(HomeScreen.routeName);
                    } else {
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Login Error"),
                              content: Text(
                                  "You have entered the wrong login or password. Please correct them to log in correctly."),
                              actions: [
                                TextButton(
                                  child: Text("Ok"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                      print("Not logged in. Something's wrong!");
                    }
                  });
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'New User?',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Create Account',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
