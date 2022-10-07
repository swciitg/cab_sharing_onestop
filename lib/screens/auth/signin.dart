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
      backgroundColor: Color.fromRGBO(27, 27, 29, 1),
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          reverse: true,
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 200,),
              Icon(
                  Icons.directions_car,
                  color: Colors.white60,
                  size: 100,
              ),
              SizedBox(height: 40,),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(39, 49, 65, 1),
                    borderRadius: BorderRadius.all(
                        Radius.circular(21)
                    )
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
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
                      hintText: "Enter Email",
                      hintStyle: TextStyle(
                        color: Colors.white60,
                      ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(39, 49, 65, 1),
                    borderRadius: BorderRadius.all(
                        Radius.circular(21)
                    )
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  obscureText: true,
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
                      hintText: "Enter Password",
                      hintStyle: TextStyle(
                        color: Colors.white60,
                      )
                  ),
                ),
              ),
              SizedBox(height: 40,),
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
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(118, 172, 255, 1),
                      borderRadius: BorderRadius.all(
                          Radius.circular(16)
                      )
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                  child: const Text(
                    "Proceed",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20
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
                      color: Colors.white60,
                        fontSize: 16
                    ),
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.of(context).pushReplacementNamed('/signup');
                      }, child: const Text(
                    "SignUp",
                    style: TextStyle(
                        color: Color.fromRGBO(118, 172, 255, 1),
                        fontSize: 16
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
