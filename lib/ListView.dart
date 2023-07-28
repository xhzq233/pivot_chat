import 'package:flutter/material.dart';
import 'package:pivot_chat/widgets/button/_PCHomePageButton.dart';

class test extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){},
              icon: Icon(ItyingFont.icon1,
              color: Colors.pinkAccent,
              ),
            ),
          ),
          body: ListView(

            children: [
              ListTile(
                leading: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.home,
                  color: Colors.green,),
                ),
                title: Text("this is a title"),
                subtitle: Text("what are you doing",
                ),
                trailing: Icon(ItyingFont.icon3),
              ),
              Divider(),
              ListTile(
                leading: Icon(ItyingFont.icon1,
                color: Colors.amber,),
                title: Text("screen"),),
              Divider(),
              ListTile(
                leading: Icon(ItyingFont.icon2,
                color: Colors.blue,),
                title: Text("lala"),

              ),
              Divider(),
              ListTile(
                leading: Icon(ItyingFont.icon3,
                color: Colors.amberAccent,),
                title: Text("dart"),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.home,
                color: Colors.green,),
                title: Text("java"),
                
              ),
              Divider(),
              ListTile(
                leading:Image.network("https://th.bing.com/th/id/R.84dbeedae8c4a4200a94f26da30a2179?rik=IrmYiODcJ5swYA&riu=http%3a%2f%2fd.paper.i4.cn%2fmax%2f2016%2f12%2f02%2f10%2f1480645225499_464906.jpg&ehk=1wGgzhGo8cFwOCAapVbyWhd9T0rxrp4GtJYRb7WypoY%3d&risl=&pid=ImgRaw&r=0",
                width: 100.0,
                  height: 100.0,
                ) ,
                title: Text("海绵宝宝最近很开心"),
                subtitle: Text("为什么呢，因为今天是星期六，不用上班呀"),
              ),
              Divider(),
              ListTile(
                leading: Image.network("https://th.bing.com/th/id/OIP.ZEi_9tjnaj2OSwQG_VXmVwAAAA?pid=ImgDet&w=199&h=261&c=7&dpr=1.3",
                width: 100.0,
                  height: 100.0,
                ),
                title: Text("海绵宝宝最近很难过"),
                subtitle: Text("今天又要加班啦"),
              )

            ],
          ),
        ),

    );
  }

}