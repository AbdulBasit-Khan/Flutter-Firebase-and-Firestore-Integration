import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_tutorial/utils/utils.dart';
import 'package:firebase_tutorial/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? _image;
  bool loading =false;
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  final picker=ImagePicker();
  DatabaseReference databaseRef=FirebaseDatabase.instance.ref('Base');
  Future getGalleryImage()async{
    final pickedFile=await picker.pickImage(source: ImageSource.gallery,imageQuality: 80) ;
   setState(() {
     if(pickedFile!=null){
       _image=File(pickedFile.path);
     }
     else{
       print('no image picked');
     }
   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image' ),
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal:20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Center(
             child: InkWell(
               onTap: (){
                 getGalleryImage();
               },
               child: Container(
                 decoration:BoxDecoration(
                   border:Border.all(
                     color:Colors.black,

                   )
                 ),
                 height:200,
                 width:200,
                 child:Center(child:_image!=null ? Image.file(_image!. absolute):Icon(Icons.image))
               ),
             ),

           ),
            SizedBox(height:39),
            Roundbutton(loading:loading,title: 'Upload', onTap:()async{
              setState(() {
                loading=true;
              });
              firebase_storage.Reference ref= firebase_storage.FirebaseStorage.instance.ref('FolderName/'+DateTime.now().millisecondsSinceEpoch.toString());
              firebase_storage.UploadTask uploadTask=ref.putFile(_image!.absolute);
              await Future.value(uploadTask);
              var newUrl=await ref.getDownloadURL();
              databaseRef.child('1').set({
                'id':'1212',
                'title':newUrl.toString()
              }).then((value){
                setState(() {
                  loading=false;
                });
              }).onError((error, stackTrace){
                setState(() {
                  loading=false;
                });
              });
              Utils().toastMessage('Uploaded');
            })

          ],
        ),
      )
    );
  }

}
