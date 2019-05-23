import 'package:check_list_front_end/util/constants.dart';

class CheckListItemDTO {
  final String listId;
  final String id;
  String name;
  bool checked;

  CheckListItemDTO({this.listId, this.id, this.name, this.checked});

  Map<String, dynamic> toJson() => {
        kCheckListItemParentId: this.listId,
        kCheckListItemId: this.id,
        kCheckListItemName: this.name,
        kCheckListItemChecked: this.checked
      };

  static List toJsonList(List<CheckListItemDTO> list) {
    List jsonList = List();
    list.map((item) => jsonList.add(item.toJson())).toList();
    return jsonList;
  }
}
