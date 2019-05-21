import 'dart:convert';

import 'package:check_list_front_end/domain/dto/check_list_dto.dart';
import 'package:check_list_front_end/domain/dto/check_list_item_dto.dart';
import 'package:check_list_front_end/util/constants.dart';

class JsonService {
  List<CheckListDTO> decodeCheckLists(String json) {
    List<CheckListDTO> list = [];
    List<dynamic>.from(jsonDecode(json))
        .forEach((item) => list.add(decodeCheckList(item)));
    return list;
  }

  CheckListDTO decodeCheckList(dynamic json) => CheckListDTO(
        id: json[kCheckListId],
        name: json[kCheckListName],
        items: decodeCheckListItems(json[kCheckListItems]),
        creationDate:
            DateTime.fromMillisecondsSinceEpoch(json[kCheckListCreationDate]),
        lastModificationDate: DateTime.now(),
      );

  List<CheckListItemDTO> decodeCheckListItems(List<dynamic> items) {
    List<CheckListItemDTO> list = [];
    items.forEach((item) => list.add(decodeCheckListItem(item)));
    return list;
  }

  CheckListItemDTO decodeCheckListItem(dynamic json) => CheckListItemDTO(
        listId: json[kCheckListItemParentId],
        id: json[kCheckListItemId],
        name: json[kCheckListItemName],
        checked: json[kCheckListItemChecked],
      );
}
