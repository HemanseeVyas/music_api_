import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '2class.dart';
import '3showmusic.dart';

void main()
{
  runApp(MaterialApp(debugShowCheckedModeBanner: false,
    routes: {
      "detail" :(context) => musicdata(),
      "first":(context) => dataview(),
    },
    initialRoute: "detail",
  ));
}
class musicdata extends StatefulWidget {
  const musicdata({super.key});

  @override
  State<musicdata> createState() => _musicdataState();
}

class _musicdataState extends State<musicdata> {


  Future getdata()
  async {
    var url = Uri.https('storage.googleapis.com','uamp/catalog.json');
    var response = await http.get(url);

    Map m=jsonDecode(response.body);
    // print(m);
    return m;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.grey,
        title: Text("Music History...."),),
      body: FutureBuilder(future: getdata(),
        builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting)
                {
                              return Center(
                                child:  CircularProgressIndicator(),
                              );
                }
              else
                {
                     if(snapshot.hasData)
                       {
                           Map m=snapshot.data;
                            List l=m['music'];
                            return ListView.builder(
                              itemCount: l.length,
                              itemBuilder: (context, index) {
                                catalog c=catalog.fromJson(l[index]);
                                    return Card(color: Colors.blueGrey,
                                      child: ListTile(onTap: () {
                                        Navigator.pushNamed(context, "first", arguments: c,);
                                      },
                                        title: Text("${c.title}"),
                                        subtitle: Text("${c.artist}"),
                                        leading: Container(
                                          height: 60,
                                          width: 60,
                                          child: Image(image: NetworkImage("${c.image}")),
                                        )
                                        // CircleAvatar(backgroundImage: NetworkImage("${c.image}",),),
                                      ),
                                    );
                            },);
                       }
                     else
                       {
                             return Center(
                               child:  CircularProgressIndicator(),
                             );
                       }
                }
      },),
    );
  }
}
