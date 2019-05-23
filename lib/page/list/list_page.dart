import 'package:check_list_front_end/bloc/list/check_list_crud_bloc.dart';
import 'package:check_list_front_end/bloc/navigation/navigation_bloc.dart';
import 'package:check_list_front_end/component/list_page_template.dart';
import 'package:check_list_front_end/service/user_shared_preferences_service.dart';
import 'package:check_list_front_end/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'component/check_list_widget.dart';

class ListPage extends StatelessWidget {
  final CheckListCrudBloc bloc = CheckListCrudBloc();
  @override
  Widget build(BuildContext context) {
    NavigationBloc _navigationBloc = BlocProvider.of<NavigationBloc>(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 32.0),
              child: InkWell(
                onTap: () {
                  logOut(_navigationBloc, context);
                },
                child: Container(
                  color: Colors.blueAccent,
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'Logout',
                      style: kLogoutTextStyle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('To-Do'),
      ),
      body: BlocProvider<CheckListCrudBloc>(
        bloc: bloc,
        child: ListPageTemplate(
          callback: () {
            bloc.dispatchCreateNewList();
          },
          listWidget: CheckListWidget(),
        ),
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
