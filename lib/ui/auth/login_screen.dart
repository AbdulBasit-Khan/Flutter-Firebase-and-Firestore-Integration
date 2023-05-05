import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/ui/auth/SignUp_Screen.dart';
import 'package:firebase_tutorial/ui/auth/forgot_password.dart';
import 'package:firebase_tutorial/ui/auth/login_with_phone_number.dart';
import 'package:firebase_tutorial/ui/posts/post_screen.dart';
import 'package:firebase_tutorial/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/round_button.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final  emailController=TextEditingController();
  final  passwordController=TextEditingController();
  final _formKey=GlobalKey<FormState>();
  bool loading=false;
  final _auth=FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  void login(){
    setState(() {
      loading=true;
    });
    _auth.signInWithEmailAndPassword(email: emailController.text.toString(), password: passwordController.text.toString()).then((value) {
      Utils().toastMessage(value.user!.email.toString());
      Navigator.push(context,MaterialPageRoute(builder: (context) => PostScreen()));
      setState(() {
        loading=false;
      });
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(

          automaticallyImplyLeading: false,
          title:Center(child: Text('Login'))
        ),
          body:Column(
            mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key:_formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller:emailController ,

                      decoration: InputDecoration(

                        hintText: 'Email',

                        prefixIcon: Icon(Icons.alternate_email),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter Email';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height:20),
                    TextFormField(
                      keyboardType: TextInputType.text ,
                      controller:passwordController ,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText:'Password',

                        prefixIcon: Icon(Icons.lock),


                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter Password';
                        }
                        return null;
                      },
                    ),

                  ],
                )),
                 SizedBox(height:50),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal:20),
                   child: Roundbutton(title:'Login',loading:loading,onTap:(){
                     if(_formKey.currentState!.validate()){
                      login();
                     }

                   }),
                 ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) =>ForgotPasswordScreen()));
              },
                child:Text('Forgot Password')
                ,),
            ),
             SizedBox(height:30),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text("Don't have an account ?"),
                 TextButton(onPressed: (){
                   Navigator.push(context,MaterialPageRoute(builder: (context) =>SignUpScreen()));
                 },
                 child:Text('Sign up')
                   ,),

               ],
             ),
            SizedBox(height:30),
            InkWell(
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => LoginWithPhoneNumber()));
              },
              child: Container(

                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color:Colors.black),
                ),
                height:50,
                  child:Center(
                      child:Text('Login with phone')
                  )
              ),
            )
          ],
        )
      ),
    );
  }
}
