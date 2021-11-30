import 'dart:convert';

import 'package:api_practice/Model/product_model.dart';
import 'package:http/http.dart' as http;

class product_service {
  static Future<List<product_model>> getProduct() async {
    var productModel;
    var api = Uri.parse("https://www.moharaj.com.bd/api/only/category");
    try {
      var response = await http.get(api);
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);

        productModel = productModelFromJson(decode);

        return productModel;
      } else {
        return productModel;
      }
    } catch (error) {
      return <product_model>[];
    }
  }
}
