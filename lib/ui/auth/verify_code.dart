import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/ui/posts/post_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../../widgets/round_button.dart';
class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({Key? key,required this.verificationId}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final verificationCodeController = TextEditingController();
  bool loading = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 80),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: verificationCodeController,
              decoration: InputDecoration(hintText: "6 Digit Code"),
            ),
            SizedBox(height: 80),
            Roundbutton(
                loading:loading,
                title: "Verify",
                onTap: () async{
                  setState(() {
                    loading=true;
                  });
                 final credential=PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: verificationCodeController.text.toString());
                 try {
                   await _auth.signInWithCredential(credential);
                   Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen()));
                 }
                 catch(e){
                   setState(() {
                     loading=false;
                   });
                   Utils().toastMessage(e.toString());

                 }
                })
          ],
        ),
      ),
    );
  }
}
