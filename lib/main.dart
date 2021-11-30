import 'package:api_practice/Model/NewsModel.dart';
import 'package:api_practice/Model/Services/news_service.dart';
import 'package:api_practice/Model/Services/services.dart';
import 'package:api_practice/Model/product_model.dart';
import 'package:api_practice/Model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:api_practice/Model/NewsModel.dart';
import 'package:api_practice/Model/Services/product_service.dart';

void main(List<String> args) {
  runApp(MaterialApp(home: practice_json()));
}

class practice_json extends StatefulWidget {
  const practice_json({Key? key}) : super(key: key);

  @override
  _practice_jsonState createState() => _practice_jsonState();
}

class _practice_jsonState extends State<practice_json> {
  List<Users> _users = [];
  late Future<List<Users>> services;

  List<NewsModel> _news = [];
  late Future<List<NewsModel>> newsService;

  late bool loading;

  List<product_model> _product = [];
  late Future<product_model> _productServices;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = true;

//-------------------------------------------
//             Product Widget
//-------------------------------------------

    _productServices = product_service.getProduct().then((value) {
      setState(() {
        _product = value;
        loading = false;
      });
      return _product;
    });

//-------------------------------------------
//             News Widget
//-------------------------------------------
    newsService = newsServices.getNews().then((value) {
      setState(() {
        _news = value;
        loading = false;
        //print(_news);
      });
      return _news;
    });
    //-------------------------------------------
    //             User Widget
    //-------------------------------------------
    services = Services.getUsers().then((value) {
      setState(() {
        _users = value;
        loading = false;
        //print(_users);
      });
      return _users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(loading ? "Loading" : "Users"),
        ),
        body: Container(child: product_widget()));
  }
//-------------------------------------------
//             Product Widget
//-------------------------------------------

  Widget product_widget() {
    return FutureBuilder(
        future: _productServices,
        builder: (context, AsyncSnapshot<product_model> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.data.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.data[index];

                  return ListTile(title: Text(data.name));
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  //-------------------------------------------
  //             News Widget
  //-------------------------------------------

  Widget news_widget() {
    return FutureBuilder<NewsModel>(
        //future: newsService,
        builder: (context, snapshot) {
      return ListView.builder(
          itemCount: null == _news ? 0 : _news.length,
          itemBuilder: (context, index) {
            var news = snapshot.data!.articles[index];
            print("Json Parse Complete");
            return ListTile(
              title: Text(news.title),
            );
          });
    });
  }

  //-------------------------------------------
  //             User Widget
  //-------------------------------------------

  Widget user_widget() {
    return FutureBuilder(
        future: services,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: null == _users ? 0 : _users.length,
                itemBuilder: (context, index) {
                  Users user = _users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(user.id.toString()),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.address.geo.lat),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
