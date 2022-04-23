import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:depositpage/DataClass.dart';


class api_utils {
  static const baseURL = 'https://ixtokens.com/';

// static const baseURL = 'https://spiegeltechnologies.org/iosmdex/';

//TODO verify EMailregister
 static const String verifyRegisterURL = baseURL + 'deposit_web';

  Future<DataClass> getSpinner(String user_id) async {
    var bodyData = {
      'user_id': user_id,
    };
    final response =
    await http.post(Uri.parse(verifyRegisterURL), body: bodyData);

    if (response.statusCode == 200 || response.statusCode == 401) {
      return DataClass.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}