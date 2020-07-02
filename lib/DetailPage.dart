import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:foodapp/Model/DetailModel.dart';
import 'package:foodapp/Repository/DetailRepo.dart';

class DetailPages extends StatefulWidget {
  final id;
  final title;

  DetailPages({this.id, this.title});

  @override
  _DetailPagesState createState() => _DetailPagesState();
}

class _DetailPagesState extends State<DetailPages> {
  List<DetailModel> list_data;

  Future<String> getData() async {
    list_data = await DetailRepo().getData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _loadData(),
    );
  }

  Widget _loadData() {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error'),
            );
          } else if (snapshot.hasData == null) {
            return Center(
              child: Text('Tidak Ada Data'),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.none) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return _listData();
          }
        });
  }

  Widget _listData() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: list_data.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: new EdgeInsets.only(bottom: 12.0),
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(list_data[index].strMealThumb))),
              ),
              ListTile(
                leading: SizedBox(
                  height: 60,
                  width: 60,
                  child: Stack(
                    children: [
                      new GestureDetector(
                        onTap: () {
                          if (list_data[index].strYoutube != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => VideoPlay(
                                  url: list_data[index].strYoutube,
                                )));
                          }
                        },
                        child: Container(
                          child: Center(
                            child: list_data[index].strYoutube == null
                                ? null
                                : Icon(
                              Icons.play_arrow,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      list_data[index].strMealThumb))),
                        ),
                      )
                    ],
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text(
                      "Category : ",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      list_data[index].strCategory,
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.w400),
                    ),
                    Container(
                      height: 2,
                    ),
                    Text(
                      "Regional Food : ",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      list_data[index].strArea,
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: SizedBox(
                  height: 60,
                  width: 60,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                            image: AssetImage('assets/recipes.png'))),
                  ),
                ),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ingredient : ",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w900),
                        ),
                        Text(
                          list_data[index].strIngredient1 +
                              "\n" +
                              list_data[index].strIngredient2 +
                              "\n" +
                              list_data[index].strIngredient3 +
                              "\n" +
                              list_data[index].strIngredient4 +
                              "\n" +
                              list_data[index].strIngredient5,
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    Container(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Measures : ",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w900),
                        ),
                        Text(
                          list_data[index].strMeasure1 +
                              "\n" +
                              list_data[index].strMeasure2 +
                              "\n" +
                              list_data[index].strMeasure3 +
                              "\n" +
                              list_data[index].strMeasure4 +
                              "\n" +
                              list_data[index].strMeasure5,
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: new EdgeInsets.fromLTRB(8.0, 6.0, 0.0, 2.0),
                child: Text(
                  "Instructions : ",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w900),
                ),
              ),
              Container(
                margin: new EdgeInsets.only(left: 8.0),
                child: Text(
                  list_data[index].strInstructions,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          );
        });
  }
}

class VideoPlay extends StatelessWidget {
  final url;

  VideoPlay({this.url});

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new WebviewScaffold(url: url),
    );
  }
}
