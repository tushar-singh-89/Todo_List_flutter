import 'package:flutter/material.dart';
import './widgets/new_task.dart';
import './models/tasks.dart';
import './widgets/tasks_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO - List',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline1: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final List<Tasks> _usertasks = [
    // This was a dummy data to check !!
    // Tasks(
    //   id: 't1',
    //   title: 'Task1',
    //   description: 'This is a sample task',
    //   addedOn: DateTime.now(),
    //   isPending: true,
    // ),
    // Tasks(
    //   id: 't2',
    //   title: 'Task2',
    //   description: 'This is a sample task',
    //   addedOn: DateTime.now(),
    //   isPending: true,
    // ),
    // Tasks(
    //   id: DateTime.now().toString(),
    //   title: 'Task3',
    //   description: 'This is a sample task',
    //   addedOn: DateTime.now(),
    //   isPending: false,
    // ),
    // Tasks(
    //   id: 't4',
    //   title: 'Task4',
    //   description: 'This is a sample task',
    //   addedOn: DateTime.now(),
    //   isPending: true,
    // ),
    // Tasks(
    //   id: 't5',
    //   title: 'Task5',
    //   description: 'This is a sample task',
    //   addedOn: DateTime.now(),
    //   isPending: true,
    // ),
    // Tasks(
    //   id: DateTime.now().toString(),
    //   title: 'Task6',
    //   description: 'This is a sample task',
    //   addedOn: DateTime.now(),
    //   isPending: false,
    // ),
    // Tasks(
    //   id: 't1',
    //   title: 'Task1',
    //   description: 'This is a sample task',
    //   addedOn: DateTime.now(),
    //   isPending: true,
    // ),
    // Tasks(
    //   id: 't2',
    //   title: 'Task2',
    //   description: 'This is a sample task',
    //   addedOn: DateTime.now(),
    //   isPending: true,
    // ),
    // Tasks(
    //   id: DateTime.now().toString(),
    //   title: 'Task3',
    //   description: 'This is a sample task',
    //   addedOn: DateTime.now(),
    //   isPending: false,
    // ),
  ];

  Widget _buildNotification(BuildContext context) {
    return Stack(
      children: <Widget>[
        IconButton(
          iconSize: 28,
          icon: Icon(Icons.notifications),
          onPressed: () {},
        ),
        _counter != 0
            ? Positioned(
                left: 8,
                top: 11,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    '$_counter',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  void _addNewTasks(String txTitle, String txDescription) {
    final newTask = Tasks(
      id: DateTime.now().toString(),
      title: txTitle,
      description: txDescription,
      addedOn: DateTime.now(),
      isPending: true,
    );

    setState(() {
      _usertasks.add(newTask);
      _counter =
          _usertasks.where((element) => element.isPending == true).length;
    });
  }

  void _startAddNewTask(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: NewTask(_addNewTasks),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTask(String id) {
    setState(() {
      _usertasks.removeWhere((element) => element.id == id);
      _counter =
          _usertasks.where((element) => element.isPending == true).length;
    });
  }

  void _swapTask(int index) {
    setState(() {
      _usertasks[index].isPending
          ? _usertasks[index].isPending = false
          : _usertasks[index].isPending = true;
      _counter =
          _usertasks.where((element) => element.isPending == true).length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TODO - List',
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          _buildNotification(context),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTask(context),
            iconSize: 28,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.87,
            child: TasksList(_usertasks, _deleteTask, _swapTask),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTask(context),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
