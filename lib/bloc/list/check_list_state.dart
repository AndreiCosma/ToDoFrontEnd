import 'package:check_list_front_end/domain/dto/check_list_dto.dart';
import 'package:equatable/equatable.dart';

abstract class CheckListPageState extends Equatable {
  final List<CheckListDTO> items;

  CheckListPageState(this.items, [List props = const []]) : super(props);
}

class CheckListPageStateRefresh extends CheckListPageState {
  CheckListPageStateRefresh(List<CheckListDTO> items) : super(items);
}

class CheckListPageStateOneItemDeleted extends CheckListPageState {
  CheckListPageStateOneItemDeleted(List<CheckListDTO> items) : super(items);
}

class CheckListPageStateOneItemAdded extends CheckListPageState {
  CheckListPageStateOneItemAdded(List<CheckListDTO> items) : super(items);
}

class CheckListPageStateOneItemUpdated extends CheckListPageState {
  CheckListPageStateOneItemUpdated(List<CheckListDTO> items) : super(items);
}

class CheckListPageStateRefreshing extends CheckListPageState {
  CheckListPageStateRefreshing(List<CheckListDTO> items) : super(items);
}
