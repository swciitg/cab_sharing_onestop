import 'package:campus_ola/stores/login_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  static const id = "/signin";
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late String email;
  late String password;
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 200,),
              const Icon(
                Icons.directions_car,
                color: Colors.white60,
                size: 100,
              ),
              const SizedBox(height: 40,),
              Container(
                margin: const EdgeInsets.only(left: 30, right: 30),
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(39, 49, 65, 1),
                    borderRadius: BorderRadius.all(
                        Radius.circular(21)
                    )
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                child: TextFormField(
                  style: GoogleFonts.montserrat(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    color: const Color(0xFFBDC7DC),
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
              const SizedBox(height: 30,),
              Container(
                margin: const EdgeInsets.only(left: 30, right: 30),
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(39, 49, 65, 1),
                    borderRadius: BorderRadius.all(
                        Radius.circular(21)
                    )
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                child: TextFormField(
                  style: GoogleFonts.montserrat(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    color: const Color(0xFFBDC7DC),
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
              const SizedBox(height: 40,),
              Builder(builder: (builderContext) => GestureDetector(
                onTap: () async {
                  try{
                    bool validate = _formKey.currentState!.validate();
                    if(validate){
                      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(email).get();
                      if(!mounted)
                        {
                          return;
                        }
                      context.read<LoginStore>().saveUserData(userSnapshot["name"], email, userSnapshot["phonenumber"]);
                      Navigator.of(context).pushReplacementNamed('/home');
                    }
                  }
                  catch (err){
                    ScaffoldMessenger.of(builderContext).showSnackBar(SnackBar(content: Text(err.toString())));
                  }
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(118, 172, 255, 1),
                      borderRadius: BorderRadius.all(
                          Radius.circular(16)
                      )
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 15),
                  child: Text(
                    "Sign In",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              )),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "No Account ?",
                    style: GoogleFonts.montserrat(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                      color: const Color(0xFFBDC7DC),
                    ),
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.of(context).pushReplacementNamed('/signup');
                      }, child: Text(
                    "SignUp",
                    style: GoogleFonts.montserrat(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                      color:const Color.fromRGBO(118, 172, 255, 1),
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