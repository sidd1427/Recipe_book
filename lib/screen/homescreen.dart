import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:recipes_app/model/favourite_model.dart';
import 'package:recipes_app/screen/favourite.dart';
import 'package:recipes_app/screen/recipes_details.dart';
import 'package:recipes_app/provider/recipes_provider.dart';

import '../model/recipes_model.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String name = "";
  late RecipesProvider recipesProvider;
  bool isLoading = true;
  bool isViewAll = false;

  late List<Recipesmodel> recipesList;
  late List<Drinksmodel> drinkList;

  late List<RecipesCartmodel> recipesCartList;
  late List<DrinksCartmodel> drinkCartList;

  List<Map<String, dynamic>> catagory = [
    {
      "leading": "assets/image/lunch.png",
      "title": "Lunch",
    },
    {
      "leading": "assets/image/brackfast.png",
      "title": "Breakfast",
    },
    {
      "leading": "assets/image/dinner.jpg",
      "title": "Dinner",
    },
    {
      "leading": "assets/image/slad.png",
      "title": "salad",
    },
    {
      "leading": "assets/image/sweet.png",
      "title": "Dessert",
    },
    {
      "leading": "assets/image/drink.png",
      "title": "Cold Drink",
    },
  ];

  @override
  void initState() {
    recipesProvider = Provider.of(context, listen: false);
    recipesProvider.fetchRecipesData().whenComplete(() {
      setState(() {
        recipesList = recipesProvider.recipesList;
      });
      recipesProvider.fetchDrinkData().whenComplete(() {
        setState(() {
          drinkList = recipesProvider.drinkList;
        });
      }).whenComplete(() {
        recipesProvider.fetchRecipesCartData().whenComplete(() {
          setState(() {
            recipesCartList = recipesProvider.recipesCartList;
          });
        }).whenComplete(() {
          recipesProvider.fetchDrinkCartData().whenComplete(() {
            setState(() {
              drinkCartList = recipesProvider.drinkCartList;
              isLoading = false;
            });
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Recipes"),
          backgroundColor: Colors.orange,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 25,
              )),
          leadingWidth: width * 0.039,
          actions: [
            SizedBox(
              width: width * 0.09,
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FavScreen()));
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 30,
                  color: Colors.white,
                ))
          ],
        ),
        backgroundColor: Colors.white,
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(color: Colors.orange),
              )
            : ListView(
            physics: const BouncingScrollPhysics(),
            children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 25,
                    bottom: 25,
                    left: 7,
                    right: 7,
                  ),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage('assets/image/cooked.jpg'),
                        ),
                      ),
                      labelText: "search Item",
                      labelStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      suffixIcon: const Icon(Icons.search),
                    ),
                    onChanged: (val) {
                      if (val.isEmpty) {
                        setState(() {
                          recipesList = recipesProvider.recipesList;
                          drinkList = recipesProvider.drinkList;
                        });
                      } else {
                        setState(() {
                          recipesList = recipesProvider.recipesList
                              .where((element) => element.recipesName
                                  .toLowerCase()
                                  .contains(val.toLowerCase()))
                              .toList();
                          drinkList = recipesProvider.drinkList
                              .where((element) => element.drinkName
                                  .toLowerCase()
                                  .contains(val.toLowerCase()))
                              .toList();
                        });
                      }
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Categories",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: height * 0.12,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: catagory.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          SizedBox(width: width * 0.04),
                          Column(
                            children: [
                              Card(
                                elevation: 20,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                    catagory[index]["leading"],
                                  ),
                                  radius: 30,
                                ),
                              ),
                              Text(
                                catagory[index]['title'],
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Recipes",
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: recipesList.map(
                      (recipesData) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: Container(
                            height: height * 0.25,
                            width: width * 0.40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black45,
                                  spreadRadius: 2.0,
                                  blurRadius: 4.0,
                                  offset: Offset(0.0, 1.2),
                                ),
                              ],
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => Recipesdtl(
                                                  name: recipesData.recipesName,
                                                  image: recipesData.recipesImage,
                                                  ingredient: recipesData
                                                      .recipesIngredient,
                                                  mack: recipesData.recipesMack,
                                                  type: recipesData.recipesType,
                                                ))),
                                    child: Container(
                                      height: 150,
                                      padding: const EdgeInsets.all(5),
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                        child: Image.network(
                                          recipesData.recipesImage,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              recipesData.recipesName,
                                              style: TextStyle(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            // SizedBox(height: height*0.01,),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  recipesData.recipesType,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                LikeButton(
                                                  size: 23,
                                                  isLiked: (recipesCartList
                                                          .where((element) =>
                                                              element
                                                                  .recipesName ==
                                                              recipesData
                                                                  .recipesName)
                                                          .isNotEmpty)
                                                      ? true
                                                      : false,
                                                  onTap: (value) {
                                                    return recipesProvider
                                                        .addCartRecipesData(
                                                            data: RecipesCartmodel(
                                                              recipesName:
                                                                  recipesData
                                                                      .recipesName,
                                                              recipesImage:
                                                                  recipesData
                                                                      .recipesImage,
                                                              recipesType:
                                                                  recipesData
                                                                      .recipesType,
                                                            ),
                                                            value: value,
                                                            name: recipesData
                                                                .recipesName);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ]),
                                    ),
                                  ),
                                ]),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Cold Drink",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: drinkList.map(
                        (drinkData) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            child: Container(
                              height: height * 0.25,
                              width: width * 0.40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black45,
                                    spreadRadius: 2.0,
                                    blurRadius: 4.0,
                                    offset: Offset(0.0, 1.2),
                                  ),
                                ],
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Recipesdtl(
                                                    name: drinkData.drinkName,
                                                    image: drinkData.drinkImage,
                                                    ingredient:
                                                        drinkData.drinkIngredient,
                                                    mack: drinkData.drinkMack,
                                                    type: drinkData.drinktpye,
                                                  ))),
                                      child: Container(
                                        height: 150,
                                        padding: const EdgeInsets.all(5),
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20)),
                                          child: Image.network(
                                            drinkData.drinkImage,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                drinkData.drinkName,
                                                style: TextStyle(
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              LikeButton(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                size: 23,
                                                isLiked: (drinkCartList
                                                        .where((element) =>
                                                            element.drinkName ==
                                                            drinkData.drinkName)
                                                        .isNotEmpty)
                                                    ? true
                                                    : false,
                                                onTap: (value) {
                                                  return recipesProvider
                                                      .addCartDrinkData(
                                                          data: DrinksCartmodel(
                                                            drinkName: drinkData
                                                                .drinkName,
                                                            drinkImage: drinkData
                                                                .drinkImage,
                                                            drinktpye: drinkData
                                                                .drinktpye,
                                                          ),
                                                          value: value,
                                                          name: drinkData
                                                              .drinkName);
                                                },
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ]),
                            ),
                          );
                        },
                      ).toList(),
                    )),
              ]),
      ),
    );
  }
}
