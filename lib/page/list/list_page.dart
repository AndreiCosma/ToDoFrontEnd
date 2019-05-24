import 'package:check_list_front_end/bloc/list/check_list_crud_bloc.dart';
import 'package:check_list_front_end/bloc/navigation/navigation_bloc.dart';
import 'package:check_list_front_end/service/user_shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'component/check_list_widget.dart';

class ListPage extends StatelessWidget {
  final CheckListCrudBloc bloc = CheckListCrudBloc();

  @override
  Widget build(BuildContext context) {
    NavigationBloc _navigationBloc = BlocProvider.of<NavigationBloc>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => bloc.dispatchCreateNewList()),
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('To-Do'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => logOut(_navigationBloc, context),
          ),
        ],
      ),
      body: BlocProvider<CheckListCrudBloc>(
        bloc: bloc,
        child: CheckListWidget(),
      ),
    );
  }

  void logOut(NavigationBloc nb, BuildContext context) async {
    try {
      UserSharedPreferencesService userSharedPreferencesService =
          UserSharedPreferencesService();

      await userSharedPreferencesService.deleteRefreshToken();
      await userSharedPreferencesService.deleteToken();
      print('!HAS RT ->>' +
          (await userSharedPreferencesService.hasRefreshToken()).toString());
      nb.dispatchNavigationEventLogin();
    } catch (e) {
      print(e);
    }
  }
}
