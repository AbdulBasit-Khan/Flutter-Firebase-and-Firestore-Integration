import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/ui/auth/verify_code.dart';
import 'package:firebase_tutorial/utils/utils.dart';
import 'package:firebase_tutorial/widgets/round_button.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final phoneNumberController = TextEditingController();
  bool loading = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 80),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: phoneNumberController,
              decoration: InputDecoration(hintText: "+1 345 6789 234"),
            ),
            SizedBox(height: 80),
            Roundbutton(
              loading:loading,
                title: "Login",
                onTap: () {
                  setState(() {
                    loading=true;
                  });
                  _auth.verifyPhoneNumber(
                      phoneNumber: phoneNumberController.text,
                      verificationCompleted: (_) {
                        setState(() {
                          loading=false;
                        });
                      },
                      verificationFailed: (e) {
                        setState(() {
                          loading=false;
                        });
                        Utils().toastMessage(e.toString());
                      },
                      codeSent: (String verificationId, int? token) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyCodeScreen(
                                    verificationId: verificationId)));
                        setState(() {
                          loading=false;
                        });
                      },
                      codeAutoRetrievalTimeout: (e) {
                        setState(() {
                          loading=false;
                        });
                        Utils().toastMessage(e.toString());
                      });
                })
          ],
        ),
      ),
    );
  }
}
