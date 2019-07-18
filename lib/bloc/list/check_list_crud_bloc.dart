import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:check_list_front_end/domain/dto/check_list_dto.dart';
import 'package:check_list_front_end/exception/server_code_exception.dart';
import 'package:check_list_front_end/service/network_service.dart';
import 'package:check_list_front_end/service/user_service.dart';

import 'check_list_events.dart';
import 'check_list_state.dart';

class CheckListCrudBloc extends Bloc<CheckListEvent, CheckListPageState> {
  NetworkService _networkService = NetworkService.getInstance();
  UserService _userService = UserService.getInstance();

  CheckListCrudBloc() {
    print('Constructor called LISTS');
    dispatch(CheckListRefreshEvent());
  }

  @override
  void onTransition(Transition<CheckListEvent, CheckListPageState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  CheckListPageState get initialState => CheckListPageStateAwaitAction([]);

  @override
  void onEvent(CheckListEvent event) {
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
        yield CheckListPageStateActionFinished(List<CheckListDTO>.from(
            jsonDecode(await _networkService.getCheckLists(token))
                .map((item) => CheckListDTO.fromJson(item))));
      } else if (event is CheckListCreateEvent) {
        CheckListDTO item = CheckListDTO.fromJson(
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

  void dispatchCreateNewList() {
    dispatch(CheckListCreateEvent());
  }

  void dispatchUpdateList(CheckListDTO checkListDTO) {
    dispatch(CheckListUpdateEvent(checkListDTO));
  }

  void dispatchDeleteList(CheckListDTO dto) {
    dispatch(CheckListDeleteEvent(dto));
  }

  Future refresh() async {
    await dispatch(CheckListRefreshEvent());
    return Future.value();
  }
}
