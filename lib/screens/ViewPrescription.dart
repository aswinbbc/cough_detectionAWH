import 'package:flutter/material.dart';

class ViewPrescription extends StatelessWidget {
  const ViewPrescription({Key? key}) : super(key: key);

getPrescs()async{
  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [], title: Text('Prescription')),
        body: Stack(children: [
          Container(
            height: 600,
            width: 600,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/photo.jpg'),
                    )),
          ),
        ]));
  }
}
