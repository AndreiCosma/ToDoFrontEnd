import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

const kBrandingTextStyle = TextStyle(
    fontSize: 96,
    letterSpacing: -1.5,
    textBaseline: TextBaseline.alphabetic,
    fontWeight: FontWeight.bold);

const kBrandingMessageTextStyle = TextStyle(
    fontSize: 20,
    letterSpacing: 0.15,
    textBaseline: TextBaseline.alphabetic,
    fontWeight: FontWeight.bold);

const kSecondaryTextStyle = TextStyle(
    fontSize: 20,
    letterSpacing: 0.15,
    textBaseline: TextBaseline.alphabetic,
    fontWeight: FontWeight.normal);

const kLogoutTextStyle = TextStyle(
  fontSize: 34,
  letterSpacing: 0.15,
  textBaseline: TextBaseline.alphabetic,
  fontWeight: FontWeight.normal,
  color: Colors.white70,
);

const kCreateAccountTextStyle = TextStyle(
  fontSize: 34,
  letterSpacing: 0.15,
  textBaseline: TextBaseline.alphabetic,
  fontWeight: FontWeight.normal,
  color: Colors.white70,
);

const kFormNameItemDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.black54,
  hintText: 'Username',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(35),
    ),
  ),
  prefixIcon: Icon(Icons.person),
);

const kFormEmailItemDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.black54,
  hintText: 'Email',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(35),
    ),
  ),
  prefixIcon: Icon(Icons.email),
);

const kCommitButtonTextStyle =
    TextStyle(color: Colors.black, fontSize: 20, letterSpacing: 0.15);

const kEditAlertStyle = AlertStyle(
  descStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
);
//check list fields

const kCheckListId = 'id';
const kCheckListName = 'name';
const kCheckListItems = 'items';
const kCheckListCreationDate = 'creationDate';

//check list item fields

const kCheckListItemParentId = 'listId';
const kCheckListItemId = 'id';
const kCheckListItemName = 'name';
const kCheckListItemChecked = 'checked';

// access token dto

const kAccessToken = 'accessToken';
const kRefreshToken = 'refreshToken';

const kClientNameVal = 'e8c3e87d-00fb-428b-888e-dcd6f9b99729';
const kClientSecretVal = 'd8bbe44d-9fab-4725-8f1e-ced5e551bd56';

// user login request

const kUsername = 'username';
const kUserPassword = 'password';
const kDeviceUUID = 'deviceUUID';
const kClientName = 'clientName';
const kClientSecret = 'clientSecret';
const kUserPasswordConfirmation = 'passwordConfirmation';
const kUserRegUsername = 'userName';
const kUserEmail = 'email';
