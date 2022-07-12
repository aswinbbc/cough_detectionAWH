import 'dart:io';

// import 'package:cough_detection/chatwithdoctor.dart';
import 'package:cough_detection/screens/ViewPrescription.dart';
import 'package:cough_detection/screens/chatwithdoctor.dart';
import 'package:cough_detection/screens/doctorlist.dart';
import 'package:cough_detection/screens/image_checkup.dart';
import 'package:cough_detection/screens/login.dart';
import 'package:cough_detection/screens/record.dart';
import 'package:cough_detection/screens/symptom.dart';
// import 'package:cough_detection/screens/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home extends StatefulWidget {
  home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  var selectedimage;
  var selectedsound;

  getImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedimage = File(image!.path);
    });
  }

  getSound() async {
    final picker = await FilePicker.platform.pickFiles();
    var audioFile = File(picker!.files.single.path!);
  }

  // getSound() async {
  //   final picker = Fil
  //   final

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () async {
              final spref = await SharedPreferences.getInstance();
              spref.clear();
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return Login();
                },
              ));
            },
            icon: const Icon(Icons.logout_rounded))
      ]),
      body: Stack(alignment: Alignment.center, children: [
        Container(
          decoration: const BoxDecoration(
              image: const DecorationImage(
                  image: NetworkImage(
                    'https://t4.ftcdn.net/jpg/05/09/11/67/240_F_509116763_87h7Ai1PwUA985IaOPKTSZdWHBAxNF9z.jpg',
                  ),
                  fit: BoxFit.fill)),
          height: double.infinity,
          width: double.infinity,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //  Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            //   Container(
            //     child: TextButton(
            //       child: Text("Adding and symptom"),
            //       onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (conext)=>Symptom()));},
            //     ),
            //     decoration: BoxDecoration(
            //         color: Colors.green[50],
            //         borderRadius: BorderRadius.circular(10)),
            //     height: 80,
            //     width: 200,
            //   ),
            // ]),
            const SizedBox(
              height: 30,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(10)),
                height: 80,
                width: 200,
                child: TextButton(
                  child: const Text("upload cough sound"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Recorder(),
                        ));
                  },
                ),
              ),
            ]),
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(10)),
              height: 80,
              width: 200,
              child: TextButton(
                child: const Text("Upload X-ray image"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ImageCheckUp(),
                      ));
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            //   Container(
            //     child: TextButton(
            //       child: Text("Chat with Doctor"),
            //       onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context){return chatwithdoctor();},));},
            //     ),
            //     decoration: BoxDecoration(
            //         color: Colors.green[50],
            //         borderRadius: BorderRadius.circular(10)),
            //     height: 80,
            //     width: 200,
            //   ),
            // ]),
            const SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(10)),
                height: 80,
                width: 200,
                child: TextButton(
                  child: const Text("View Prescription"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const ViewPrescription();
                        },
                      ),
                    );
                  },
                ),
              ),
            ]),
            const SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(10)),
                height: 80,
                width: 200,
                child: TextButton(
                  child: const Text("DOCTOR"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (conext) => DoctorList()));
                  },
                ),
              ),
            ]),
          ],
        ),
      ]),
    );
  }
}
