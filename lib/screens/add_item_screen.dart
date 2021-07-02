import 'package:flutter/material.dart';
import 'main_page.dart';
import 'package:shopping_list/models/list_data.dart';
import 'package:shopping_list/widgets/ShoppingList.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/widgets/ListItem.dart';

class AddItemScreen extends StatefulWidget {
  ShoppingList currentShoppingList;
  AddItemScreen({required this.currentShoppingList});

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {

  @override
  Widget build(BuildContext context) {
    String newItemName = '';
    String newItemQuantity = '';
    String newItemNote = '';

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
              'Add New Item',
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
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.blue,
              onPressed: () {
                print(newItemName);
                print(newItemQuantity);
                print(newItemNote);
                // Provider.of<ListData>(context, listen: false)
                //     .addShoppingList(ShoppingList(
                //   listName: newListName,
                //   priority: newListPriority,
                //   listKey: Provider.of<ListData>(context, listen: false)
                //       .shoppingLists
                //       .length-1,
                // ));
                Provider.of<ListData>(context, listen: false).addListItem(ListItem(
                  itemName: newItemName,
                  itemQuantity: newItemQuantity,
                  itemNote: newItemNote
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
