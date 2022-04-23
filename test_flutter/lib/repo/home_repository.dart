import 'package:test_flutter/model/home_model.dart';
import 'package:test_flutter/network/home_api_provider.dart';
import 'package:tuple/tuple.dart';

class HomeRepository {
  final homeApi = HomeApiProvider();

  Future<Tuple2<List<Home>?, int>> getCandidate() async {
    var apiData = await homeApi.getCandidate();
    return Tuple2(apiData.item1, apiData.item2);
  }

  Future<Tuple2<List<Home>?, int>> getBlog() async {
    var apiData = await homeApi.getBlog();
    return Tuple2(apiData.item1, apiData.item2);
  }
}
