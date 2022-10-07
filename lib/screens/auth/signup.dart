import 'package:campus_ola/screens/auth/signin.dart';
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
  var email;
  var password;
  var name;
  var phonenumber;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Signup Screen"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          reverse: true,
          physics: const BouncingScrollPhysics(),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 120,
            ),
            const Text(
              "SignUp Screen",
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: TextFormField(
                keyboardType: TextInputType.name,
                maxLength: 20,
                onChanged: (value){
                  name=value.trim();
                },
                validator: (value){
                  if (value == null) {
                    return 'Please enter your name';
                  }
                  value=value.trim();
                  if(value.isEmpty){
                    return 'Please enter your name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: "Enter Name"
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
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
                keyboardType: TextInputType.text,
                maxLength: 12,
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
                decoration: const InputDecoration(
                    hintText: "Enter Password"
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value){
                  phonenumber=value.trim();
                },
                maxLength: 10,
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  value=value.trim();
                  if(value.length !=10){
                    return 'Phonenumber must be of 10 digits';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: "Enter Phone Number"
                ),
              ),
            ),
            Builder(builder: (builderContext) => GestureDetector(
              onTap: () async {
                try{
                  bool validate = _formKey.currentState!.validate();
                  if(validate){
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                    await FirebaseFirestore.instance.collection("users").doc(email).set({"email" : email,"name" : name,"phonenumber":phonenumber});
                    context.read<LoginStore>().saveUserData(name, email, phonenumber);
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
            ),),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Already have an account ?",
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
                TextButton(
                    onPressed: (){
                      Navigator.of(context).pushReplacementNamed('/signin');
                    }, child: const Text(
                  "SignIn",
                  style: TextStyle(
                      fontSize: 16
                  ),
                ))
              ],
            ),
          ],
      ),
        ),
      )
    );
  }
}
