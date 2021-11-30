// ignore: file_names
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../NewsModel.dart';

class newsServices {
  static var api = Uri.parse(
      "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=233378884c9343a7ba15aeac2d5c4f0b");
  static var newsModel;

  static Future<List<NewsModel>> getNews() async {
    try {
      var response = await http.get(api);
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        newsModel = newsModelFromJson(decode);
        return newsModel;
      } else {
        return <NewsModel>[];
      }
    } catch (error) {
      return <NewsModel>[];
    }
  }
}
