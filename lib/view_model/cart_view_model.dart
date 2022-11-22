import 'package:flutter/widgets.dart';
import 'package:zartek_machine/data/model/restuarant_model.dart';

class CartViewModel extends ChangeNotifier{
 List<CategoryDishes> categoryDishes = [];
  double totalPrize = 0;
  int totalItemCount = 0;
   addItem(CategoryDishes item) {
    if (!categoryDishes.contains(item)) {
      categoryDishes.add(item);
    }
    categoryDishes[categoryDishes.indexOf(item)].quantity ++ ;
    totalPrize += item.dishPrice!;
    notifyListeners();
  }

  removeItem(CategoryDishes item) {
    if (item.quantity > 0) {
      if (item.quantity == 1) {
        categoryDishes.remove(item);
      }
      item.quantity --;
      totalPrize -= item.dishPrice!;
      totalItemCount--;
      notifyListeners();
    }
  }

  cleaProducts(){
    categoryDishes.clear();
    notifyListeners();
  }
}
