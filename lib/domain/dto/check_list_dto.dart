import 'check_list_item_dto.dart';

class CheckListDTO {
  final String id;
  final String name;
  final List<CheckListItemDTO> items;
  final DateTime creationDate;
  final DateTime lastModificationDate;

  CheckListDTO(
      {this.id,
      this.name,
      this.items,
      this.creationDate,
      this.lastModificationDate});
}
