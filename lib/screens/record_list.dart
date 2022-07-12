import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cough_detection/services/checkup.dart';
import 'package:flutter/material.dart';

class RecordList extends StatefulWidget {
  const RecordList({Key? key}) : super(key: key);

  @override
  _RecordListState createState() => _RecordListState();
}

class _RecordListState extends State<RecordList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REC List"),
        elevation: 0,
      ),
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: FutureBuilder(
            future: CheckUp().allResult(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: Text('Loading....'));
                default:
                  if (snapshot.hasError)
                    return Center(child: Text('Error: ${snapshot.error}'));
                  else {
                    final list = snapshot.data ?? [];
                    return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, i) {
                          return Card(
                            child: ListTile(
                              onTap: () {
                                startPlaying(list.elementAt(i)['file']);
                              },
                              leading: CircleAvatar(
                                  child: Icon(
                                Icons.play_arrow,
                                color: Colors.blue,
                              )),
                              title: Text(list.elementAt(i)['file']),
                              subtitle: Text(list.elementAt(i)['result']),
                            ),
                          );
                        });
                  }
              }
            }),
      ),
    );
  }

  final audioPlayer = AssetsAudioPlayer();
  Future<void> startPlaying(String filePath) async {
    /// '/sdcard/Download/temp.wav'
    audioPlayer.open(
      Audio.file(filePath),
      autoStart: true,
      showNotification: true,
    );
  }
}
