import 'dart:convert';

import 'package:cough_detection/constants/constant.dart';
import 'package:cough_detection/models/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';

class Appoinment extends StatelessWidget {
  Appoinment({
    Key? key,
    required String this.name,
    required String this.id,
  }) : super(key: key);
  final String name;
  final String id;
  Future<List<Schedule>> getSchedules() async {
    Response res = await get(Uri.parse(Constant.baseUrl + 'schedule_list'));
    print('asfs ${res.body}');
    print('id $id');
    List data = (jsonDecode(res.body) as List)
        .where((element) => element['doctor'].toString() == id)
        .toList();
    print('data: $data');
    return data.map((e) => Schedule.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(actions: [], title: Text('Appoinment')),
      body: Column(
        children: [
          Text(name),
          // Text("User"),
          FutureBuilder(
              future: getSchedules(),
              builder: (context, AsyncSnapshot<List<Schedule>> snap) {
                print(' snap data ${snap.data}');
                if (snap.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (!snap.hasData) {
                  return Text('no schedules added');
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    // scrollDirection: Axis.horizontal,
                    itemCount: snap.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Chip(
                            label: Text(
                                '${snap.data![index].startTime} to ${snap.data![index].endTime}')),
                      );
                    },
                  );
                }
              }),
          ElevatedButton(onPressed: () {}, child: Text('BOOK')),
        ],
      ),
    );
  }
}
