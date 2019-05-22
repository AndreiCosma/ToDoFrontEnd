import 'package:check_list_front_end/domain/dto/check_list_item_dto.dart';
import 'package:equatable/equatable.dart';

abstract class CheckListItemDetailPageState extends Equatable {
  final List<CheckListItemDTO> items;

  CheckListItemDetailPageState(this.items, [List props = const []])
      : super(props);
}

class CheckListItemDetailPageStateAwaitAction
    extends CheckListItemDetailPageState {
  CheckListItemDetailPageStateAwaitAction(List<CheckListItemDTO> items)
      : super(items);
}

class CheckListItemDetailPageStatePreliminaryResult
    extends CheckListItemDetailPageState {
  CheckListItemDetailPageStatePreliminaryResult(List<CheckListItemDTO> items)
      : super(items);
}

class CheckListItemDetailPageStateActionFinished
    extends CheckListItemDetailPageState {
  CheckListItemDetailPageStateActionFinished(List<CheckListItemDTO> items)
      : super(items);
}
