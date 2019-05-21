import 'package:check_list_front_end/domain/dto/check_list_dto.dart';
import 'package:check_list_front_end/page/list/list_page.dart';
import 'package:check_list_front_end/service/json_service.dart';
import 'package:check_list_front_end/service/network_service.dart';
import 'package:check_list_front_end/util/constants.dart';
import 'package:flutter/material.dart';

import 'component/credential.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomPadding: false,
        drawer: Drawer(),
        body: Container(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/login.png'),
              ),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Hello',
                        style: kBrandingTextStyle,
                      ),
                      Text(
                        'Sign in to your account',
                        style: kBrandingMessageTextStyle,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: CredentialWidget(),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 24,
                            letterSpacing: 0.0,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListPage(),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.arrow_forward,
                            size: 36,
                            color: Colors.white70,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: Colors.white70),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      InkWell(
                        onTap: () {
                          print('create tap');
                        },
                        child: Text(
                          'Create',
                          style: TextStyle(
                              color: Colors.white70,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Future<List<CheckListDTO>> getCheckLists() async {
    NetworkService networkService = NetworkService();
    JsonService jsonService = JsonService();
    return jsonService.decodeCheckLists(await networkService.getCheckLists());
  }
}
