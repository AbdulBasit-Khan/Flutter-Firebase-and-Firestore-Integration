import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_tutorial/utils/utils.dart';
import 'package:firebase_tutorial/widgets/round_button.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final postController=TextEditingController();
  bool loading=false;
final databaseRef= FirebaseDatabase.instance.ref('Base');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Add Post')
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
             String id= DateTime.now().millisecondsSinceEpoch.toString();
            databaseRef.child(id).set({
             'title' : postController.text.toString(),
              'id':id
            }
            ).then((value) {
              Utils().toastMessage("Post added");
              setState(() {
                loading=false;
              });
            }).onError((error, stackTrace) {
              Utils().toastMessage(error.toString());
              setState(() {
                loading=false;
              });
            });
            })
          ],
        ),
      )
    );
  }

}
