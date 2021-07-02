import 'package:flutter/material.dart';
import 'main_page.dart';
import 'package:shopping_list/models/list_data.dart';
import 'package:shopping_list/widgets/ShoppingList.dart';
import 'package:provider/provider.dart';

class EditListScreen extends StatefulWidget {
  ShoppingList thisShoppingList;

  EditListScreen({required this.thisShoppingList});

  @override
  _EditListScreenState createState() => _EditListScreenState();
}

class _EditListScreenState extends State<EditListScreen> {
  @override
  Widget build(BuildContext context) {
    String newListName = '';
    String newListPriority = '';


    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Edit Shopping List',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 27.0,
                color: Colors.blue,
              ),
            ),
            TextField(
              autofocus: true,
              onChanged: (newText) {
                newListName = newText;
              },
            ),
            TextField(
              autofocus: false,
              onChanged: (newText) {
                newListPriority = newText;
              },
            ),
            SizedBox(height: 10.0),
            FlatButton(
              child: Text(
                'Edit',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.blue,
              onPressed: () {
                print(newListName);
                print(newListPriority);
                Provider.of<ListData>(context, listen: false).editShoppingList(widget.thisShoppingList, newListName, newListPriority);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
