import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'package:shopping_list/widgets/ShoppingList.dart';
import 'package:shopping_list/widgets/ListItem.dart';
import 'package:shopping_list/db_helper.dart';

class ListData extends ChangeNotifier {

  int currentShoppingListIndex = -1;

  List<ShoppingList> shoppingLists = [
    // ShoppingList(name: 'Fruit', priority: '1', items: [
    //   ListItem(itemName: 'Oranges', itemQuantity: '10', itemNote: 'hi', itemKey: '1'),
    //   ListItem(itemName: 'Apples', itemQuantity: '65', itemNote: 'now', itemKey: '1'),
    // ]),
    // ShoppingList(name: 'Vegetables', priority: '2', items: [
    //   ListItem(itemName: 'Lettuce', itemQuantity: '10', itemNote: 'hi', itemKey: '1'),
    // ]),
    // ShoppingList(name: 'Bakery', priority: '1', items: [
    //   ListItem(itemName: 'Bread', itemQuantity: '10', itemNote: 'hi', itemKey: '1'),
    // ]),
  ];

  ListData() {
    start();
  }

  void start() async {
    shoppingLists = await DbHelper.getAllShoppingLists();
    // if (shoppingLists.isEmpty) {
    //   addShoppingList(ShoppingList(name: 'Fruit', priority: '1'));
    //   addListItemToList(shoppingLists[0], ListItem(itemName: 'Oranges', itemQuantity: '10', itemNote: 'hi', idList: shoppingLists[0].id));
    //   addListItemToList(shoppingLists[0], ListItem(itemName: 'Apples', itemQuantity: '65', itemNote: 'now', idList: shoppingLists[0].id));
    //
    //   addShoppingList(ShoppingList(name: 'Vegetables', priority: '2'));
    //   addListItemToList(shoppingLists[1], ListItem(itemName: 'Lettuce', itemQuantity: '10', itemNote: 'hi', idList: shoppingLists[1].id));
    //
    //   addShoppingList(ShoppingList(name: 'Bakery', priority: '1'));
    //   addListItemToList(shoppingLists[2], ListItem(itemName: 'Bread', itemQuantity: '10', itemNote: 'hi', idList: shoppingLists[2].id));
    // }
    for (ShoppingList shoppingList in shoppingLists) {
      shoppingList.items = await DbHelper.getAllListItems(shoppingList.id);
    }
    notifyListeners();
  }

  getListItems() {
    return shoppingLists[currentShoppingListIndex].items;
  }

  addShoppingList(ShoppingList shoppingList) async {
    await DbHelper.insertShoppingList(shoppingList);
    shoppingLists.add(shoppingList);
    notifyListeners();
    return shoppingList.id;
  }

  deleteShoppingList(ShoppingList shoppingList) async {
    await DbHelper.deleteShoppingList(shoppingList.id);
    shoppingLists.remove(shoppingList);
    notifyListeners();
  }

  addListItem(ListItem listItem) async {
    await DbHelper.insertListItem(listItem);
    shoppingLists[currentShoppingListIndex].items.add(listItem);
    notifyListeners();
  }

  addListItemToList(ShoppingList shoppingList, ListItem listItem) async {
    listItem.idList = shoppingList.id;
    ListItem newListItem = await DbHelper.insertListItem(listItem);
    shoppingList.items.add(newListItem);
    notifyListeners();
  }

  deleteListItem(ListItem listItem) async {
    await DbHelper.deleteListItem(listItem.id);
    shoppingLists[currentShoppingListIndex].items.remove(listItem);
    notifyListeners();
  }

  editShoppingList(ShoppingList shoppingList, String newListName, String newListPriority) {
    print(shoppingLists[shoppingLists.indexOf(shoppingList)].name);
    print(shoppingLists[shoppingLists.indexOf(shoppingList)].priority);
    shoppingLists[shoppingLists.indexOf(shoppingList)].name = newListName;
    shoppingLists[shoppingLists.indexOf(shoppingList)].priority = newListPriority;
    print(shoppingLists[shoppingLists.indexOf(shoppingList)].name);
    print(shoppingLists[shoppingLists.indexOf(shoppingList)].priority);

    DbHelper.updateShoppingList(shoppingList);
    start();
    notifyListeners();
  }

  editItem(ShoppingList shoppingList, ListItem listItem, String newItemName, String newItemQuantity, String newItemNote) {
    shoppingLists[shoppingLists.indexOf(shoppingList)].items[shoppingLists[shoppingLists.indexOf(shoppingList)].items.indexOf(listItem)].itemName = newItemName;
    shoppingLists[shoppingLists.indexOf(shoppingList)].items[shoppingLists[shoppingLists.indexOf(shoppingList)].items.indexOf(listItem)].itemQuantity = newItemQuantity;
    shoppingLists[shoppingLists.indexOf(shoppingList)].items[shoppingLists[shoppingLists.indexOf(shoppingList)].items.indexOf(listItem)].itemNote = newItemNote;

    DbHelper.updateListItem(listItem);
    start();
    notifyListeners();
  }
}