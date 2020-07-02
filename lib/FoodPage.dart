import 'package:flutter/material.dart';
import 'package:foodapp/DetailPage.dart';
import 'package:foodapp/HomePage.dart';
import 'package:foodapp/Model/FoodModel.dart';
import 'package:foodapp/Repository/FoodRepo.dart';

class FoodPages extends StatefulWidget {
  final cat;
  final search;

  FoodPages({this.cat, this.search});

  @override
  _FoodPagesState createState() => _FoodPagesState();
}

class _FoodPagesState extends State<FoodPages> {

  List<FoodModel> list_data;
  final TextEditingController _controller = new TextEditingController();

  Future<String> getData() async {
    print("category " + widget.cat);
    list_data = await FoodRepo().getData(widget.cat, widget.search);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePages()))),
            widget.search == ""
                ? Text('List By Category',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500))
                : Text('List By Search',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
      body: Column(
        children: [
          _search(),
          Flexible(child: _loadData()),
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
            child: Text("Tidak Ada Data"),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.none) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return _listData();
        }
      },
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
                          widget.search == _controller.text;
                          _controller.clear();
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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailPages(
                    id: list_data[index].idMeal,
                    title: list_data[index].strMeal,
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
                                    list_data[index].strMealThumb)))),
                  ),
                  Container(
                    margin: new EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: Text(list_data[index].strMeal),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
