import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Login Screen"),
        ) ,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: TextStyle(fontSize: 32,
              color: Colors.lightBlueAccent,
              fontWeight: FontWeight.bold),
              ),

            SizedBox(height: 40,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: mailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Enter Email",
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                       ),
                       onChanged: (String email){

                       },
                       validator: (email){
                        return email!.isEmpty ? "Please enter an email" : null;
                       },
                    ),

                    SizedBox(height: 20,),

                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter password",
                        prefixIcon: Icon(Icons.key),
                        border: OutlineInputBorder(),
                       ),
                       onChanged: (String password){

                       },
                       validator: (password){
                        return password!.isEmpty ? "Please enter an password" : null;
                       },
                    ),
                    

                    SizedBox(height: 20,),

                    
                    MaterialButton(
                      minWidth: double.infinity,
                        onPressed: (){try {
                          final credential =  FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: mailController.text,
                            password: passwordController.text
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
                        }
                        },
                        child: Text("Login",style: TextStyle(fontSize: 20),),
                        color: Colors.lightBlueAccent,
                        textColor: Colors.white,
                      ),
                    SizedBox(height: 20,),

                    Text("Hesabınız yok mu? Hemen kayıt olun!"),

                    MaterialButton(

                        onPressed: (){Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpPage()),
                        );},
                        child: Text("Sign Up",style: TextStyle(fontSize: 20),),
                        color: Colors.lightBlueAccent,
                        textColor: Colors.white,
                      ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}