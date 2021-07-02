import 'package:flutter/material.dart';
import 'package:shopping_list/models/list_data.dart';
import '../widgets/ShoppingList.dart';
import 'add_list_screen.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  // List<ShoppingList> shoppingLists = [
  //   ShoppingList(listName: 'Fruit', priority: '1', listKey: 1),
  //   ShoppingList(listName: 'Vegetables', priority: '2', listKey: 1),
  //   ShoppingList(listName: 'Bakery', priority: '1', listKey: 1),
  // ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopping List',
          style: TextStyle(fontSize: 25.0),
        ),
        leading: SizedBox(width: 0.0),
        leadingWidth: 4.0,
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
                    child: AddListScreen(),
                  )
              )
          );
        }
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<ListData>(
          builder: (context, listData, child) {
            return Column(children: listData.shoppingLists);
          },
        ),
      ),
    );
  }
}


