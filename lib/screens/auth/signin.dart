import 'package:campus_ola/screens/auth/signup.dart';
import 'package:campus_ola/stores/login_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatefulWidget {
  static const id = "/signin";
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  var email;
  var password;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "SignIn Screen",
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: TextFormField(
                onChanged: (value){
                  email=value.trim();
                },
                validator: (value){
                  if (value == null) {
                    return 'Please enter your email';
                  }
                  value=value.trim();
                  if(value.isEmpty){
                    return 'Please enter your email';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: "Enter Email"
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: TextFormField(
                onChanged: (value){
                  password=value.trim();
                },
                validator: (value){
                  if (value == null) {
                    return 'Please enter a password';
                  }
                  value=value.trim();
                  if(value.isEmpty){
                    return 'Please enter a password';
                  }
                  return null;
                },
                maxLength: 12,
                decoration: const InputDecoration(
                    hintText: "Enter Password"
                ),
              ),
            ),
            Builder(builder: (builderContext) => GestureDetector(
              onTap: () async {
                try{
                  bool validate = _formKey.currentState!.validate();
                  if(validate){
                    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(email).get();
                    context.read<LoginStore>().saveUserData(userSnapshot["name"], email, userSnapshot["phonenumber"]);
                    Navigator.of(context).pushReplacementNamed('/home');
                  }
                }
                catch (err){
                  Scaffold.of(builderContext).showSnackBar(SnackBar(content: Text(err.toString())));
                }
              },
              child: Container(
                color: Colors.amber,
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                child: const Text(
                  "Proceed",
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            )),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "No Account ?",
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
                TextButton(
                    onPressed: (){
                      Navigator.of(context).pushReplacementNamed('/signup');
                    }, child: const Text(
                  "SignUp",
                  style: TextStyle(
                      fontSize: 16
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
