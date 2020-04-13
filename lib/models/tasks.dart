import 'package:flutter/material.dart';

class Tasks {
  String id;
  String title;
  String description;
  DateTime addedOn;
  bool isPending;

  Tasks({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.addedOn,
    @required this.isPending,
  });
}
