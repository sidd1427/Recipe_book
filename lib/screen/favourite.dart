import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_app/model/favourite_model.dart';
import 'package:recipes_app/provider/recipes_provider.dart';
import 'package:recipes_app/screen/drinkCartscreen.dart';

import 'recipesCartscreen.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  late RecipesProvider recipesProvider;
  late List<RecipesCartmodel> recipesList;
  late List<DrinksCartmodel> drinkList;

  bool isLoading = true;
  @override
  void initState() {
    recipesProvider = Provider.of(context, listen: false);
    recipesProvider.fetchRecipesCartData().whenComplete(() {
      setState(() {
        recipesList = recipesProvider.recipesCartList;
      });
      recipesProvider.fetchDrinkCartData().whenComplete(() {
        setState(() {
          drinkList = recipesProvider.drinkCartList;
          isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Favscreen"),
        backgroundColor: Colors.orange,
      ),
      body: isLoading== true ?
      const Center(
        child: CircularProgressIndicator(color: Colors.orange,),
      )
          :SafeArea(
        child: Column(
          children: [
           // SizedBox(height: height*0.2),
            Container(
              width: width,
              height: height*0.8,
              child: ContainedTabBarView(
                tabBarProperties: TabBarProperties(
                  indicatorColor: Colors.orange,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 2.5,
                ),
                tabs: const [
                  Text('Recipes',style: TextStyle(color: Colors.black,fontSize: 19)),
                  Text('Drinks',style: TextStyle(color: Colors.black,fontSize: 19),),
                ],
                views: [
                  Padding(
                    padding: EdgeInsets.only(top: height*0.02,left: width*0.017,right: width*0.017),
                    child: Favscreen2(recipesList: recipesList),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height*0.02,left: width*0.017,right: width*0.017),
                    child: drinkscreen(drinkList: drinkList),
                  ),
                ],
                onChange: (index) => print(index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
