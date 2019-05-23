import 'package:check_list_front_end/util/constants.dart';

import 'check_list_item_dto.dart';

class CheckListDTO {
  final String id;
  String name;
  final List<CheckListItemDTO> items;
  final DateTime creationDate;

  CheckListDTO({this.id, this.name, this.items, this.creationDate});

  Map<String, dynamic> toJson() => {
        kCheckListId: this.id,
        kCheckListName: this.name,
        kCheckListItems: CheckListItemDTO.toJsonList(items),
        kCheckListCreationDate: this.creationDate.toIso8601String()
      };
}
