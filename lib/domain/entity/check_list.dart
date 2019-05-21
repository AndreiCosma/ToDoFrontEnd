import 'package:check_list_front_end/domain/entity/check_list_item.dart';

class CheckList {
  String id;
  String name;
  List<CheckListItem> items;
  DateTime creationDate;
  DateTime lastModifiedDate;

  CheckList(
      {this.id,
      this.name,
      this.items,
      this.creationDate,
      this.lastModifiedDate});
}
