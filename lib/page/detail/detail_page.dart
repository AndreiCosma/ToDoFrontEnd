import 'package:check_list_front_end/bloc/detail/check_list_item_crud_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'component/check_list_items.dart';

class DetailPage extends StatefulWidget {
  final String parentId;
  final String parentName;

  DetailPage({this.parentName, this.parentId});

  @override
  _DetailPage createState() => _DetailPage(parentId, parentName);
}

class _DetailPage extends State<DetailPage> {
  CheckListItemCrudBloc _checkListItemCrudBloc;
  final String parentId;
  final String parentName;

  _DetailPage(this.parentId, this.parentName) {
    print('_DetailPage constructor called');
    _checkListItemCrudBloc = CheckListItemCrudBloc(parentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(parentName),
      ),
      body: BlocProvider<CheckListItemCrudBloc>(
          bloc: _checkListItemCrudBloc,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 9,
                  child: CheckListItemsDetailWidget(
                    parentId: parentId,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    onPressed: () {
                      _checkListItemCrudBloc.dispatchNewListItem(parentId);
                    },
                    child: Container(
                      child: Center(
                        child: Text('+ Add New'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
