import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:check_list_front_end/domain/dto/check_list_item_dto.dart';
import 'package:check_list_front_end/exception/server_code_exception.dart';
import 'package:check_list_front_end/service/json_service.dart';
import 'package:check_list_front_end/service/network_service.dart';
import 'package:check_list_front_end/service/user_service.dart';

import 'check_list_item_detail_page_state.dart';
import 'check_list_item_events.dart';

class CheckListItemCrudBloc
    extends Bloc<CheckListItemEvent, CheckListItemDetailPageState> {
  JsonService _jsonService = JsonService();
  NetworkService _networkService = NetworkService();
  UserService _userService = UserService();

  String checkListParentId;

  CheckListItemCrudBloc(String checkListParentId) {
    this.checkListParentId = checkListParentId;
    dispatch(CheckListItemRefreshEvent(checkListParentId));
  }

  @override
  CheckListItemDetailPageState get initialState =>
      CheckListItemDetailPageStateAwaitAction([]);

  @override
  Stream<CheckListItemDetailPageState> mapEventToState(
      CheckListItemEvent event) async* {
    if (event is CheckListItemDeleteEvent) {
      try {
        yield CheckListItemDetailPageStatePreliminaryResult(
            currentState.items.map((item) {
          if (item.id != event.id) {
            return item;
          }
        }).toList());
      } catch (e) {
        print(e);
      }
    }

    try {
      String token = await _userService.getToken();

      if (event is CheckListItemRefreshEvent) {
      } else if (event is CheckListItemCreateEvent) {
        await _networkService.requestNewCheckListItem(event.id, token);
      } else if (event is CheckListItemUpdateEvent) {
        await _networkService.updateCheckListItem(
            jsonEncode(event.checkListItemDTO), token);
      } else if (event is CheckListItemDeleteEvent) {
        await _networkService.deleteCheckListItem(event.id, token);
      }

      //Get items from back-end

      List<CheckListItemDTO> items = _jsonService
          .decodeCheckList(
            jsonDecode(
                await _networkService.getCheckList(checkListParentId, token)),
          )
          .items;
      yield CheckListItemDetailPageStateActionFinished(items);
      yield CheckListItemDetailPageStateAwaitAction(items);
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
