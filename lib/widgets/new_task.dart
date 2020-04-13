import 'package:flutter/material.dart';

class NewTask extends StatefulWidget {
  final Function addTx;

  NewTask(this.addTx);
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredDescription = _descriptionController.text;

    if (enteredTitle.isEmpty || enteredDescription.isEmpty) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredDescription,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          margin: EdgeInsets.all(10),
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Description'),
                controller: _descriptionController,
                onSubmitted: (_) => _submitData(),
              ),
              Divider(),
              RaisedButton(
                onPressed: _submitData,
                child: Text('Add Transaction'),
                textColor: Theme.of(context).textTheme.button.color,
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
