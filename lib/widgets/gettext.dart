import 'package:flutter/material.dart';


Widget GetText(title,double size, FontWeight fontWeight,Color color){
  return  Text(title,
    style: TextStyle(
       fontSize: size,
       fontWeight: fontWeight,
       color:color,
       fontFamily:'Tw Cen MT'
    )
  );
}