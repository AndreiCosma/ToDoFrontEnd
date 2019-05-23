import 'package:check_list_front_end/domain/dto/check_list_item_dto.dart';

abstract class CheckListItemEvent {}

class CheckListItemRefreshEvent extends CheckListItemEvent {
  final String id;

  CheckListItemRefreshEvent(this.id);
}

class CheckListItemUpdateEvent extends CheckListItemEvent {
  final CheckListItemDTO checkListItemDTO;

  CheckListItemUpdateEvent(this.checkListItemDTO);
}

class CheckListItemCreateEvent extends CheckListItemEvent {
  final String id;

  CheckListItemCreateEvent(this.id);
}

class CheckListReadEvent extends CheckListItemEvent {
  final String id;

  CheckListReadEvent(this.id);
}

class CheckListItemDeleteEvent extends CheckListItemEvent {
  final CheckListItemDTO dto;

  CheckListItemDeleteEvent(this.dto);
}
