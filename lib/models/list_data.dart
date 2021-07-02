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
    if (shoppingLists.isEmpty) {
      // addShoppingList(ShoppingList(name: 'Fruit', priority: '1', items: [
      //   ListItem(itemName: 'Oranges', itemQuantity: '10', itemNote: 'hi', idList: ),
      //   ListItem(itemName: 'Apples', itemQuantity: '65', itemNote: 'now', ),
      // ]));
      // addShoppingList(ShoppingList(name: 'Vegetables', priority: '2', items: [
      //   ListItem(itemName: 'Lettuce', itemQuantity: '10', itemNote: 'hi', itemKey: '1'),
      // ]));
      // addShoppingList(ShoppingList(name: 'Bakery', priority: '1', items: [
      //   ListItem(itemName: 'Bread', itemQuantity: '10', itemNote: 'hi', itemKey: '1'),
      // ]));
      addShoppingList(ShoppingList(name: 'Fruit', priority: '1'));
      addListItemToList(shoppingLists[0], ListItem(itemName: 'Oranges', itemQuantity: '10', itemNote: 'hi'));
      addListItemToList(shoppingLists[0], ListItem(itemName: 'Apples', itemQuantity: '65', itemNote: 'now'));

      addShoppingList(ShoppingList(name: 'Vegetables', priority: '2'));
      addListItemToList(shoppingLists[1], ListItem(itemName: 'Lettuce', itemQuantity: '10', itemNote: 'hi'));

      addShoppingList(ShoppingList(name: 'Bakery', priority: '2'));
      addListItemToList(shoppingLists[2], ListItem(itemName: 'Bread', itemQuantity: '10', itemNote: 'hi'));
    }
    notifyListeners();
  }

  getListItems() {
    return shoppingLists[currentShoppingListIndex].items;
  }

  addShoppingList(ShoppingList shoppingList) {
    DbHelper.insertShoppingList(shoppingList);
    shoppingLists.add(shoppingList);
    notifyListeners();
    return shoppingList.id;
  }

  deleteShoppingList(ShoppingList shoppingList) {
    DbHelper.deleteShoppingList(shoppingList.id);
    shoppingLists.remove(shoppingList);
    notifyListeners();
  }

  addListItem(ListItem listItem) {
    shoppingLists[currentShoppingListIndex].items.add(listItem);
    notifyListeners();
  }

  addListItemToList(ShoppingList shoppingList, ListItem listItem) {
    shoppingList.items.add(listItem);
  }

  deleteListItem(ListItem listItem) {
    shoppingLists[currentShoppingListIndex].items.remove(listItem);
    notifyListeners();
  }
}