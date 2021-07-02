import 'package:flutter/material.dart';
import 'package:shopping_list/models/list_data.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/screens/edit_item_screen.dart';
import 'package:shopping_list/widgets/ShoppingList.dart';

class ListItem extends StatelessWidget {
  String itemName;
  String itemQuantity;
  String itemNote;
  int id;
  int idList;

  ListItem({required this.itemName, required this.itemQuantity, required this.itemNote, this.id = 0, this.idList = 0});

  Map<String, dynamic> toMap() {
    return {
      'id': (id==0) ? null : id,
      'itemName': itemName,
      'itemQuantity': itemQuantity,
      'itemNote': itemNote,
      'idList': idList
    };
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('$id'),
      onDismissed: (dismissDirection) => Provider.of<ListData>(context, listen: false).deleteListItem(this),
      direction: DismissDirection.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$itemName',
                  style: TextStyle(
                    fontSize: 22.0,
                  ),),
                Text('Quantity: $itemQuantity - Note: $itemNote',
                style: TextStyle(
                  fontSize: 19.0,
                  color: Colors.grey
                ))
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
                          child: EditItemScreen(thisShoppingList: ),
                        )
                    )
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}