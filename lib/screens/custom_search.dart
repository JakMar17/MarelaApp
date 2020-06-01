import 'package:flutter/material.dart';
import 'package:vreme/data/postaja.dart';
import 'package:vreme/data/rest_api.dart';
import 'package:vreme/data/vodotok_postaja.dart';
import 'package:vreme/style/custom_icons.dart';

class CustomSearch extends StatefulWidget {
  @override
  _CustomSearchState createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  TextEditingController _textController = TextEditingController();

  List<SearchCategory> categories = [
    SearchCategory(title: "Vremenske postaje"),
    SearchCategory(title: "Vodotoki")
  ];

  RestApi restApi = RestApi();
  List<Postaja> vremenskePostaje;
  List<MerilnoMestoVodotok> vodotoki;

  List<ResultElement> show;

  @override
  void initState() {
    super.initState();
    show = [];
    vremenskePostaje = restApi.getAvtomatskePostaje();
    vodotoki = restApi.getVodotoki();
  }

  @override
  Widget build(BuildContext context) {
    
    search(_textController.text);

    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [CustomColors.blue, CustomColors.blue2],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: CustomColors.lightGrey),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Flexible(
                              flex: 10,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: TextField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Išči in najdi",
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Montserrat"),
                                    labelStyle: TextStyle(color: Colors.white),
                                    counterStyle:
                                        TextStyle(color: Colors.white),
                                  ),
                                  controller: _textController,
                                  onChanged: (String value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _textController.clear();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return _buildInputChip(categories[index]);
                          }),
                    ),
                    Expanded(
                        child: Container(
                            width: double.infinity,
                            child: show != null
                                ? _buildSearchResultsList(show)
                                : Container()))
                  ],
                ),
              ),
            )));
  }

  Widget _buildInputChip(SearchCategory cat) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: InputChip(
          backgroundColor: CustomColors.lightGrey,
          avatar: CircleAvatar(
            backgroundColor: CustomColors.blue2,
            child: cat.searchingIn
                ? Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : null,
          ),
          label: Text(
            cat.title,
            style: TextStyle(color: Colors.white, fontFamily: "Montserrat"),
          ),
          onPressed: () {
            setState(() {
              print(_textController.text);
              cat.searchingIn = !cat.searchingIn;
            });
          }),
    );
  }

  void search(String searchString) {
    show = [];

    if(searchString.length == 0)
      return;

    searchString = searchString.toUpperCase();

    bool showPostaje = categories[0].searchingIn;
    bool showVodotoki = categories[1].searchingIn;
    bool first = true;

    if (showPostaje)
      for (Postaja p in vremenskePostaje) {
        if (p.titleLong.toUpperCase().contains(searchString)) {
          if (first) {
            show.add(
                ResultElement(categoryTitle: true, title: "Vremenske postaje"));
            first = false;
          }

          show.add(ResultElement(
              title: p.titleLong,
              url: () {
                Navigator.pushNamed(context, '/postaja',
                    arguments: {"postaja": p});
              },
              id: p.id));
        }
      }
    first = true;

    if (showVodotoki)
      for (MerilnoMestoVodotok v in vodotoki) {
        if (v.reka.toUpperCase().contains(searchString) ||
            v.merilnoMesto.toUpperCase().contains(searchString)) {
          if (first) {
            show.add(ResultElement(categoryTitle: true, title: "Vodotoki"));
            first = false;
          }

          show.add(ResultElement(
              categoryTitle: false,
              title: "${v.merilnoMesto} - ${v.reka}",
              url: () {
                Navigator.pushNamed(context, '/vodotok',
                    arguments: {"vodotok": v});
              },
              id: v.id));
        }
      }
  }

  Widget _buildSearchResultsList(List<ResultElement> list) {

    if (list == null) return Container();
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          if (list[index].categoryTitle) {
            double paddingTop = 0;
            if (index != 0) paddingTop = 15;

            return Padding(
              padding: EdgeInsets.only(top: paddingTop, bottom: 15),
              child: Text(list[index].title,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat",
                      fontSize: 32,
                      fontWeight: FontWeight.w200)),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: RaisedButton(
                color: Colors.transparent,
                onPressed: () {
                  list[index].url();
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                                              child: Text(
                          list[index].title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}

class SearchCategory {
  String title;
  bool searchingIn = true;

  SearchCategory({this.title});
}

class ResultElement {
  bool categoryTitle = false;
  String id;
  var url;
  String title;

  ResultElement({this.categoryTitle, this.id, this.url, this.title}) {
    if (categoryTitle == null) categoryTitle = false;
  }
}
