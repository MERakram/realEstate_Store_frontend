import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oued_kniss1/server/SharedPreferencesManager.dart';



class Api {
  final String _baseUrl = 'http://10.0.2.2:8000';
  //if you are using android studio emulator, change localhost to 10.0.2.2
  var token;

  postData(data, apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    token = await SharedPreferencesManager().getAuthToken();
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  // postFormData(data, apiUrl) async {
  //   var fullUrl = _baseUrl + apiUrl;
  //   token = await SharedPreferencesManager().getAuthToken();
  //   return await http.post(Uri.parse(fullUrl),
  //       body: data, headers: _setFormHeaders());
  // }

  getData(apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
     token = await SharedPreferencesManager().getAuthToken();
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }
  deleteData(apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    token = await SharedPreferencesManager().getAuthToken();
    return await http.delete(Uri.parse(fullUrl), headers: _setHeaders());
  }
  patchData(data, apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    token = await SharedPreferencesManager().getAuthToken();
    return await http.patch(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }
  // postDataWithImage(data, apiUrl, filepath) async {
  //   var fullUrl = _baseUrl + apiUrl;
  //   //token = await SharedPreferencesManager().getAuthToken();
  //   Map<String, String> headers = {
  //     'Content-Type': 'multipart/form-data',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse(fullUrl))
  //     ..fields.addAll(data)
  //     ..headers.addAll(headers)
  //     ..files.add(await http.MultipartFile.fromPath('image', filepath));
  //   return await request.send();
  // }

  // String getOfferImageUrl(id) {
  //   return _baseUrl + '/images/meal/$id';
  // }

  _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization':'JWT $token'
  };
    // _setFormHeaders() => {
    //   'Content-type': 'application/x-www-form-urlencoded',
    //   'Accept': 'application/json',
    //   'Authorization': 'JWT $token'
    // };
}
