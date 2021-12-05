import 'dart:convert';

import 'package:api_practice/Model/NewsModel.dart';
import 'package:api_practice/Model/Services/news_service.dart';
import 'package:api_practice/Model/Services/services.dart';
import 'package:api_practice/Model/product_model.dart';
import 'package:api_practice/Model/user_model.dart';
import 'package:flutter/material.dart';

import 'package:api_practice/Model/Services/product_service.dart';
import 'package:http/http.dart' as http;

void main(List<String> args) {
  runApp(MaterialApp(home: PracticeJson()));
}

class PracticeJson extends StatefulWidget {
  const PracticeJson({Key? key}) : super(key: key);

  @override
  _PracticeJsonState createState() => _PracticeJsonState();
}

class _PracticeJsonState extends State<PracticeJson> {
  late bool loading;

  List<Users> _users = [];
  late Future<List<Users>> services;

  List<NewsModel> _news = [];
  late Future<List<NewsModel>> newsService;

  Future<ProductModel>? product;

  @override
  void initState() {
    super.initState();
    loading = true;

//-------------------------------------------
//             Product Widget
//-------------------------------------------

    product = getproduct();

    // _productServices = getProduct().then((value) {
    //   setState(() {
    //     _product = value;
    //     loading = false;
    //   });
    //   print(_product);
    //   return _productServices;
    // });

    // getProduct().then((value) {
    //   setState(() {
    //     _productList = value;
    //     loading = false;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(loading ? "Loading" : "Users"),
        ),
        body: Container(
            child: FutureBuilder<ProductModel>(
                future: product,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.data.length,
                        itemBuilder: (context, index) {
                          //var image = _productList![index].productImage;
                          final product = snapshot.data!.data[index];

                          return ListTile(
                            // leading: CircleAvatar(
                            //   child:
                            //       Image.network(image.prefix_url + image.product_image),
                            // ),
                            title: Text(
                                product == null ? "coin name" : product.name),
                            //subtitle: Text(product.price),
                          );
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })));
  }
//-------------------------------------------
//             Product Widget
//-------------------------------------------

  // Future<ProductModel> getproduct() async {
  //   final url =
  //       Uri.parse("https://www.moharaj.com.bd/api/new/collection/products");
  //   final response = await http.get(url);
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     final decode = jsonDecode(response.body);
  //     print(decode);
  //     final product = ProductModel.fromJson(decode);
  //     //print(product);
  //     return product;
  //   } else {
  //     throw Exception();
  //   }
  // }

  Future<ProductModel> getproduct() async {
    var headers = {
      'email': 'moharaj@admin.com',
      'password': '12345678',
      'Content-Type': 'text/plain',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6IkhqUVNcL1FnNXlKQXJlb1Q2ZTVGeGVRPT0iLCJ2YWx1ZSI6Ik1cL01wRnpmR0hKMmZzbUVWZ3RNRGhUR3Myd1lYejV3TU1FeWN3T3FkOXlHSUxOQmRXWHdhT0dOMFl6eTZRYjlUIiwibWFjIjoiNWFhYzViMjQyNGYxNGZlNjRjYWJhMTlkODM5Y2YzMWJhZTgzOTU0YmM4NDcwN2QwOGZmOTE3NjVkMjlmZmI3MSJ9; laravel_session=eyJpdiI6IlhQQVZ1WDVDZ1pJNVNzWDQ3T24rMmc9PSIsInZhbHVlIjoiSFFobU5WM0w1cTFmNmZRS0M5MzBsZjBqMTUyd3BsSmlpQWd3N2xmb3VUWGtKVkYrZFk0eWJUalBLbUdVa0FZRiIsIm1hYyI6ImM3YWM4NGQwZTU1YTM4ZDViZWFkNzYyNTQ3ZDJhYTg0ZWJiZGJlYjg0MzdjOTQyYTM4ODJjZTkxZjNkNzFiYzQifQ%3D%3D'
    };
    var request = http.Request('GET',
        Uri.parse('https://www.moharaj.com.bd/api/new/collection/products'));
    request.body =
        '''{\r\n    "id": 54,\r\n"name": "Fahim",\r\n"email": "moharaj@admin.com",\r\n"password": "\$2y\$10\$pAlKE3Ez5cm7HsatQrCF6uXIdzvCNEuFKcPxlGrTBILsXkSAKYnxe",\r\n"remember_token": "",\r\n"status": 1,\r\n}''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      final decode = jsonDecode(request.body);
      final product = ProductModel.fromJson(decode);
      return product;
    } else {
      throw Exception();
      print(response.reasonPhrase);
    }
  }

  // Widget productWidget() {
  //   return FutureBuilder<NewProductModel>(
  //       future: _productServices,
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           return ListView.builder(
  //               itemCount: _productList!.length,
  //               itemBuilder: (context, index) {
  //                 var data = _productList![index];

  //                 return ListTile(title: Text(data.name));
  //               });
  //         } else {
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //       });
  // }

}
