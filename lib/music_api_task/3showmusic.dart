import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:music_api/music_api_task/2class.dart';
import 'package:http/http.dart' as http;

class dataview extends StatefulWidget {
  const dataview({super.key});


  @override
  State<dataview> createState() => _dataviewState();
}

class _dataviewState extends State<dataview> {

  AudioPlayer player = AudioPlayer();

  // List<> song_list=List[];
  bool isplay=false;
  int cur_ind=0;
  double duration=0.0;

  @override
  Widget build(BuildContext context) {
    catalog c=ModalRoute.of(context)!.settings.arguments as catalog;
    Future getdata()
    async {
      var url = Uri.https('storage.googleapis.com','uamp/catalog.json/${c.id}');
      var response = await http.get(url);

      Map m=jsonDecode(response.body);
      // print(m);
      return m;
    }

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,title: Text("${c.artist}"),),
      body: Container(
        color: Colors.blueGrey,
        child: Column(children: [
          SizedBox(height: 20,),
          Expanded(child: Container(
            child: Text(""),
          )),
           Container(
            height: 300,
            width: 300,
            color: Colors.black,
            child: Container(
              height: 200,
              width: 200,
              child: Image(fit: BoxFit.fill,image: NetworkImage("${c.image}")),
            ),
          ),
          Expanded(child: Container(
            alignment: Alignment.center,
            child: Text("   ${c.title} \n ${c.artist}" ),
          )),
          Expanded(child: Container(
            alignment: Alignment.center,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.white,trackHeight: 3,
                thumbColor: Colors.white,
                inactiveTrackColor: Colors.black
                // thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                // overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
              ),
              child:
              Slider(
                min: 0,
                max: 80000,
                value: duration, onChanged: (value) {
                player.onPositionChanged.listen((Duration d) {
                  duration=value;
                  duration=d.inMilliseconds.toDouble();
                  // print("duration=${duration}");
                  setState(() {

                  });
                });

              },
              ),
            ),
          )),
          Row(children: [
            Expanded(child: Container(
              margin: EdgeInsets.only(left: 30),
              child: Text("${c.duration}"),
            )),
            Expanded(child: Container(
              margin: EdgeInsets.only(left: 120),
              child: Text("${duration}"),
            )),
          ],),
          Expanded(child: Container(
            child: Row(children: [
              Expanded(child: CircleAvatar(
                child: IconButton(onPressed: () {
                  if(cur_ind>0)
                  {
                    cur_ind--;
                    isplay=true;
                    player.play(
                      DeviceFileSource("${c.source}"),
                    );
                    setState(() {

                    });
                  }
                }, icon: Icon(Icons.skip_previous)),
              )),
              Expanded(child: CircleAvatar(
                  child: (isplay) ? IconButton(onPressed: () {
                    player.pause();
                    isplay=!isplay;
                    setState(() {

                    });
                  }, icon: Icon(Icons.pause)):
                  IconButton(onPressed: () {
                    isplay=!isplay;
                    player.play(
                      DeviceFileSource("${c.source}"),
                    );
                    setState(() {

                    });
                  }, icon: Icon(Icons.play_arrow))
              )),
              Expanded(child: CircleAvatar(
                child: IconButton(onPressed: () {

                }, icon: Icon(Icons.skip_next)),
              ))
            ]),
          )),
          Expanded(child: Container(
            child: TextButton(onPressed: () {
              //You can download a single file
              FileDownloader.downloadFile(
                  url: "${c.source}",
                  name: "THE FILE NAME AFTER DOWNLOADING",//(optional)
                  // onProgress: (String fileName, double progress) {
                  //   print('FILE fileName HAS PROGRESS $progress');
                  // },
                  onDownloadCompleted: (String path) {
                    print('FILE DOWNLOADED TO PATH: $path');
                  },
                  onDownloadError: (String error) {
                    print('DOWNLOAD ERROR: $error');
                  });
            }, child: Text("Download",style: TextStyle(color: Colors.black),),),
          )),
        ]),
      )
    );
  }
}
