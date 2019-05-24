import 'package:check_list_front_end/bloc/list/check_list_crud_bloc.dart';
import 'package:check_list_front_end/bloc/list/check_list_events.dart';
import 'package:check_list_front_end/bloc/list/check_list_state.dart';
import 'package:check_list_front_end/domain/dto/check_list_dto.dart';
import 'package:check_list_front_end/page/detail/detail_page.dart';
import 'package:check_list_front_end/util/constants.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CheckListWidget extends StatefulWidget {
  @override
  _CheckListWidgetState createState() => _CheckListWidgetState();
}

class _CheckListWidgetState extends State<CheckListWidget> {
  @override
  Widget build(BuildContext context) {
    CheckListCrudBloc _checkListCrudBloc =
        BlocProvider.of<CheckListCrudBloc>(context);

    return RefreshIndicator(
      onRefresh: () {
        return _checkListCrudBloc.refresh();
      },
      child: BlocBuilder<CheckListEvent, CheckListPageState>(
        bloc: _checkListCrudBloc,
        builder: (context, state) {
          print('Check Lists COUNT ---> ${state.items.length}');
          return ListView.separated(
            separatorBuilder: (context, int) => Divider(
                  height: 1,
                ),
            itemCount: state.items.length,
            itemBuilder: (BuildContext context, int index) {
              final item = state.items[index];
              if (item != null) {
                return Dismissible(
                  background: Container(
                    color: Colors.redAccent,
                  ),
                  onDismissed: (dismissDirection) {
                    _checkListCrudBloc.dispatchDeleteList(item);
                  },
                  key: Key(item.id),
                  child: ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Theme.of(context).accentColor,
                    ),
                    onLongPress: () {
                      //Show edit alert dialog
                      showEditDialog(item, _checkListCrudBloc);
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                                parentName: item.name,
                                parentId: item.id,
                              ),
                        ),
                      );
                    },
                    title: Text(item.name),
                    subtitle: Text(formatDate(item.creationDate,
                        [yyyy, '-', MM, '-', dd, ' ', hh, ':', mm])),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  void showEditDialog(CheckListDTO item, CheckListCrudBloc bloc) {
    TextEditingController nameEditController =
        TextEditingController(text: item.name);
    Alert(
        style: kEditAlertStyle,
        context: context,
        title: ' ',
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
              bloc.dispatchUpdateList(item);
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
