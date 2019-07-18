import 'package:check_list_front_end/util/constants.dart';

import 'check_list_item_dto.dart';

class CheckListDTO {
  final String id;
  String name;
  final List<CheckListItemDTO> items;
  final DateTime creationDate;
  final DateTime editDate;
  final int position;

  CheckListDTO(
      {this.editDate,
      this.position,
      this.id,
      this.name,
      this.items,
      this.creationDate});

  Map<String, dynamic> toJson() => {
        kCheckListId: this.id,
        kCheckListName: this.name,
        kCheckListItems: items.map((item) => item.toJson()).toList(),
        kCheckListCreationDate: this.creationDate.toIso8601String(),
        kEditDate: this.editDate.toIso8601String(),
        kPosition: this.position
      };

  factory CheckListDTO.fromJson(Map<String, dynamic> json) => CheckListDTO(
      id: json[kCheckListId],
      name: json[kCheckListName],
      items: List<CheckListItemDTO>.from(
          json[kCheckListItems].map((item) => CheckListItemDTO.fromJson(item))),
      creationDate: DateTime(json[kCheckListCreationDate]),
      editDate: DateTime(json[kEditDate]),
      position: json[kPosition]);
}
