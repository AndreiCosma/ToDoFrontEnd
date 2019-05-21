import 'package:flutter/material.dart';

const kBrandingTextStyle = TextStyle(
    fontSize: 96,
    letterSpacing: -1.5,
    textBaseline: TextBaseline.alphabetic,
    fontWeight: FontWeight.bold,
    color: Colors.white70);

const kBrandingMessageTextStyle = TextStyle(
    fontSize: 20,
    letterSpacing: 0.15,
    textBaseline: TextBaseline.alphabetic,
    fontWeight: FontWeight.bold,
    color: Colors.white70);

const kSecondaryTextStyle = TextStyle(
    fontSize: 20,
    letterSpacing: 0.15,
    textBaseline: TextBaseline.alphabetic,
    fontWeight: FontWeight.normal,
    color: Colors.white70);

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
