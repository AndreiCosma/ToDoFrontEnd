import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:check_list_front_end/domain/dto/check_list_dto.dart';
import 'package:check_list_front_end/exception/server_code_exception.dart';
import 'package:check_list_front_end/service/json_service.dart';
import 'package:check_list_front_end/service/network_service.dart';
import 'package:check_list_front_end/service/user_service.dart';

import 'check_list_events.dart';
import 'check_list_state.dart';

class CheckListCrudBloc extends Bloc<CheckListEvent, CheckListPageState> {
  JsonService _jsonService = JsonService();
  NetworkService _networkService = NetworkService();
  UserService _userService = UserService();

  CheckListCrudBloc() {
    dispatch(CheckListRefreshEvent());
  }

  @override
  CheckListPageState get initialState => CheckListPageStateAwaitAction([]);

  @override
  void onEvent(CheckListEvent event) {
    // TODO: implement onEvent
    print('event:' + event.toString());
    super.onEvent(event);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print('error:' + stacktrace.toString());
    super.onError(error, stacktrace);
  }

  @override
  Stream<CheckListPageState> mapEventToState(CheckListEvent event) async* {
    if (event is CheckListDeleteEvent) {
      try {
        yield CheckListPageStatePreliminaryResult(
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
      if (event is CheckListRefreshEvent) {
      } else if (event is CheckListCreateEvent) {
        await _networkService.requestNewCheckList(token);
      } else if (event is CheckListReadEvent) {
      } else if (event is CheckListUpdateEvent) {
        await _networkService.updateCheckListName(
            jsonEncode(event.checkListDTO.toJson()), token);
      } else if (event is CheckListDeleteEvent) {
        await _networkService.deleteCheckList(event.id, token);
      }
      //Get items from back-end
      List<CheckListDTO> items = _jsonService
          .decodeCheckLists(await _networkService.getCheckLists(token));

      yield CheckListPageStateActionFinished(items);
      yield CheckListPageStateAwaitAction(items);
    } catch (e) {
      print(e);
      if (e is UnauthorisedException) {
        await _userService.refreshToken();
        dispatch(event);
      }
    }
  }

  void requestCreateNewList() {
    dispatch(CheckListCreateEvent());
  }

  void requestUpdateList(CheckListDTO checkListDTO) {
    dispatch(CheckListUpdateEvent(checkListDTO));
  }

  void requestDeleteList(String id) {
    dispatch(CheckListDeleteEvent(id));
  }

  Future refresh() async {
    await dispatch(CheckListRefreshEvent());
    return Future.value();
  }
}
