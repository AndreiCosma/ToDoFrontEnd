import 'dart:convert';

import 'package:check_list_front_end/domain/dto/check_list_dto.dart';
import 'package:check_list_front_end/domain/dto/check_list_item_dto.dart';
import 'package:check_list_front_end/domain/dto/token_dto.dart';
import 'package:check_list_front_end/util/constants.dart';

class JsonService {
  List<CheckListDTO> decodeCheckLists(String json) {
    List<CheckListDTO> list = [];
    List<dynamic>.from(jsonDecode(json))
        .forEach((item) => list.add(decodeCheckList(item)));
    return list;
  }

  CheckListDTO decodeCheckList(dynamic json) {
    List<CheckListItemDTO> items = decodeCheckListItems(json[kCheckListItems]);
    return CheckListDTO(
      id: json[kCheckListId],
      name: json[kCheckListName],
      items: items,
      creationDate:
          DateTime.fromMillisecondsSinceEpoch(json[kCheckListCreationDate]),
    );
  }

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

  TokenDTO decodeToken(String json) => TokenDTO(
        accessToken: jsonDecode(json)[kAccessToken],
        refreshToken: jsonDecode(json)[kRefreshToken],
      );
}
