import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/ListItem.dart';
import 'add_item_screen.dart';
import 'package:shopping_list/widgets/ShoppingList.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/models/list_data.dart';

class ListPage extends StatelessWidget {
  final String itemListName;
  final List<ListItem> itemList;
  ShoppingList currentShoppingList;

  ListPage({required this.itemListName, required this.itemList, required this.currentShoppingList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$itemListName',
          style: TextStyle(fontSize: 25.0),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {Navigator.pop(context);},
        )
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                    child:Container(
                      // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddItemScreen(currentShoppingList: currentShoppingList),
                    )
                )
            );
          }
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: Provider.of<ListData>(context, listen: true).getListItems(),
        ),
      ),
    );
  }
}
