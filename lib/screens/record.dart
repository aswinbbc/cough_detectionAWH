import 'dart:async';
import 'dart:convert';

import 'dart:io';
import 'dart:math';

import 'package:cough_detection/screens/record_list.dart';
import 'package:cough_detection/services/checkup.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'image_checkup.dart';

class Recorder extends StatefulWidget {
  const Recorder({Key? key}) : super(key: key);

  @override
  _RecorderState createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  late FlutterSoundRecorder _myRecorder;
  final audioPlayer = AssetsAudioPlayer();
  late String filePath;
  bool _play = false;
  String _recorderTxt = '00:00:00';

  bool mode = false;

  Timer? _timer;
  var _start = "00:00";
  bool isStarted = false;
  int min = 0;
  int sec = 0;

  var checker = false;
  stopTimer() {
    setState(() {
      isStarted = true;
      _timer!.cancel();
    });
  }

  reset() {
    setState(() {
      _start = "00:00";
      isStarted = false;
      min = 0;
      sec = 0;
    });
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    if (!isStarted) {
      _timer = new Timer.periodic(
        oneSec,
        (Timer timer) {
          setState(() {
            if (sec == 60) {
              sec = 0;
              min++;
            }
            sec++;
            _start =
                "${min.toString().padLeft(2, '0')} : ${sec.toString().padLeft(2, '0')}";
          });
        },
      );
    }
    isStarted = !isStarted;
  }

  @override
  void dispose() {
    (_timer != null) ? _timer!.cancel() : "";
    super.dispose();
  }

  @override
  void initState() {
    startIt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Record"),
        actions: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecordList(),
                  ));
            },
            elevation: 0,
            child: const Icon(Icons.menu),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 30),
          color: Colors.blueGrey,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 200,
                    ),
                    Visibility(
                      child: const Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      )),
                      visible: checker,
                    ),
                    const Text(
                      "Press the mic button to start recording",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          reset();
                          checker = false;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.blueAccent)),
                        child: Text('$_start'),
                      ),
                    ),
                    const Text(
                      "Reload to click on timer",
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      heroTag: "stop",
                      onPressed: () {
                        pickFile();
                      },
                      child: const Icon(Icons.file_copy),
                    ),
                    // FloatingActionButton(
                    //   heroTag: "record",
                    //   onPressed: () {
                    //     if (!_play) {
                    //       record();
                    //     } else {
                    //       stopRecord();
                    //     }
                    //     _play = !_play;
                    //   },
                    //   child: !_play ? Icon(Icons.mic) : Icon(Icons.close),
                    // ),
                    FloatingActionButton(
                      heroTag: "send",
                      onPressed: () async {
                        setState(() {
                          checker = true;
                        });
                        reset();
                        var data =
                            await CheckUp().Upload(File(filePath), "home2");
                        // var json = jsonDecode(data);
                        var message = data;
                        print(message);

                        showAlertDialog(
                          context,
                          message,
                        );
                        await CheckUp()
                            .insert(filePath, message)
                            .then((value) => print(value));

                        setState(() {
                          checker = false;
                        });
                        if (message.contains("positive")) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ImageCheckUp(),
                              ));
                        }
                      },
                      child: const Icon(Icons.send),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);

      setState(() {
        filePath = file.path;
        _start = file.path;
      });
    } else {
      // User canceled the picker
    }
  }

  showAlertDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("result"),
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

  Future<void> record() async {
    startTimer();
    Directory dir = Directory(path.dirname(filePath));
    if (!dir.existsSync()) {
      dir.createSync();
    }
    _myRecorder.openRecorder();
    await _myRecorder.startRecorder(
      toFile: filePath,
      codec: Codec.pcm16WAV,
    );

    StreamSubscription _recorderSubscription =
        _myRecorder.onProgress!.listen((e) {
      var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds,
          isUtc: true);
      var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);

      setState(() {
        _recorderTxt = txt.substring(0, 8);
      });
    });
    _recorderSubscription.cancel();
  }

  Future<String?> stopRecord() async {
    stopTimer();
    _myRecorder.stopRecorder();
    return await _myRecorder.stopRecorder();
  }

  Future<void> startPlaying() async {
    audioPlayer.open(
      Audio.file(filePath),
      autoStart: true,
      showNotification: true,
    );
  }

  Future<void> stopPlaying() async {
    audioPlayer.stop();
  }

  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }

  void startIt() async {
    filePath =
        '/sdcard/Download/${DateTime.now().day}_${DateTime.now().hour}_${DateTime.now().minute}_${DateTime.now().second}.wav';
    print(filePath);

    ///sdcard/Download/24_18_47.wav
    _myRecorder = await FlutterSoundRecorder();

    await _myRecorder.openRecorder();
    await _myRecorder.setSubscriptionDuration(const Duration(milliseconds: 10));
    await initializeDateFormatting();

    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }
}
