import 'package:check_list_front_end/exception/server_code_exception.dart';
import 'package:http/http.dart';

class NetworkService {
  static const String BASE_URL =
      'https://checklistbackend.cfapps.eu10.hana.ondemand.com';
  Future<String> getCheckLists(String token) async {
    Response response = await get(
      BASE_URL + '/api/v1/list/all',
      headers: {'Authorization': 'Bearer ' + token},
    );
    if (response.statusCode == 200) {
      return Future.value(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception('HTTP CODE NOT 200!');
    }
  }

  Future<String> requestNewCheckList(String token) async {
    Response response = await get(
      BASE_URL + '/api/v1/list',
      headers: {'Authorization': 'Bearer ' + token},
    );
    if (response.statusCode == 201) {
      return response.body;
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception('HTTP CODE NOT 201!');
    }
  }

  Future updateCheckListName(dynamic checkListDto, String token) async {
    Response response = await put(
      BASE_URL + '/api/v1/list',
      headers: {'Authorization': 'Bearer ' + token},
      body: checkListDto,
    );
    if (response.statusCode == 204) {
      return response.body;
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception('HTTP CODE NOT 204!');
    }
  }

  Future deleteCheckList(String checkListId, String token) async {
    Response response = await delete(
      BASE_URL + '/api/v1/list/l/$checkListId',
      headers: {'Authorization': 'Bearer ' + token},
    );
    if (response.statusCode == 204) {
      return response.body;
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception('HTTP CODE NOT 204!');
    }
  }

  Future<String> getCheckList(String listId, String token) async {
    Response response = await get(
      BASE_URL + '/api/v1/list/l/$listId',
      headers: {'Authorization': 'Bearer ' + token},
    );
    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception('HTTP CODE NOT 200!');
    }
  }

  Future deleteCheckListItem(String id, String token) async {
    Response response = await delete(
      BASE_URL + '/api/v1/item/i/$id',
      headers: {'Authorization': 'Bearer ' + token},
    );
    if (response.statusCode == 204) {
      return response.body;
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception('HTTP CODE NOT 204!');
    }
  }

  Future<String> requestNewCheckListItem(String listId, String token) async {
    Response response = await get(
      BASE_URL + '/api/v1/item/new?parentId=$listId',
      headers: {'Authorization': 'Bearer ' + token},
    );
    if (response.statusCode == 201) {
      return response.body;
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception('HTTP CODE NOT 201!  Code is ${response.statusCode}');
    }
  }

  Future updateCheckListItem(String jsonEncode, String token) async {
    Response response = await put(BASE_URL + '/api/v1/item/new',
        headers: {'Authorization': 'Bearer ' + token}, body: jsonEncode);
    if (response.statusCode == 204) {
      return response.body;
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception('HTTP CODE NOT 204! Code is ${response.statusCode}');
    }
  }

  Future<String> refreshToken(String rtVal) async {
    Response response = await post(BASE_URL + '/refresh?refreshToken=$rtVal');
    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception('HTTP CODE NOT 200! Code is ${response.statusCode}');
    }
  }

  Future<String> requestLogin(String userCredentials) async {
    Response response = await post(BASE_URL + '/login',
        headers: {'content-type': "application/json"}, body: userCredentials);
    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception('HTTP CODE NOT 200! Code is ${response.statusCode}');
    }
  }
}
