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
        currentState.items.remove(event.dto);
        yield CheckListPageStatePreliminaryResult(currentState.items);
      } catch (e) {
        print(e);
      }
    }

    try {
      String token = await _userService.getToken();
      if (event is CheckListRefreshEvent) {
        //Get items from back-end
        yield CheckListPageStateActionFinished(_jsonService
            .decodeCheckLists(await _networkService.getCheckLists(token)));
      } else if (event is CheckListCreateEvent) {
        CheckListDTO item = _jsonService.decodeCheckList(
            jsonDecode(await _networkService.requestNewCheckList(token)));
        this.currentState.items.add(item);
        yield CheckListPageStateActionFinished(this.currentState.items);
      } else if (event is CheckListReadEvent) {
      } else if (event is CheckListUpdateEvent) {
        yield CheckListPageStateActionFinished(this.currentState.items);
        await _networkService.updateCheckListName(
            jsonEncode(event.checkListDTO.toJson()), token);
      } else if (event is CheckListDeleteEvent) {
        await _networkService.deleteCheckList(event.dto.id, token);
      }

      yield CheckListPageStateAwaitAction(this.currentState.items);
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

  void requestDeleteList(CheckListDTO dto) {
    dispatch(CheckListDeleteEvent(dto));
  }

  Future refresh() async {
    await dispatch(CheckListRefreshEvent());
    return Future.value();
  }
}
