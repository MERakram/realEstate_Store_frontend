import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oued_kniss1/server/SharedPreferencesManager.dart';



class Api {
  final String _baseUrl = 'http://10.0.2.2:8000';
  // for emulator
  // final String _baseUrl = 'http://127.0.0.1:8000';
  // for real device
  var token;

  postData(data, apiUrl,type) async {
    var fullUrl = _baseUrl + apiUrl;
    token = await SharedPreferencesManager().getAuthToken();
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders(type));
  }

  // postFormData(data, apiUrl) async {
  //   var fullUrl = _baseUrl + apiUrl;
  //   token = await SharedPreferencesManager().getAuthToken();
  //   return await http.post(Uri.parse(fullUrl),
  //       body: data, headers: _setFormHeaders());
  // }

  getData(apiUrl,type) async {
    var fullUrl = _baseUrl + apiUrl;
     token = await SharedPreferencesManager().getAuthToken();
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders(type));
  }
  deleteData(apiUrl,type) async {
    var fullUrl = _baseUrl + apiUrl;
    token = await SharedPreferencesManager().getAuthToken();
    return await http.delete(Uri.parse(fullUrl), headers: _setHeaders(type));
  }
  patchData(data, apiUrl,type) async {
    var fullUrl = _baseUrl + apiUrl;
    token = await SharedPreferencesManager().getAuthToken();
    return await http.patch(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders(type));
  }
  postDataWithImage(data, apiUrl, filepath,type,backend) async {
    var fullUrl = _baseUrl + apiUrl;
    token = await SharedPreferencesManager().getAuthToken();
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': '$type $token'
    };
    var request = http.MultipartRequest('POST', Uri.parse(fullUrl))
      ..fields.addAll(data)
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('$backend', filepath));
    return await request.send();
  }
  postDataWithImages(data, apiUrl, List<File> filepath,type,backend) async {
    var fullUrl = _baseUrl + apiUrl;
    token = await SharedPreferencesManager().getAuthToken();
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': '$type $token'
    };
    var request = http.MultipartRequest('POST', Uri.parse(fullUrl))
      ..fields.addAll(data)
      ..headers.addAll(headers);
      for(var image in filepath)
      request.files.add(await http.MultipartFile.fromPath('$backend', image.path));
    return await request.send();
  }

  String getOfferImageUrl(id) {
    return _baseUrl + '/images/meal/$id';
  }

  _setHeaders(type) => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization':'$type $token'
  };
    // _setFormHeaders() => {
    //   'Content-type': 'application/x-www-form-urlencoded',
    //   'Accept': 'application/json',
    //   'Authorization': 'JWT $token'
    // };
}
