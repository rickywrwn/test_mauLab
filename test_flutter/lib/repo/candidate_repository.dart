import 'package:test_flutter/model/candidate_model.dart';
import 'package:test_flutter/network/candidate_api_provider.dart';
import 'package:tuple/tuple.dart';

class CandidateRepository {
  final candidateApi = CandidateApiProvider();

  Future<Tuple2<List<Address>?, int>> getAddress(String id) async {
    var apiData = await candidateApi.getAdrress(id);
    return Tuple2(apiData.item1, apiData.item2);
  }

  Future<Tuple2<List<Email>?, int>> getEmail(String id) async {
    var apiData = await candidateApi.getEmail(id);
    return Tuple2(apiData.item1, apiData.item2);
  }

  Future<Tuple2<List<Experience>?, int>> getExperience(String id) async {
    var apiData = await candidateApi.getExperience(id);
    return Tuple2(apiData.item1, apiData.item2);
  }
}
