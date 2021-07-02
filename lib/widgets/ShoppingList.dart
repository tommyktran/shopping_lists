import 'package:flutter/material.dart';
import 'package:shopping_list/models/list_data.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/screens/list_page.dart';
import 'package:shopping_list/widgets/ListItem.dart';
import 'package:shopping_list/screens/edit_list_screen.dart';

class ShoppingList extends StatelessWidget {
  String name;
  String priority;
  List<ListItem> items = [];
  int id;

  ShoppingList({required this.name, required this.priority, this.id = 0});

  Map<String, dynamic> toMap() {
    return {
      'id': (id==0) ? null : id,
      'name': name,
      'priority': priority,
    };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<ListData>(context, listen: false).currentShoppingListIndex = Provider.of<ListData>(context, listen: false).shoppingLists.indexOf(this);
        print(Provider.of<ListData>(context, listen: false).currentShoppingListIndex);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListPage(
            currentShoppingList: this,
            itemList: items,
            itemListName: name,
          ))
        );
      },
      child: Dismissible(
        key: Key('$id'),
        onDismissed: (dismissDirection) => Provider.of<ListData>(context, listen: false).deleteShoppingList(this),
        direction: DismissDirection.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20.0,),
                    alignment: Alignment.center,
                    child: Text(
                      '$priority',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                    ),
                    height: 45.0,
                    width: 45.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text('$name',
                    style: TextStyle(
                      fontSize: 22.0,
                    ),),
                ],
              ),
              IconButton(
                icon: Icon(Icons.edit, size: 30.0),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => SingleChildScrollView(
                          child:Container(
                            // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                            child: EditListScreen(thisShoppingList: this),
                          )
                      )
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}