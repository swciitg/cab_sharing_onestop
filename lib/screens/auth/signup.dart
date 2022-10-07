import 'package:campus_ola/screens/auth/signin.dart';
import 'package:campus_ola/stores/login_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

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
        backgroundColor: Color.fromRGBO(27, 27, 29, 1),
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
                SizedBox(
                  height: 100,
                ),
                Icon(
                  Icons.directions_car,
                  color: Colors.white60,
                  size: 100,
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
                    style: GoogleFonts.montserrat(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                      color: const Color(0xFFBDC7DC),
                    ),
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
                      hintText: "Enter Name",
                      hintStyle: TextStyle(
                        color: Colors.white60,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(39, 49, 65, 1),
                      borderRadius: BorderRadius.all(
                          Radius.circular(20)
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
                      hintText: "Enter Email",
                      hintStyle: TextStyle(
                        color: Colors.white60,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(39, 49, 65, 1),
                      borderRadius: BorderRadius.all(
                          Radius.circular(20)
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
                    keyboardType: TextInputType.text,
                    obscureText: true,
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
                      hintText: "Enter Password",
                      hintStyle: TextStyle(
                        color: Colors.white60,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(39, 49, 65, 1),
                      borderRadius: BorderRadius.all(
                          Radius.circular(20)
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
                      hintText: "Enter Phone Number",
                      hintStyle: TextStyle(
                        color: Colors.white60,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40,),
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
                      //Scaffold.of(builderContext).showSnackBar(SnackBar(content: Text(err.toString())));
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
                    child: Text(
                      "Proceed",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Already have an account ?",
                      style: GoogleFonts.montserrat(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: const Color(0xFFBDC7DC),
                      ),
                    ),
                    TextButton(
                        onPressed: (){
                          Navigator.of(context).pushReplacementNamed('/signin');
                        }, child: Text(
                      "SignIn",
                      style: GoogleFonts.montserrat(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color:Color.fromRGBO(118, 172, 255, 1),
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