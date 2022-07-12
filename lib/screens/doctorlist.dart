import 'dart:convert';

import 'package:cough_detection/constants/constant.dart';
import 'package:cough_detection/screens/appoinment.dart';
import 'package:cough_detection/models/doctor.dart';
import 'package:cough_detection/screens/chatwithdoctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';

class DoctorList extends StatelessWidget {
  DoctorList({Key? key}) : super(key: key);

  Future<List<Doctor>> getDocs() async {
    Response res = await get(Uri.parse(Constant.baseUrl + 'doctor_list'));
    print(res.body);
    List data = jsonDecode(res.body);
    return data.map((e) => Doctor.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [], title: Text('Doctorlist')),
        body: FutureBuilder(
            future: getDocs(),
            builder: (context, AsyncSnapshot<List<Doctor>> snap) {
              if (!snap.hasData) {
                return CircularProgressIndicator();
              } else {
                return ListView.builder(
                    itemCount: snap.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: ListTile(
                        leading: CircleAvatar(
                            backgroundImage: NetworkImage(Constant.baseUrl +
                                snap.data![index].image.replaceFirst('/', ''))),
                        trailing:
                            Row(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (conext) => Appoinment(id: snap.data![index].id.toString(),name:snap.data![index].name )));
                              },
                              icon: Icon(Icons.free_cancellation)),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (conext) => chatwithdoctor()));
                              },
                              icon: Icon(Icons.chat))
                        ]),
                        title: Text(snap.data![index].name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(snap.data![index].speacialisation),
                            Text(snap.data![index].hospitalName)
                          ],
                        ),
                      ));
                    });
              }
            }));
  }
}
