import 'package:api_practice/Model/user_model.dart';
import 'package:http/http.dart' as http;

class Services {
  static var api = Uri.parse("https://jsonplaceholder.typicode.com/users");
  static Future<List<Users>> getUsers() async {
    try {
      var response = await http.get(api);
      if (response.statusCode == 200) {
        final List<Users> users = usersFromJson(response.body);
        return users;
      } else {
        return <Users>[];
      }
    } catch (error) {
      return <Users>[];
    }
  }
}
