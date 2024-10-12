import 'package:flutter/material.dart';

Widget DefaultForm(
    {required TextInputType inputType,
    required TextEditingController controller,
    required String label,
    bool isVisiple=false,
    bool Obscure = false,
    VoidCallback? ontap,
    //  Function(String)? onsubmit,
    
    required IconData PrefIcon,
    IconData? SuffIcon,
  String? Function(String?)? validate,
    VoidCallback? SuffiFunction
    }) {
  return Container(
      child: TextFormField(

    controller: controller,
    obscureText: Obscure,
    keyboardType: inputType,
          style: TextStyle(color: Colors.white), // Set the text color here

    validator: validate,
    decoration: InputDecoration(
      prefixIcon: Icon(PrefIcon,color: Colors.white),
      suffixIcon: SuffIcon != null
          ? IconButton(
              icon: isVisiple
                  ? Icon(
                      SuffIcon,
                      color: Colors.blue,
                    )
                  : Icon(SuffIcon),
              onPressed:SuffiFunction,
            )
          : null,
      label: Text(label,style:TextStyle(color: Colors.grey[500],) ),
      
      border: OutlineInputBorder(),
    ),
    onTap: ontap,
    // onFieldSubmitted: onsubmit,
  ));
}
