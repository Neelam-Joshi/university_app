import 'package:flutter/material.dart';
import 'package:university_app/login/otpscreen.dart';
import 'package:university_app/login/profile.dart';
import 'package:university_app/widgets/gettext.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
   TextEditingController phoneController = TextEditingController();

   bool _passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1E2F59),
        title: Text("Home"),
        centerTitle: true,
      ),
      body:
      Padding(
        padding: const EdgeInsets.only(left:20,right:20),
        child: Column(
          children: [
             const SizedBox(height:40),
             buildTextField("Email", emailController,TextInputType.emailAddress,false ),
             const SizedBox(height:10),
             buildTextField("Password", passwordController,TextInputType.visiblePassword,true),
            const SizedBox(height:10),
            buildTextField("Phone Number", phoneController,TextInputType.number,false),
             const SizedBox(height:40),
             buttonUI(40,"Login",const Color(0xff1E2F59),const Color(0xffffffff),
                 (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context)=>OTPScreen(phoneController.text))
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
}
