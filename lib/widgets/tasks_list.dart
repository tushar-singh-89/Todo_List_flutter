import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../models/tasks.dart';

class TasksList extends StatelessWidget {
  final List<Tasks> usertasks;
  final Function deletetask;
  final Function swaptask;

  TasksList(this.usertasks, this.deletetask, this.swaptask);

  @override
  Widget build(BuildContext context) {
    return usertasks.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No Tasks added yet !!!',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: usertasks[index].isPending
                      ? IconButton(
                          iconSize: 32,
                          icon: FaIcon(FontAwesomeIcons.solidCalendarPlus),
                          onPressed: () => swaptask(index),
                          color: Colors.orange,
                        )
                      : IconButton(
                          iconSize: 32,
                          icon: FaIcon(FontAwesomeIcons.solidCalendarCheck),
                          onPressed: () => swaptask(index),
                          color: Colors.green,
                        ),
                  title: Text(
                    usertasks[index].title,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  subtitle: Text(
                    '${usertasks[index].description}\nAdded On : ${DateFormat.yMMMd().format(usertasks[index].addedOn)}',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deletetask(usertasks[index].id),
                    color: Theme.of(context).errorColor,
                    iconSize: 32,
                  ),
                  isThreeLine: true,
                ),
              );
            },
            itemCount: usertasks.length,
          );
  }
}
