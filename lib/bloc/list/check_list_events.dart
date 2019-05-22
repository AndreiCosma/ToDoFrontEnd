import 'package:check_list_front_end/domain/dto/check_list_dto.dart';

abstract class CheckListEvent {}

class CheckListRefreshEvent extends CheckListEvent {}

class CheckListUpdateEvent extends CheckListEvent {
  final CheckListDTO checkListDTO;

  CheckListUpdateEvent(this.checkListDTO);
}

class CheckListCreateEvent extends CheckListEvent {}

class CheckListReadEvent extends CheckListEvent {
  final String id;

  CheckListReadEvent(this.id);
}

class CheckListDeleteEvent extends CheckListEvent {
  final String id;

  CheckListDeleteEvent(this.id);
}
