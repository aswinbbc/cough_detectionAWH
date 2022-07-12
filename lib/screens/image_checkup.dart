import 'dart:convert';
import 'dart:io';

import 'package:cough_detection/services/checkup.dart';
import 'package:cough_detection/widgets/image_selector.dart';
import 'package:flutter/material.dart';

class ImageCheckUp extends StatefulWidget {
  const ImageCheckUp({Key? key}) : super(key: key);

  @override
  State<ImageCheckUp> createState() => _ImageCheckUpState();
}

class _ImageCheckUpState extends State<ImageCheckUp> {
  late File imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("Click image to choose X-RAY image",
            style: TextStyle(fontSize: 20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // RotatedBox(
            //   quarterTurns: 3,
            //   child: Text("Click image to choose X-RAY image"),
            // ),
            ImageSelector(
              imageData: (pickedImageFile) {
                imageFile = pickedImageFile;
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    var data =
                        await CheckUp().FlaskUpload(imageFile, "predict");
                    showAlertDialog(
                      context,
                      "${jsonDecode(data)['class']}\n ${(jsonDecode(data)['confidence'] * 100)}%",
                    );
                  },
                  child: const Text("CheckUp"),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  showAlertDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("result"),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
