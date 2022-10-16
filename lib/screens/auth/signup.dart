import 'package:campus_ola/decorations/sign_up_style.dart';
import 'package:campus_ola/stores/login_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  static const id = "/signup";
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late String email;
  late String password;
  late String name;
  late String phoneNumber;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(27, 27, 29, 1),
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            reverse: true,
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Icon(
                  Icons.directions_car,
                  color: Colors.white60,
                  size: 100,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  decoration: kTextFieldFormContainerDecoration,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextFormField(
                    style: kTextFieldFormTextStyle,
                    keyboardType: TextInputType.name,
                    maxLength: 20,
                    onChanged: (value) {
                      name = value.trim();
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please enter your name';
                      }
                      value = value.trim();
                      if (value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    decoration: kTextFieldFormDecoration.copyWith(
                        hintText: "Enter Name"),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  decoration: kTextFieldFormContainerDecoration,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextFormField(
                    style: kTextFieldFormTextStyle,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value.trim();
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please enter your email';
                      }
                      value = value.trim();
                      if (value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    decoration: kTextFieldFormDecoration.copyWith(
                        hintText: "Enter Email"),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  decoration: kTextFieldFormContainerDecoration,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextFormField(
                    style: kTextFieldFormTextStyle,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    maxLength: 12,
                    onChanged: (value) {
                      password = value.trim();
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please enter a password';
                      }
                      value = value.trim();
                      if (value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                    decoration: kTextFieldFormDecoration.copyWith(
                        hintText: "Enter Password"),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  decoration: kTextFieldFormContainerDecoration,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextFormField(
                    style: kTextFieldFormTextStyle,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      phoneNumber = value.trim();
                    },
                    maxLength: 10,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      value = value.trim();
                      if (value.length != 10) {
                        return 'Phonenumber must be of 10 digits';
                      }
                      return null;
                    },
                    decoration: kTextFieldFormDecoration.copyWith(
                        hintText: "Enter Phone Number"),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Builder(
                  builder: (builderContext) => GestureDetector(
                    onTap: () async {
                      try {
                        bool validate = _formKey.currentState!.validate();
                        if (validate) {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email, password: password);
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(email)
                              .set({
                            "email": email,
                            "name": name,
                            "phonenumber": phoneNumber
                          });
                          if (!mounted) {
                            return;
                          }
                          context
                              .read<LoginStore>()
                              .saveUserData(name, email, phoneNumber);
                          Navigator.of(context).pushReplacementNamed('/home');
                        }
                      } catch (err) {
                        ScaffoldMessenger.of(builderContext).showSnackBar(
                            SnackBar(content: Text(err.toString())));
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: kSignUpTextContainerDecoration,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 15),
                      child: Text(
                        "Sign Up",
                        textAlign: TextAlign.center,
                        style: kSignUpTextStyle,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Already have an account ?",
                      style: kAlreadyHaveAnAccountTextStyle,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/signin');
                        },
                        child: Text(
                          "SignIn",
                          style: kSignInTextStyle,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
