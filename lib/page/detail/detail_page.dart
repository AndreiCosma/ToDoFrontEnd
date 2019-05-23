import 'package:check_list_front_end/bloc/detail/check_list_item_crud_bloc.dart';
import 'package:check_list_front_end/component/list_page_template.dart';
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
        child: ListPageTemplate(
          callback: () {
            _checkListItemCrudBloc.dispatchNewListItem(parentId);
          },
          listWidget: CheckListItemsDetailWidget(
            parentId: parentId,
          ),
        ),
      ),
    );
  }
}
