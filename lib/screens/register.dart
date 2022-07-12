import 'dart:convert';
import 'dart:io';

import 'package:cough_detection/constants/constant.dart';
import 'package:cough_detection/screens/login.dart';
// import 'package:cough_detection/screens/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var nameController = TextEditingController();

  var ageController = TextEditingController();

  var addressController = TextEditingController();

  var heightController = TextEditingController();

  var weightController = TextEditingController();

  var phonenumberController = TextEditingController();

  var emailtController = TextEditingController();

  var usernameController = TextEditingController();

  var password1Controller = TextEditingController();

  var confirmpassController = TextEditingController();

  var selectedimage;

  register() async {
    print('running');
    final res = await post(Uri.parse(Constant.baseUrl + 'user_reg'), body: {
      'username': usernameController.text,
      'password1': password1Controller.text,
      'password2': confirmpassController.text,
      'name': nameController.text,
      'age': ageController.text,
      'address': addressController.text,
      'height': heightController.text,
      'weight': weightController.text,
      'phone_number': phonenumberController.text,
      'email': emailtController.text,
    });
    print('sent');
    print(res.body);
    final data=jsonDecode(res.body);
    if (data['result'] == true) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: ((context) => Login())));
    }else{
    showDialog(context: context, builder: (context){return AlertDialog(
      title: Text('Something wrong'),
      content: Text(data['errors']),
    );});
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      'https://t4.ftcdn.net/jpg/04/94/11/55/240_F_494115536_vGP855wP8ul4nX67mCwOBUJfFgG2EHCA.jpg',
                    ),
                    fit: BoxFit.fill)),
            height: double.infinity,
            width: double.infinity,
          ),
          Form(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 60, vertical: deviceHeight * .01),
                      child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'field is empty';
                            } else if (value.length < 8) {}
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              label: Text('name'))),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 60, vertical: deviceHeight * .01),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: ageController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40)),
                            label: Text('Age')),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 60, vertical: deviceHeight * .01),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 3,
                        maxLines: 3,
                        controller: addressController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40)),
                            label: Text('Address')),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 60, vertical: deviceHeight * .01),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: heightController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40)),
                            label: Text('Height')),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 60, vertical: deviceHeight * .01),
                      child: TextFormField(
                        controller: weightController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40)),
                            label: Text('Weight')),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 60, vertical: deviceHeight * .01),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phonenumberController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40)),
                            label: Text('Phone Number')),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 60, vertical: deviceHeight * .01),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailtController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40)),
                            label: Text('E-mail')),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 60, vertical: deviceHeight * .01),
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 60, vertical: deviceHeight * .01),
                      child: TextFormField(
                        controller: password1Controller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40)),
                            label: Text(' Password')),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 60, vertical: deviceHeight * .01),
                      child: TextFormField(
                        controller: confirmpassController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40)),
                            label: Text(' confirm Password')),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          register();
                        },
                        child: Text('SIGN UP')),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
