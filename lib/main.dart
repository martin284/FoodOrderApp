import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_t6est/widgets/CustomItemBuilder.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'item.dart';
import 'model.dart';

List<Model> modelList = List<Model>();

Future<List<Model>> readModelListFromFile() async {
  WidgetsFlutterBinding.ensureInitialized();
  String jsonString = await rootBundle.loadString('assets/models.json');
  List dynList = jsonDecode(jsonString);

  dynList.forEach((element) {
    Model model = Model.fromJson(element);
    modelList.add(model);
  });

  return modelList;
}

void main() async {
  modelList = await readModelListFromFile();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double width;
  double height;
  String category;
  Model currentModel = modelList[0];

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 26,
          ),
          Container(
              color: Colors.grey[200],
              height: height - 26,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: ListView.builder(
                          itemCount: modelList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return buildCategory(
                                modelList[index].category, index, modelList[index].imageUrl);
                          })),
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                      flex: 3,
                      child: GridView.builder(
                          itemCount: currentModel.items.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (BuildContext context, int index) {
                            String name = currentModel.items[index].name;
                            String url = currentModel.items[index].imageUrl;
                            return CustomItemBuilder(name, url);
                          })),
                ],
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildCategory(String name, int index, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            currentModel = modelList[index];
          });
        },
        child: Container(
          color: Colors.white,
          width: width / 6,
          height: width / 6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image(
                image: NetworkImage(imageUrl),
                width: width / 12,
                height: width / 12,
              ),
              Text(name),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(String name, String url) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          width: width / 3,
          height: width / 3,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image(
                  image: NetworkImage(url),
                  width: width / 6,
                  height: width / 6,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(name),
              ]),
        ),
        Container(
          width: width / 3,
          height: width / 3,
          child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("2",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.red)),
              )),
        )
      ],
    );
  }
}
