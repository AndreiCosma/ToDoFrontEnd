import 'package:bloc/bloc.dart';
import 'package:check_list_front_end/domain/dto/check_list_item_dto.dart';
import 'package:check_list_front_end/service/json_service.dart';
import 'package:check_list_front_end/service/network_service.dart';
import 'dart:convert';

class CheckListItemCrudBloc
    extends Bloc<CheckListItemEvent, List<CheckListItemDTO>> {
  JsonService _jsonService = JsonService();
  NetworkService _networkService = NetworkService();

  List<CheckListItemDTO> items;

  CheckListItemCrudBloc({this.items});

  @override
  List<CheckListItemDTO> get initialState => items;

  @override
  Stream<List<CheckListItemDTO>> mapEventToState(
      CheckListItemEvent event) async* {
    try {
      switch (event.event) {
        case CheckListItemsEvents.REFRESH:
          yield _jsonService
              .decodeCheckList(
                await _networkService.getCheckList(event.checkList.listId),
              )
              .items;

          print(currentState);
          break;

        case CheckListItemsEvents.CREATE:
          await _networkService.requestNewCheckListItem(event.checkList.listId);
          yield _jsonService
              .decodeCheckList(
                await _networkService.getCheckList(event.checkList.listId),
              )
              .items;
          break;
        case CheckListItemsEvents.READ:
          yield _jsonService
              .decodeCheckList(
                await _networkService.getCheckList(event.checkList.listId),
              )
              .items;
          break;
        case CheckListItemsEvents.UPDATE:
          await _networkService
              .updateCheckListItem(jsonEncode(event.checkList));

          yield _jsonService
              .decodeCheckList(
                await _networkService.getCheckList(event.checkList.listId),
              )
              .items;
          break;
        case CheckListItemsEvents.DELETE:
          await _networkService.deleteCheckListItem(event.checkList.id);

          yield _jsonService
              .decodeCheckList(
                await _networkService.getCheckList(event.checkList.listId),
              )
              .items;
          break;
      }
    } catch (e) {
      print(e);
    }
  }
}

enum CheckListItemsEvents { REFRESH, CREATE, READ, UPDATE, DELETE }

class CheckListItemEvent {
  final CheckListItemsEvents event;

  final CheckListItemDTO checkList;

  CheckListItemEvent(this.event, this.checkList);
}
