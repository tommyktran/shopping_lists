import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/ListItem.dart';
import 'main_page.dart';
import 'package:shopping_list/models/list_data.dart';
import 'package:shopping_list/widgets/ShoppingList.dart';
import 'package:provider/provider.dart';

class EditItemScreen extends StatefulWidget {
  ShoppingList thisShoppingList;
  ListItem thisListItem;

  EditItemScreen({required this.thisShoppingList, required this.thisListItem});

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  @override
  Widget build(BuildContext context) {
    String newItemName = '';
    String newItemQuantity = '';
    String newItemNote = '';


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
              'Edit Item',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 27.0,
                color: Colors.blue,
              ),
            ),
            TextField(
              autofocus: true,
              onChanged: (newText) {
                newItemName = newText;
              },
            ),
            TextField(
              autofocus: false,
              onChanged: (newText) {
                newItemQuantity = newText;
              },
            ),
            TextField(
              autofocus: false,
              onChanged: (newText) {
                newItemNote = newText;
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
                Provider.of<ListData>(context, listen: false).editItem(widget.thisShoppingList, widget.thisListItem, newItemName, newItemQuantity, newItemNote);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
