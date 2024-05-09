import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Recipesmodel {
  final String recipesName;
  final String recipesType;
  final List<dynamic> recipesIngredient;
  final List<dynamic> recipesMack;
  final String recipesImage;

  static var length;

  Recipesmodel(
      {required this.recipesName,
      required this.recipesImage,
      required this.recipesType,
        required this.recipesIngredient,
       required this.recipesMack,

      });

  factory Recipesmodel.fromFirestore(DocumentSnapshot doc) {
    Map? data = doc.data() as Map?;
    return Recipesmodel(
        recipesName: data!["recipesName"],
        recipesImage: data["recipesImage"],
        recipesType: data["recipesType"] ,
        recipesIngredient: data["recipesIngredient"],
        recipesMack: data["recipesMack"],

    );
  }
}

class Drinksmodel {
  final String drinkName;
  final List<dynamic> drinkIngredient;
  final List<dynamic> drinkMack;
  final String drinkImage;
  final String drinktpye;

  static var length;

  Drinksmodel(
      {required this.drinkName,
      required this.drinkImage,
      required this.drinktpye,
        required this.drinkIngredient,
       required this.drinkMack,

      });

  factory Drinksmodel.fromFirestore(DocumentSnapshot doc) {
    Map? data = doc.data() as Map?;
    return Drinksmodel(
      drinkName: data!["drinkName"],
      drinkImage: data["drinkImage"],
      drinktpye: data["recipesType"] ?? "",
      drinkIngredient: data["drinkIngredient"],
      drinkMack: data["drinkMack"],

    );
  }
}

