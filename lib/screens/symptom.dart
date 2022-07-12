import 'package:cough_detection/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Symptom extends StatelessWidget {
  const Symptom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(actions: [], title: Text('Adding Symptom')),
        body: Column(
          children: [
            Stack(children: [Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 60, vertical: deviceHeight * .01),
                      child: TextFormField(maxLines: 50,minLines: 10,
                            
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              label: Text('adding symptoms'))),
                    ),
              
                
           ], ),ElevatedButton(onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>home()));
                    }, child: Text('Submit')),
            ]),
                  );
        
  }
}