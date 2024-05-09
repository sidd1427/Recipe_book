import 'package:flutter/material.dart';

class Recipesdtl extends StatefulWidget {
  final String name;
  final String image;
  final List<dynamic> ingredient;
  final List<dynamic> mack;
  final String type;
  const Recipesdtl({
    Key? key,
    required this.name,
    required this.image,
    required this.ingredient,
    required this.mack,
    required this.type,
  }) : super(key: key);

  @override
  State<Recipesdtl> createState() => _RecipesdtlState();
}

class _RecipesdtlState extends State<Recipesdtl> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Recipes Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Card(
            margin: EdgeInsets.only(right: 40, left: 40, top: 20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 30,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      child: Image.network(
                        widget.image,
                        // height: 250,
                        // width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.name,
                    style: TextStyle(fontSize: 21),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(left: 50, right: 50),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Ingredients",
                    style: TextStyle(
                      fontSize: 25,
                    )),
              ),
              Container(
                height: height * 0.50,
                width: width * 0.30,
                decoration: BoxDecoration(
                  color: Color(0xffffd2cf),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView.builder(
                    itemCount: widget.ingredient.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.01, right: width * 0.01),
                        child: Row(
                          children: [
                            Text(
                              "\u2022",
                              style: TextStyle(
                                  fontSize: width * 0.08, color: Colors.orange),
                            ),
                            SizedBox(
                              width: width * 0.006,
                            ),
                            Expanded(
                              child: Text(
                                widget.ingredient[index],
                                style: TextStyle(
                                    fontSize: width * 0.025,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                softWrap: false,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(height: height * 0.01),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Cooking Instruction",
                    style: TextStyle(
                      fontSize: 25,
                    )),
              ),
              Container(
                height: height * 0.50,
                width: width * 0.10,
                decoration: BoxDecoration(
                  color: Color(0xffffd2cf),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView.builder(
                    itemCount: widget.mack.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.01,
                            right: width * 0.01,
                            top: height * 0.01,
                            bottom: width * 0.01),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "\u2022",
                              style: TextStyle(
                                fontSize: width * 0.08,
                                color: Colors.orange,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.009,
                            ),
                            Expanded(
                              child: Text(
                                widget.mack[index],
                                style: TextStyle(
                                  fontSize: width * 0.025,
                                  fontWeight: FontWeight.w400,
                                  height: height * 0.001,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 100,
                                softWrap: false,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
