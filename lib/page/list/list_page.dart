import 'package:check_list_front_end/component/list_page_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/check_list_crud_bloc.dart';
import 'component/check_list_widget.dart';

class ListPage extends StatelessWidget {
  ListPage({Key key}) : super(key: key);

  final CheckListCrudBloc bloc = CheckListCrudBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text('To-Do'),
      ),
      body: BlocProvider<CheckListCrudBloc>(
        bloc: bloc,
        child: ListPageTemplate(
          callback: () {
            bloc.dispatch(
              CheckListEvent(CheckListEvents.CREATE, null),
            );
          },
          listWidget: CheckListWidget(),
        ),
      ),
    );
  }
}
