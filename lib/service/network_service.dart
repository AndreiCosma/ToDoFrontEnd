import 'package:http/http.dart';

class NetworkService {
  static const String BASE_URL =
      'https://checklistbackend.cfapps.eu10.hana.ondemand.com';
  static const String TOKEN =
      'eyJhbGciOiJIUzUxMiJ9.eyJ1c2VySWQiOiIwNmE5MDUzYy0zODA2LTQ0N2MtYmJmZi0zYzUwYjQ0YzgwZmMiLCJzdWIiOiJBbmRyZWlDb3NtYSIsImlhdCI6MTU1ODQ1OTUyNSwiZXhwIjoxNTU4NDYzMTI1fQ.K8nGuf4SpYwwJjKjRZeqWjbLfRJkGOiMcl9D8mJCAZJdlCwT9TchEFgSUVSS2D6I18k7WMzMhhJ2GEtZJQhkTA';
  Future<String> getCheckLists() async {
    Response response = await get(
      BASE_URL + '/api/v1/list/all',
      headers: {'Authorization': 'Bearer ' + TOKEN},
    );
    if (response.statusCode == 200) {
      return Future.value(response.body);
    } else {
      throw Exception('HTTP CODE NOT 200!');
    }
  }

  Future<String> requestNewCheckList() async {
    Response response = await get(
      BASE_URL + '/api/v1/list',
      headers: {'Authorization': 'Bearer ' + TOKEN},
    );
    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('HTTP CODE NOT 201!');
    }
  }

  Future updateCheckListName(dynamic checkListDto) async {
    Response response = await put(
      BASE_URL + '/api/v1/list',
      headers: {'Authorization': 'Bearer ' + TOKEN},
      body: checkListDto,
    );
    if (response.statusCode == 204) {
      return response.body;
    } else {
      throw Exception('HTTP CODE NOT 204!');
    }
  }

  Future deleteCheckList(String checkListId) async {
    Response response = await delete(
      BASE_URL + '/api/v1/list/l/$checkListId',
      headers: {'Authorization': 'Bearer ' + TOKEN},
    );
    if (response.statusCode == 204) {
      return response.body;
    } else {
      throw Exception('HTTP CODE NOT 204!');
    }
  }

  Future<String> getCheckList(String listId) async {
    Response response = await get(
      BASE_URL + '/api/v1/list/l/$listId',
      headers: {'Authorization': 'Bearer ' + TOKEN},
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('HTTP CODE NOT 200!');
    }
  }

  Future deleteCheckListItem(String id) async {
    Response response = await delete(
      BASE_URL + '/api/v1/item/i/$id',
      headers: {'Authorization': 'Bearer ' + TOKEN},
    );
    if (response.statusCode == 204) {
      return response.body;
    } else {
      throw Exception('HTTP CODE NOT 204!');
    }
  }

  Future<String> requestNewCheckListItem(String listId) async {
    Response response = await get(
      BASE_URL + '/api/v1/item/new?parentId=$listId',
      headers: {'Authorization': 'Bearer ' + TOKEN},
    );
    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('HTTP CODE NOT 201!  Code is ${response.statusCode}');
    }
  }

  Future updateCheckListItem(String jsonEncode) async {
    Response response = await put(BASE_URL + '/api/v1/item/new',
        headers: {'Authorization': 'Bearer ' + TOKEN}, body: jsonEncode);
    if (response.statusCode == 204) {
      return response.body;
    } else {
      throw Exception('HTTP CODE NOT 204! Code is ${response.statusCode}');
    }
  }
}
