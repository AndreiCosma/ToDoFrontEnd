import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:check_list_front_end/domain/dto/check_list_dto.dart';
import 'package:check_list_front_end/service/json_service.dart';
import 'package:check_list_front_end/service/network_service.dart';

class CheckListCrudBloc extends Bloc<CheckListEvent, List<CheckListDTO>> {
  JsonService _jsonService = JsonService();
  NetworkService _networkService = NetworkService();

  CheckListCrudBloc() {
    dispatch(CheckListEvent(CheckListEvents.REFRESH, null));
  }

  @override
  List<CheckListDTO> get initialState => [];

  @override
  void onTransition(Transition<CheckListEvent, List<CheckListDTO>> transition) {
    print(initialState);
    initialState.forEach((item) {
      transition.nextState.add(item);
    });
    print('Transition--->' + transition.toString());
  }

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
  Stream<List<CheckListDTO>> mapEventToState(CheckListEvent event) async* {
    print('Event');
    print(currentState);
    try {
      switch (event.event) {
        case CheckListEvents.REFRESH:
          yield _jsonService.decodeCheckLists(
            await _networkService.getCheckLists(),
          );

          print(currentState);
          break;

        case CheckListEvents.CREATE:
          await _networkService.requestNewCheckList();
          yield _jsonService.decodeCheckLists(
            await _networkService.getCheckLists(),
          );
          break;
        case CheckListEvents.READ:
          yield _jsonService.decodeCheckLists(
            await _networkService.getCheckLists(),
          );
          break;
        case CheckListEvents.UPDATE:
          await _networkService
              .updateCheckListName(jsonEncode(event.checkList));

          yield _jsonService.decodeCheckLists(
            await _networkService.getCheckLists(),
          );
          break;
        case CheckListEvents.DELETE:
          await _networkService.deleteCheckList(event.checkList.id);

          yield _jsonService.decodeCheckLists(
            await _networkService.getCheckLists(),
          );
          break;
      }
    } catch (e) {
      print(e);
    }
  }
}

//Refresh on every state
enum CheckListEvents { REFRESH, CREATE, READ, UPDATE, DELETE }

class CheckListEvent {
  final CheckListEvents event;

  final CheckListDTO checkList;

  CheckListEvent(this.event, this.checkList);
}
