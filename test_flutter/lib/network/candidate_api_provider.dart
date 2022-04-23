import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_flutter/model/candidate_model.dart';
import 'package:test_flutter/model/home_model.dart';
import 'package:tuple/tuple.dart';

class CandidateApiProvider {
  Future<Tuple2<List<Address>?, int>> getAdrress(String id) async {
    String url = "https://private-b9a758-candidattest.apiary-mock.com/address";
    print(url);
    final apiResult = await http.get(Uri.parse(url));
    var jsonObject = json.decode(utf8.decode(apiResult.bodyBytes));
    var status = apiResult.statusCode;

    if (status == 200) {
      var apiData = jsonObject["results"];
      // print(apiData);
      var dataList = (apiData as List).map<Address>((item) => Address.fromJson(item)).toList();
      var filtered = dataList.where((item) => (item.id == int.parse(id))).toList();
      print(filtered);
      if (filtered.length > 0) {
        return Tuple2(filtered, status);
      } else {
        return Tuple2(null, 404);
      }
    } else {
      return Tuple2(null, status);
    }
  }

  Future<Tuple2<List<Email>?, int>> getEmail(String id) async {
    String url = "https://private-b9a758-candidattest.apiary-mock.com/emails";
    print(url);
    final apiResult = await http.get(Uri.parse(url));
    var jsonObject = json.decode(utf8.decode(apiResult.bodyBytes));
    var status = apiResult.statusCode;

    if (status == 200) {
      var apiData = jsonObject["results"];
      // print(apiData);
      var dataList = (apiData as List).map<Email>((item) => Email.fromJson(item)).toList();
      var filtered = dataList.where((item) => (item.id == int.parse(id))).toList();
      print(filtered);
      if (filtered.length > 0) {
        return Tuple2(filtered, status);
      } else {
        return Tuple2(null, 404);
      }
    } else {
      return Tuple2(null, status);
    }
  }

  Future<Tuple2<List<Experience>?, int>> getExperience(String id) async {
    String url = "https://private-b9a758-candidattest.apiary-mock.com/experiences";
    print(url);
    final apiResult = await http.get(Uri.parse(url));
    var jsonObject = json.decode(utf8.decode(apiResult.bodyBytes));
    var status = apiResult.statusCode;

    if (status == 200) {
      var apiData = jsonObject["results"];
      // print(apiData);
      var dataList = (apiData as List).map<Experience>((item) => Experience.fromJson(item)).toList();
      var filtered = dataList.where((item) => (item.id == int.parse(id))).toList();
      print(filtered);
      if (filtered.length > 0) {
        return Tuple2(filtered, status);
      } else {
        return Tuple2(null, 404);
      }
    } else {
      return Tuple2(null, status);
    }
  }
}
