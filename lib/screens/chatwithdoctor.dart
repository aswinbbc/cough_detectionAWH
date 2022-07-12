

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class chatwithdoctor extends StatelessWidget {
  const chatwithdoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [],
          title: Text('Messages')),
     body: Column(mainAxisAlignment: MainAxisAlignment.end,
        children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(width: 330,
                child: TextField( decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40)),
                                  label: Text('Text message')),
                
                ),
              ),
             
            ),
             IconButton(onPressed: (){}, icon:Icon(Icons.send))
          ],
        ),
        
      ],),
    );
    
    
  }
  
}
