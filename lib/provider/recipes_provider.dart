import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:recipes_app/model/favourite_model.dart';
import 'package:recipes_app/model/recipes_model.dart';

class RecipesProvider with ChangeNotifier {
  List<Recipesmodel>? _recipesList;
  List<Recipesmodel> get recipesList => _recipesList!;

  List<Drinksmodel>? _drinkList;
  List<Drinksmodel> get drinkList => _drinkList!;

  List<RecipesCartmodel>? _recipesCartList;
  List<RecipesCartmodel> get recipesCartList => _recipesCartList!;

  List<DrinksCartmodel>? _drinkCartList;
  List<DrinksCartmodel> get drinkCartList => _drinkCartList!;

  fetchRecipesData() async {
    List<Recipesmodel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("Recipes").get();
    value.docs.forEach((element) {
      newList.add(
        Recipesmodel.fromFirestore(element),
      );
    });
    _recipesList = newList;
    notifyListeners();
  }

  Future<void> fetchRecipesCartData() async {
    List<RecipesCartmodel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("favourite_Recipes").get();
    value.docs.forEach((element) {
      newList.add(
        RecipesCartmodel.fromFirestore(element),
      );
    });
    _recipesCartList = newList;
    notifyListeners();
  }

  Future<void> fetchDrinkCartData() async {
    List<DrinksCartmodel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("favourite_Drink").get();
    value.docs.forEach((element) {
      newList.add(
        DrinksCartmodel.fromFirestore(element),
      );
    });
    _drinkCartList = newList;
    notifyListeners();
  }

  Future<void> fetchDrinkData() async {
    List<Drinksmodel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("Drink").get();
    value.docs.forEach((element) {
      newList.add(
        Drinksmodel.fromFirestore(element),
      );
    });
    _drinkList = newList;
    notifyListeners();
  }

  Future<bool> addCartRecipesData(
      {required RecipesCartmodel data,
      required bool value,
      required String name}) async {
    try {
      if (value == false) {
        await FirebaseFirestore.instance
            .collection("favourite_Recipes")
            .doc(name)
            .set(data.toMap());
        return true;
      } else {
        await FirebaseFirestore.instance
            .collection("favourite_Recipes")
            .doc(name)
            .delete();
        return false;
      }
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<bool> addCartDrinkData(
      {required DrinksCartmodel data,
      required bool value,
      required String name}) async {
    try {
      if (value == false) {
        await FirebaseFirestore.instance
            .collection("favourite_Drink")
            .doc(name)
            .set(data.toMap());
        return true;
      } else {
        await FirebaseFirestore.instance
            .collection("favourite_Drink")
            .doc(name)
            .delete();
        return false;
      }
    } catch (err) {
      print(err);
      return false;
    }
  }
}
