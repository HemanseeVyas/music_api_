import 'package:flutter/material.dart';
import 'package:music_api/sharedprefrence_interview_task/1add.dart';
class views extends StatefulWidget {


  @override
  State<views> createState() => _viewsState();
}

class _viewsState extends State<views> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }
  dynamic items;

  int count=0;

  dynamic s1=[];
  get()
  async {
    count=one.prefs!.getInt("count") ?? 0;


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(" view")),
        body:
        FutureBuilder(future: get(), builder: (context, snapshot) {
          // s1 = snapshot as List;
          return  ListView.builder(itemCount: count,itemBuilder: (context, index) {
            List<String>? l=one.prefs!.getStringList("user$index");
            return Card(
              child: ListTile(
                title: Text("${l![0]}"),
                subtitle: Text("${l[1]}"),

              ),
            );
          },);
        },)
      // ElevatedButton(onPressed: () {}, child: Text("Delet")),
      // ElevatedButton(onPressed: () {}, child: Text("update")),

    );
  }
}