// import 'package:flutter/material.dart';
// import 'package:to_do/Deafults.dart';

// class LOGIN extends StatefulWidget {
//   const LOGIN({super.key});

//   @override
//   State<LOGIN> createState() => _LOGINState();
// }

// class _LOGINState extends State<LOGIN> {
//   bool VisiblePass = false;
//   final _emailController = TextEditingController();
//   final _PasswordController = TextEditingController();
//   var FormKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.tealAccent,
//       ),
//       body: Center(
//         child: Container(
//           padding: const EdgeInsets.all(10),
//           child: SingleChildScrollView(
//             child: Form(
//               key: FormKey,
//               child: Column(
                
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // const SizedBox(
//                   //   height: 10,
//                   // ),
//                   const Text(
//                     "Login",
//                     style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(
//                     height: 40,
//                   ),
//                   DefaultForm(
                  
//                     PrefIcon: Icons.email,
//                     controller: _emailController,
//                     inputType: TextInputType.emailAddress,
//                     label: "Email Address",
//                     validate: (val) {
//                       if (!val!.contains('@')) {
//                         return "Please enter a valid email address";
//                       }
//                       if (val.isEmpty) return "please enter an email address";
//                       return null;
//                     },
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   DefaultForm(
//                     isVisiple: VisiblePass,
//                       Obscure: !VisiblePass,
//                       inputType: TextInputType.visiblePassword,
//                       controller: _PasswordController,
//                       // label: "Password",
//                       PrefIcon: Icons.lock,
//                       SuffIcon: Icons.remove_red_eye,
//                       validate: (pass) {
//                         if (pass!.isEmpty) {
//                           return "Please enter a password";
//                         }
//                         String pattern =
//                             r'^(?=.*[!@#$%^&*(),.?":{}|<>])(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$';
//                         RegExp regExp = RegExp(pattern);

//                         if (!regExp.hasMatch(pass)) {
//                           return"Password requires symbol, lowercase, uppercase, digit, \nand min 8 characters.";
//                         }
//                         return null;
//                       },
//                       SuffiFunction: () {
//                         VisiblePass = !VisiblePass;
//                         setState(() {});
//                       }),
//                       const SizedBox(height: 10,),
//                   Center(
//                     child: Container(
//                       height: 60,
//                       width: double.infinity,
//                       // margin: EdgeInsets.all(10),
//                       color: const Color(0xff00007C),
//                       child: MaterialButton(
//                         onPressed: () {
//                           if (FormKey.currentState!.validate()) {
//                             print(_emailController.text);
//                             print(_PasswordController.text);
//                           }
//                         },
//                         child: const Text("LOGIN",style: TextStyle(color: Colors.white),),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text("Don't have an account?"),
//                       TextButton(child: const Text( "Register Now"),onPressed: () {} ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
