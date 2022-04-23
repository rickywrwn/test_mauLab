import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_flutter/model/home_model.dart';
import 'package:tuple/tuple.dart';

class HomeApiProvider {
  Future<Tuple2<List<Home>?, int>> getCandidate() async {
    String url = "https://private-b9a758-candidattest.apiary-mock.com/candidates";
    print(url);
    final apiResult = await http.get(Uri.parse(url));
    var jsonObject = json.decode(utf8.decode(apiResult.bodyBytes));
    var status = apiResult.statusCode;

    if (status == 200) {
      var apiData = jsonObject["results"];
      // print(apiData);
      var dataList = (apiData as List).map<Home>((item) => Home.fromJson(item)).toList();
      var today = DateTime.now().millisecondsSinceEpoch;
      var filtered = dataList.where((item) => (item.expired! <= today)).toList();
      return Tuple2(filtered, status);
    } else {
      return Tuple2(null, status);
    }
  }

  Future<Tuple2<List<Home>?, int>> getBlog() async {
    String url = "https://private-b9a758-candidattest.apiary-mock.com/blogs";
    print(url);
    final apiResult = await http.get(Uri.parse(url));
    var jsonObject = json.decode(utf8.decode(apiResult.bodyBytes));

    var status = apiResult.statusCode;

    if (status == 200) {
      var apiData = jsonObject["results"];
      // print(apiData);
      var dataList = (apiData as List).map<Home>((item) => Home.fromJson(item)).toList();
      return Tuple2(dataList, status);
    } else {
      return Tuple2(null, status);
    }
  }
}
