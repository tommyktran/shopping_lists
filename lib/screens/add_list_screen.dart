import 'package:flutter/material.dart';
import 'main_page.dart';
import 'package:shopping_list/models/list_data.dart';
import 'package:shopping_list/widgets/ShoppingList.dart';
import 'package:provider/provider.dart';

class AddListScreen extends StatefulWidget {
  @override
  _AddListScreenState createState() => _AddListScreenState();
}

class _AddListScreenState extends State<AddListScreen> {
  @override
  Widget build(BuildContext context) {
    String newListName = '';
    String newListPriority = '';

    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
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
              'Add Shopping List',
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
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.blue,
              onPressed: () {
                print(newListName);
                print(newListPriority);
                Provider.of<ListData>(context, listen: false)
                    .addShoppingList(ShoppingList(
                  name: newListName,
                  priority: newListPriority
                ));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
