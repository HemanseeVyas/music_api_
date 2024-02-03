import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '2view.dart';

void main(){
  runApp(MaterialApp(home: one(),debugShowCheckedModeBanner: false,));
}
class one extends StatefulWidget {

  static SharedPreferences ? prefs  ;
  static int count=0;

  @override
  State<one> createState() => _oneState();
}

class _oneState extends State<one> {

  TextEditingController name=TextEditingController();
  TextEditingController contact=TextEditingController();
  TextEditingController email=TextEditingController();
  int count=0;
  get() async {
    one.prefs = await SharedPreferences.getInstance();
    count=one.prefs!.getInt("count") ?? 0;
    // List<String>? items = one.prefs?.getStringList('stor');
    // print('$items');
  }
  @override
  void initState() {
    // TODO: implement initState
    get();

  }
  dynamic items;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("datils")),
      body: Column( children: [
        TextField(controller: name,decoration: InputDecoration(hintText: "name"),),
        TextField(controller: contact,decoration: InputDecoration(hintText: "conatct"),),
        TextField(controller: email,decoration: InputDecoration(hintText: "email"),),
        ElevatedButton(onPressed: () {
          // one.prefs?.setStringList("stor", <String>['${name.text}', '${contact.text}', '${email.text}']);
          //   count++;
          //   one.prefs!.setInt('index', count);
          //   one.prefs!.setString('name$count','${name.text}');
          //   one.prefs!.setString('email$count','${email.text}');
          //   one.prefs!.setString('contect$count','${contact.text}');
          // items = one.prefs?.getStringList('user');
          // items.length=0;
          // count=items;




          List<String> s=['${name.text}','${contact.text}','${email.text}'];

          one.prefs!.setStringList('user${count}', s);
          count++;
          one.prefs!.setInt("count", count);

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return views();
          },));
          setState(() {

          });
        }, child: Text("Submit")),
        ElevatedButton(onPressed: () {
          set();
        }, child: Text("View"))
      ]),
    );
  }
  void set()
  {
    int cnt=one.prefs!.getInt("count")?? 0;
    for(int i=0;i<cnt;i++)
    {
      List<String>? l=one.prefs!.getStringList("user$i") ;
      print(l);
    }
  }
}