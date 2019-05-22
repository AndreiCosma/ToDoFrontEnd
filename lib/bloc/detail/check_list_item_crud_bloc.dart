import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:check_list_front_end/domain/dto/check_list_item_dto.dart';
import 'package:check_list_front_end/exception/server_code_exception.dart';
import 'package:check_list_front_end/service/json_service.dart';
import 'package:check_list_front_end/service/network_service.dart';
import 'package:check_list_front_end/service/user_service.dart';

import 'check_list_item_events.dart';

class CheckListItemCrudBloc
    extends Bloc<CheckListItemEvent, List<CheckListItemDTO>> {
  JsonService _jsonService = JsonService();
  NetworkService _networkService = NetworkService();
  UserService _userService = UserService();

  List<CheckListItemDTO> items;
  String checkListParentId;

  CheckListItemCrudBloc({this.items, this.checkListParentId});

  @override
  List<CheckListItemDTO> get initialState => items;

  @override
  Stream<List<CheckListItemDTO>> mapEventToState(
      CheckListItemEvent event) async* {
    try {
      String token = await _userService.getToken();

      if (event is CheckListItemRefreshEvent) {
        yield _jsonService
            .decodeCheckList(
              jsonDecode(await _networkService.getCheckList(event.id, token)),
            )
            .items;
      } else if (event is CheckListItemCreateEvent) {
        await _networkService.requestNewCheckListItem(event.id, token);
      } else if (event is CheckListItemUpdateEvent) {
        await _networkService.updateCheckListItem(
            jsonEncode(event.checkListItemDTO), token);
      } else if (event is CheckListItemDeleteEvent) {
        await _networkService.deleteCheckListItem(event.id, token);
      }
      yield _jsonService
          .decodeCheckList(
            jsonDecode(
                await _networkService.getCheckList(checkListParentId, token)),
          )
          .items;
    } catch (e) {
      if (e is UnauthorisedException) {
        await _userService.refreshToken();
        dispatch(event);
      }
    }
  }

  void requestNewListItem(String id) {
    dispatch(CheckListItemCreateEvent(id));
  }

  void requestUpdateListItem(CheckListItemDTO item) {
    dispatch(CheckListItemUpdateEvent(item));
  }

  void requestDeleteListItem(String id) {
    dispatch(CheckListItemDeleteEvent(id));
  }

  Future refresh(String id) async {
    await dispatch(CheckListItemRefreshEvent(id));
    return Future.value();
  }
}
