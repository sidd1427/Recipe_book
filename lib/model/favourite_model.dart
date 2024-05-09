import 'package:cloud_firestore/cloud_firestore.dart';

class RecipesCartmodel {
  final String recipesName;
  final String recipesType;
  final String recipesImage;

  static var length;

  RecipesCartmodel(
      {required this.recipesName,
        required this.recipesImage,
        required this.recipesType,

      });

  factory RecipesCartmodel.fromFirestore(DocumentSnapshot doc) {
    Map? data = doc.data() as Map?;
    return RecipesCartmodel(
      recipesName: data!["recipesName"],
      recipesImage: data["recipesImage"],
      recipesType: data["recipesType"] ,

    );
  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> data = {
      "recipesName" : recipesName,
      "recipesImage" : recipesImage,
      "recipesType" : recipesType,
    };
    return data;
  }
}

class DrinksCartmodel {
  final String drinkName;
  final String drinkImage;
  final String drinktpye;

  DrinksCartmodel(
      {required this.drinkName,
        required this.drinkImage,
        required this.drinktpye,
      });

  factory DrinksCartmodel.fromFirestore(DocumentSnapshot doc) {
    Map? data = doc.data() as Map?;
    return DrinksCartmodel(
      drinkName: data!["drinkName"],
      drinkImage: data["drinkImage"],
      drinktpye: data["recipesType"] ?? "",

    );
  }
  Map<String,dynamic> toMap(){
    Map<String,dynamic> data = {
      "drinkName" : drinkName,
      "drinkImage" : drinkImage,
      "recipesType" : drinktpye,
    };
    return data;
  }

}
