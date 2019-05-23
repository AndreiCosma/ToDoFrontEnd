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
  void onTransition(
      Transition<CheckListItemEvent, CheckListItemDetailPageState> transition) {
    super.onTransition(transition);
    print('Transition: $transition');
  }

  @override
  Stream<CheckListItemDetailPageState> mapEventToState(
      CheckListItemEvent event) async* {
    if (event is CheckListItemDeleteEvent) {
      try {
        currentState.items.remove(event.dto);
        yield CheckListItemDetailPageStatePreliminaryResult(currentState.items);
      } catch (e) {
        print(e);
      }
    }

    try {
      String token = await _userService.getToken();

      if (event is CheckListItemRefreshEvent) {
        //Get items from backend
        yield CheckListItemDetailPageStateActionFinished(_jsonService
            .decodeCheckList(
              jsonDecode(
                  await _networkService.getCheckList(checkListParentId, token)),
            )
            .items);
      } else if (event is CheckListItemCreateEvent) {
        CheckListItemDTO item = _jsonService.decodeCheckListItem(jsonDecode(
            await _networkService.requestNewCheckListItem(event.id, token)));
        this.currentState.items.add(item);
        yield CheckListItemDetailPageStateActionFinished(
            this.currentState.items);
      } else if (event is CheckListItemUpdateEvent) {
        CheckListItemDetailPageStateActionFinished(this.currentState.items);
        await _networkService.updateCheckListItem(
            jsonEncode(event.checkListItemDTO), token);
      } else if (event is CheckListItemDeleteEvent) {
        await _networkService.deleteCheckListItem(event.dto.id, token);
      }

      yield CheckListItemDetailPageStateAwaitAction(this.currentState.items);
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

  void requestDeleteListItem(CheckListItemDTO dto) {
    dispatch(CheckListItemDeleteEvent(dto));
  }

  Future refresh(String id) async {
    await dispatch(CheckListItemRefreshEvent(id));
    return Future.value();
  }
}
