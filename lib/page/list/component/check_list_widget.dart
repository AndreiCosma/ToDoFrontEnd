import 'package:check_list_front_end/bloc/list/check_list_crud_bloc.dart';
import 'package:check_list_front_end/bloc/list/check_list_events.dart';
import 'package:check_list_front_end/domain/dto/check_list_dto.dart';
import 'package:check_list_front_end/page/detail/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckListWidget extends StatefulWidget {
  @override
  _CheckListWidgetState createState() => _CheckListWidgetState();
}

class _CheckListWidgetState extends State<CheckListWidget> {
  @override
  Widget build(BuildContext context) {
    CheckListCrudBloc _checkListCrudBloc =
        BlocProvider.of<CheckListCrudBloc>(context);

    return BlocBuilder<CheckListEvent, List<CheckListDTO>>(
      bloc: _checkListCrudBloc,
      builder: (context, items) {
        return RefreshIndicator(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              final item = items[index];
              return Dismissible(
                onDismissed: (dismissDirection) {
                  _checkListCrudBloc.dispatch(CheckListDeleteEvent(item.id));
                },
                key: Key(item.toString()),
                child: Card(
                  elevation: 16.0,
                  child: ListTile(
                    onLongPress: () {
                      _checkListCrudBloc.requestDeleteList(item.id);
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                                parentId: item.id,
                                parentName: item.name,
                              ),
                        ),
                      );
                    },
                    leading: Icon(
                      Icons.check_circle_outline,
                      size: 30,
                    ),
                    title: Text(item.name),
                    subtitle: Text(item.creationDate.toIso8601String()),
                  ),
                ),
              );
            },
          ),
          onRefresh: () {
            return _checkListCrudBloc.refresh();
          },
        );
      },
    );
  }
}
