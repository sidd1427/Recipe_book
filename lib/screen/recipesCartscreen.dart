import 'package:flutter/material.dart';
import 'package:recipes_app/model/favourite_model.dart';

class Favscreen2 extends StatefulWidget {
  final List<RecipesCartmodel> recipesList;
  const Favscreen2({Key? key, required this.recipesList}) : super(key: key);

  @override
  State<Favscreen2> createState() => _Favscreen2State();
}

class _Favscreen2State extends State<Favscreen2> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: widget.recipesList.map((recipesCartData) {
        return Padding(
          padding: EdgeInsets.only(
              top: height * 0.02, left: width * 0.02, right: width * 0.02),
          child: Container(
            height: height * 0.2,
            width: width,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 1.3,
                  spreadRadius: 2.5,
                  offset: Offset(0.0, 0.2),
                ),
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: width * 0.03),
                Container(
                  height: height * 0.15,
                  width: width * 0.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black45,
                          spreadRadius: 2.0,
                          blurRadius: 4.0,
                          offset: Offset(0.0, 1.2),
                        ),
                      ],
                      image: DecorationImage(
                          image: NetworkImage(recipesCartData.recipesImage),fit: BoxFit.cover)),

                ),
                SizedBox(
                  width: width * 0.1,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        recipesCartData.recipesName,
                        style: TextStyle(
                          fontSize: 25,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.001,
                      ),
                      Text(
                        recipesCartData.recipesType,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
