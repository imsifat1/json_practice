// import 'dart:convert';

// import 'package:api_practice/Model/product_model.dart';
// import 'package:api_practice/main.dart';
// import 'package:http/http.dart' as http;

// Future<List<ProductModel>> getProduct() async {
//   Uri api = Uri.parse("https://www.moharaj.com.bd/api/new/collection/products");
//   List<ProductModel> newList;
//   try {
//     final response = await http.get(api);
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final decode = jsonDecode(response.body);
//       List productModel = decode["data"];
//       newList = productModel
//           .map((jsonData) => ProductModel.fromJson(jsonData))
//           .toList();

//       print(response.body);

//       return newList;
//     } else {
//       return <ProductModel>[];
//     }
//   } catch (e) {
//     return <ProductModel>[];
//   }
// }
