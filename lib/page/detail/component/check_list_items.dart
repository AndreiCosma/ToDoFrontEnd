import 'package:check_list_front_end/bloc/detail/check_list_item_crud_bloc.dart';
import 'package:check_list_front_end/bloc/detail/check_list_item_events.dart';
import 'package:check_list_front_end/domain/dto/check_list_item_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckListItemsDetailWidget extends StatefulWidget {
  final List<CheckListItemDTO> items;
  final String parentId;

  const CheckListItemsDetailWidget({Key key, this.items, this.parentId})
      : super(key: key);

  @override
  _CheckListItemsDetailWidgetState createState() =>
      _CheckListItemsDetailWidgetState(items: items, parentId: parentId);
}

class _CheckListItemsDetailWidgetState
    extends State<CheckListItemsDetailWidget> {
  List<CheckListItemDTO> items;
  String parentId;

  _CheckListItemsDetailWidgetState({this.items, this.parentId});

  @override
  Widget build(BuildContext context) {
    CheckListItemCrudBloc _checkListItemCrudBloc =
        BlocProvider.of<CheckListItemCrudBloc>(context);

    return BlocBuilder<CheckListItemEvent, List<CheckListItemDTO>>(
      bloc: _checkListItemCrudBloc,
      builder: (context, items) {
        return RefreshIndicator(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) => Card(
                  child: CheckboxListTile(
                    title: Text(items[index].name),
                    value: items[index].checked,
                    onChanged: (bool value) {
                      setState(() {
                        items[index].checked = value;
                        _checkListItemCrudBloc
                            .requestUpdateListItem(items[index]);
                      });
                    },
                  ),
                  elevation: 16.0,
                ),
          ),
          onRefresh: () {
            return _checkListItemCrudBloc.refresh(parentId);
          },
        );
      },
    );
  }
}
