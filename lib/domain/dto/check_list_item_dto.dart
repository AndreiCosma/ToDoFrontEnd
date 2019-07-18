import 'package:check_list_front_end/util/constants.dart';

class CheckListItemDTO {
  final String listId;
  final String id;
  String name;
  bool checked;
  DateTime editDate;
  int position;

  CheckListItemDTO(
      {this.listId,
      this.id,
      this.name,
      this.checked,
      this.editDate,
      this.position});

  Map<String, dynamic> toJson() => {
        kCheckListItemParentId: this.listId,
        kCheckListItemId: this.id,
        kCheckListItemName: this.name,
        kCheckListItemChecked: this.checked,
        kEditDate: this.editDate,
        kPosition: this.position
      };

  factory CheckListItemDTO.fromJson(Map<String, dynamic> json) =>
      CheckListItemDTO(
          listId: json[kCheckListId],
          id: json[kCheckListItemId],
          name: json[kCheckListItemName],
          checked: json[kCheckListItemChecked],
          editDate: DateTime(json[kEditDate]),
          position: json[kPosition]);
}
