// import 'package:cough_detection/home.dart';
// import 'package:cough_detection/register.dart';
import 'dart:convert';

import 'package:cough_detection/constants/constant.dart';
import 'package:cough_detection/screens/home.dart';
import 'package:cough_detection/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
final formKey=GlobalKey<FormState>();
  login(BuildContext context)async{
    String url='${Constant.baseUrl}login_view_api/';
    print(url);
    final res= await post(Uri.parse(url),body: {
      'uname':usernameController.text,
      'pass' :passwordController.text
    });
    print(res.body);

    final data=jsonDecode(res.body);
    print(data['status'] as bool);
    if (data['status'] == true && data['result']['type']=='user') {
      final spref=await SharedPreferences.getInstance();
      spref.setString('id', data['result']['id'].toString());
      spref.setString('type', data['result']['type']);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: ((context) => home())));
    }else{
    showDialog(context: context, builder: (context){return AlertDialog(
      title: Text('Something wrong'),
      actions: [ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text('OK'))],
      // content: Text(data['errors']),
    );});
    }
  }
 

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Stack(

        children: [
          Container(
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/wall.webp'),fit: BoxFit.fitHeight)),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key:formKey ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'field is empty';
                          } else if (value.length < 8) {}
                        },
                        controller: usernameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            label: Text('username'))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'field is empty';
                          } else if (value.length < 8) {
                            return 'password too short';
                          }
                        },
                        // obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            label: Text('password'))),
                  ),
                  ElevatedButton(onPressed: () {
                    if(formKey.currentState!.validate()){
login(context);
                    }
                    
                  }, child: Text('Login')),
                  TextButton(onPressed: () {
            
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>Register()));
                  }, child: Text('Already a user? Signup')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
