import 'package:flutter/material.dart';
import 'package:foodapp/DescriptionPage.dart';
import 'package:foodapp/FoodPage.dart';
import 'package:foodapp/Model/CategoryModel.dart';
import 'package:foodapp/Repository/CategoryRepo.dart';

class HomePages extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {

  List<CategoryModel> list_data;
  final TextEditingController _controller = new TextEditingController();

  Future<String> getData() async {
    list_data = await CategoryRepo().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Category'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.info_outline),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => DescriptionPage()))),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Column(
          children: [
            _search(),
            Flexible(child: _loadData()),
          ],
        ),
      ),
    );
  }

  Widget _search() {
    return Container(
      margin: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: new EdgeInsets.only(left: 8, right: 8),
            child: new TextField(
              controller: _controller,
              onSubmitted: (_controller) {
                setState(() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FoodPages(
                        cat: "",
                        search: _controller,
                      )));
                });
              },
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: _controller.text == ""
                      ? null
                      : IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _controller.clear();
                          _loadData();
                        });
                      }),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: 'Food Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0))),
            ),
          )
        ],
      ),
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
            child: Text("Tidak Ada Data"),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return _listData();
        }
      },
    );
  }

  Widget _listData() {
    return Container(
        child: GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: list_data.length,
            shrinkWrap: true,
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  String cat = list_data[index].strCategory;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FoodPages(
                        cat: cat,
                        search: "",
                      )));
                },
                child: new Container(
                  margin: new EdgeInsets.all(10.0),
                  padding: new EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        new BoxShadow(color: Colors.black38, blurRadius: 2.0)
                      ]),
                  child: Column(
                    children: [
                      Flexible(
                        child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        list_data[index].strCategoryThumb)))),
                      ),
                      Text(list_data[index].strCategory)
                    ],
                  ),
                ),
              );
            }));
  }
}
