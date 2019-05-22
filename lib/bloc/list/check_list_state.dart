import 'package:check_list_front_end/domain/dto/check_list_dto.dart';
import 'package:equatable/equatable.dart';

abstract class CheckListPageState extends Equatable {
  final List<CheckListDTO> items;

  CheckListPageState(this.items, [List props = const []]) : super(props);
}

class CheckListPageStateAwaitAction extends CheckListPageState {
  CheckListPageStateAwaitAction(List<CheckListDTO> items) : super(items);
}

class CheckListPageStatePreliminaryResult extends CheckListPageState {
  CheckListPageStatePreliminaryResult(List<CheckListDTO> items) : super(items);
}

class CheckListPageStateActionFinished extends CheckListPageState {
  CheckListPageStateActionFinished(List<CheckListDTO> items) : super(items);
}
