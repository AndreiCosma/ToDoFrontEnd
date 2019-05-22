import 'package:check_list_front_end/bloc/list/check_list_crud_bloc.dart';
import 'package:check_list_front_end/component/list_page_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'component/check_list_widget.dart';

class ListPage extends StatelessWidget {
  final CheckListCrudBloc bloc = CheckListCrudBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      drawer: Drawer(),
      appBar: AppBar(
        title: Text('To-Do'),
      ),
      body: BlocProvider<CheckListCrudBloc>(
        bloc: bloc,
        child: ListPageTemplate(
          callback: () {
            bloc.requestCreateNewList();
          },
          listWidget: CheckListWidget(),
        ),
      ),
    );
  }
}
