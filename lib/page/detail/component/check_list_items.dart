import 'package:check_list_front_end/bloc/detail/check_list_item_crud_bloc.dart';
import 'package:check_list_front_end/bloc/detail/check_list_item_detail_page_state.dart';
import 'package:check_list_front_end/bloc/detail/check_list_item_events.dart';
import 'package:check_list_front_end/domain/dto/check_list_item_dto.dart';
import 'package:check_list_front_end/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CheckListItemsDetailWidget extends StatefulWidget {
  final String parentId;

  CheckListItemsDetailWidget({Key key, this.parentId}) : super(key: key);

  @override
  _CheckListItemsDetailWidgetState createState() =>
      _CheckListItemsDetailWidgetState(parentId: parentId);
}

class _CheckListItemsDetailWidgetState
    extends State<CheckListItemsDetailWidget> {
  String parentId;

  _CheckListItemsDetailWidgetState({this.parentId});

  @override
  Widget build(BuildContext context) {
    CheckListItemCrudBloc _checkListItemCrudBloc =
        BlocProvider.of<CheckListItemCrudBloc>(context);

    return RefreshIndicator(
      onRefresh: () {
        return _checkListItemCrudBloc.refresh(parentId);
      },
      child: BlocBuilder<CheckListItemEvent, CheckListItemDetailPageState>(
        bloc: _checkListItemCrudBloc,
        builder: (context, state) {
          print('Check list ITEM COUNT ---> ${state.items.length}');
          return ListView.builder(
            itemCount: state.items.length,
            itemBuilder: (BuildContext context, int index) {
              final item = state.items[index];
              if (item != null) {
                return Dismissible(
                  onDismissed: (dismissDirection) {
                    _checkListItemCrudBloc.dispatchDeleteListItem(item);
                  },
                  key: Key(item.id),
                  child: Card(
                    child: InkWell(
                      onLongPress: () {
                        showEditDialog(item, _checkListItemCrudBloc);
                      },
                      child: CheckboxListTile(
                        title: Text(item.name),
                        value: item.checked,
                        onChanged: (bool value) {
                          setState(() {
                            item.checked = value;
                          });
                          _checkListItemCrudBloc.dispatchUpdateListItem(item);
                        },
                      ),
                    ),
                    elevation: 16.0,
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  void showEditDialog(CheckListItemDTO item, CheckListItemCrudBloc bloc) {
    TextEditingController nameEditController =
        TextEditingController(text: item.name);
    Alert(
        context: context,
        title: ' ',
        style: kEditAlertStyle,
        content: Column(
          children: <Widget>[
            TextField(
              controller: nameEditController,
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              item.name = nameEditController.text;
              bloc.dispatchUpdateListItem(item);
              Navigator.pop(context);
            },
            child: Text(
              "COMMIT",
              style: kCommitButtonTextStyle,
            ),
          )
        ]).show();
  }
}
