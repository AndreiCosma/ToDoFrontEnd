import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:check_list_front_end/domain/dto/check_list_dto.dart';
import 'package:check_list_front_end/domain/dto/check_list_item_dto.dart';
import 'package:check_list_front_end/exception/server_code_exception.dart';
import 'package:check_list_front_end/service/network_service.dart';
import 'package:check_list_front_end/service/user_service.dart';

import 'check_list_item_detail_page_state.dart';
import 'check_list_item_events.dart';

class CheckListItemCrudBloc
    extends Bloc<CheckListItemEvent, CheckListItemDetailPageState> {
  NetworkService _networkService = NetworkService.getInstance();
  UserService _userService = UserService.getInstance();

  String checkListParentId;

  CheckListItemCrudBloc(String checkListParentId) {
    this.checkListParentId = checkListParentId;
    print('Constructor called ITEMS');
    dispatch(CheckListItemRefreshEvent(checkListParentId));
  }

  @override
  CheckListItemDetailPageState get initialState =>
      CheckListItemDetailPageStateAwaitAction([]);

  @override
  void onEvent(CheckListItemEvent event) {
    super.onEvent(event);
    print('Event: $event');
  }

  @override
  void onTransition(
      Transition<CheckListItemEvent, CheckListItemDetailPageState> transition) {
    super.onTransition(transition);
    print(transition);
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
        yield CheckListItemDetailPageStateActionFinished(CheckListDTO.fromJson(
          jsonDecode(
              await _networkService.getCheckList(checkListParentId, token)),
        ).items);
      } else if (event is CheckListItemCreateEvent) {
        CheckListItemDTO item = CheckListItemDTO.fromJson(jsonDecode(
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

  void dispatchNewListItem(String id) {
    dispatch(CheckListItemCreateEvent(id));
  }

  void dispatchUpdateListItem(CheckListItemDTO item) {
    dispatch(CheckListItemUpdateEvent(item));
  }

  void dispatchDeleteListItem(CheckListItemDTO dto) {
    dispatch(CheckListItemDeleteEvent(dto));
  }

  Future refresh(String id) async {
    await dispatch(CheckListItemRefreshEvent(id));
    return Future.value();
  }
}
