import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_tutorial/utils/utils.dart';
import 'package:firebase_tutorial/widgets/round_button.dart';
import 'package:flutter/material.dart';

class AddFireStoreDataScreen extends StatefulWidget {
  const AddFireStoreDataScreen({Key? key}) : super(key: key);

  @override
  State<AddFireStoreDataScreen> createState() => _AddFireStoreDataScreenState();
}

class _AddFireStoreDataScreenState extends State<AddFireStoreDataScreen> {
  final postController=TextEditingController();
  bool loading=false;
  final fireStore = FirebaseFirestore.instance.collection('user');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:Text('Add Firestore data')
        ),
        body:Padding(
          padding: const EdgeInsets.symmetric(horizontal:20),
          child: Column(
            children: [
              SizedBox(height:30),
              TextFormField(
                controller:postController,
                maxLines: 4,
                decoration: InputDecoration(
                    hintText: "What's in your mind",
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height:30),
              Roundbutton(title: 'Add',loading: loading, onTap: (){
                setState(() {
                  loading=true;
                });
                String id=DateTime.now().millisecondsSinceEpoch.toString();
                fireStore.doc(id).set({
                 'title':postController.text.toString(),
                  'id':id
                }).then((value) {
                  setState(() {
                    loading=false;
                  });
                  Utils().toastMessage('Post added');
                }).onError((error, stackTrace) {
                  setState(() {
                    loading=false;
                  });
                  Utils().toastMessage(error.toString());
                });


              })
            ],
          ),
        )
    );
  }

}
