import 'package:check_list_front_end/bloc/detail/check_list_item_crud_bloc.dart';
import 'package:check_list_front_end/component/list_page_template.dart';
import 'package:check_list_front_end/domain/dto/check_list_item_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'component/check_list_items.dart';

class DetailPage extends StatelessWidget {
  final String parentId;
  final String parentName;

  DetailPage({Key key, this.parentId, this.parentName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CheckListItemCrudBloc bloc = CheckListItemCrudBloc(parentId);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(parentName),
      ),
      body: BlocProvider<CheckListItemCrudBloc>(
        bloc: bloc,
        child: ListPageTemplate(
          callback: () {
            bloc.requestNewListItem(parentId);
          },
          listWidget: CheckListItemsDetailWidget(
            parentId: parentId,
          ),
        ),
      ),
    );
  }
}
