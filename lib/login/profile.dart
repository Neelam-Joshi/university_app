import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/gettext.dart';
import 'dart:io';

import 'imagecrop.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  var image = "assets/images/profile_pic.png";
  File? fileImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1E2F59),
        title: Text("Home"),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.only(left:20,right:20),
          child: Column(
            children: [
              const SizedBox(height:20),
              Container(
                  alignment: Alignment.center,
                  width: 150,
                  height:150,
                  decoration:BoxDecoration(
                    shape: BoxShape.circle,
                      border: Border.all(
                        width: 1,  color:Colors.grey.shade200,
                      ),
                      //borderRadius: BorderRadius.circular(100),
                      color:Color(0xffffffff)
                  ),
                  child:Image.file(fileImage!),
                  //Image.asset(image,fit: BoxFit.cover,width: 100,
                    //height:100,)
              ),
              const SizedBox(height:5),
              InkWell(
                onTap: (){
                   actionSheet(context);
                },
                child: GetText("Change Profile Picture", 16,FontWeight.w400, Colors.red),
              ),
              const SizedBox(height:5),
              buildTextField("Name", nameController,TextInputType.text,false ),
              const SizedBox(height:10),
              buildTextField("Age", ageController,TextInputType.number,false),
              const SizedBox(height:40),
              buttonUI(40,"Next",const Color(0xff1E2F59),const Color(0xffffffff),
                      (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>const ProfileScreen())
                    );
                  }
              )
            ],
          )
      ),
    );
  }
  Widget buildTextField(hintText,TextEditingController controller, TextInputType keyboardType,isVisible){
    return Container(
        height: 40,
        padding: const EdgeInsets.only(left:16),
        decoration: BoxDecoration(
            borderRadius:  BorderRadius.circular(15),
            border: Border.all(
                width: 1,
                color: const Color(0xffA3A3A3)
            )
        ),
        child: TextField(
          obscureText:isVisible,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black
              )
          ),
        )
    );

  }
  Widget buttonUI(double height, btnTitle, Color btnColor, Color textColor,Function () ontap){
    return InkWell(
      onTap: ontap,
      child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width-40,
          height:height,
          decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color:btnColor
          ),
          child:GetText(btnTitle, 16, FontWeight.w400, textColor)
      ),
    );

  }

   actionSheet(context){
     return showCupertinoModalPopup(
       context: context,
       builder:(context)=>
           CupertinoActionSheet(
                title: const  Text("Choose Image"),
                cancelButton: CupertinoActionSheetAction(
                  child:const  Text("Cancel"),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
             actions: [
               CupertinoActionSheetAction(
                 child:const  Text("Choose From Gallery"),
                 onPressed: (){
                   getImageFromGallery();
                   Navigator.of(context).pop();
                 },
               ),
               CupertinoActionSheetAction(

                 child:const  Text("Pick From Camera"),
                 onPressed: (){
                   getImageFromCamera();
                   Navigator.of(context).pop();
                 },
               ),
             ],
           )

     );
  }
  final picker = ImagePicker();
  getImageFromGallery() async{
   var file =await picker.pickImage(source:ImageSource.gallery);
   var profimage = File(file!.path);
   print('profimage${profimage}');
   var aargs = await Navigator.of(context).push(
     PageRouteBuilder(
       opaque: false, // set to false
       pageBuilder: (____, _, ___) => ImageCropNewViewFileData(profimage),
     ));
   fileImage = aargs.path;
   print('aargs$aargs.path');
   print('fileImage${fileImage}');
   setState(() {});
  }
  getImageFromCamera(){

  }
}
