import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectapp/screens/dashboard_screen.dart';
import 'package:projectapp/student/student_homepage.dart';
import 'package:projectapp/authenticate/google_signin.dart';
// import 'home.dart';

 final CollectionReference mainCollectionStudent = FirebaseFirestore.instance.collection('student');
final DocumentReference documentReferenceStudent = mainCollectionStudent.doc('stLists');

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Login Page',
        style: TextStyle(
          fontSize: 20,
        )),),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("assets/logoSPNOTES.png"),height: 220,width: 200,),
              _signInButton(),
              _signInButton2(),
              
            ]
          ) 
          ,)
      )
      
    );
  }
  Widget _signInButton(){
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed:(){
        signInWithGoogle().then((result){
          if(result != null){
            
            // _validateRole(getUserEmail());
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context){
                  return const StudHomepage();
                },
                ),
            );
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0,10,0,10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/Google.jpg"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left:10),
              child: Text(
                'Sign in as Student',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                )

              )
              )
              
          ]
          )
          )

      
      );
  }
  Widget _signInButton2(){
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed:(){
        signInWithGoogle().then((result){
          if(result != null){
            
            // _validateRole(getUserEmail());
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context){
                  return DashboardScreen();
                },
                ),
            );
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0,10,0,10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/Google.jpg"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left:10),
              child: Text(
                'Sign in as Lecturer',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                )

              )
              )
              
          ]
          )
          )

      
      );
  }
  
  // validateRole(String email){
  //   final _auth = FirebaseAuth.instance;
  //   final dbRef = FirebaseDatabase.instance

  // }
}