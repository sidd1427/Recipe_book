import 'package:flutter/material.dart';
import 'package:recipes_app/model/favourite_model.dart';

class drinkscreen extends StatefulWidget {
  final List<DrinksCartmodel> drinkList;

  const drinkscreen({Key? key, required this.drinkList}) : super(key: key);

  @override
  State<drinkscreen> createState() => _drinkscreenState();
}

class _drinkscreenState extends State<drinkscreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: widget.drinkList.map((drinkCartData) {
        return Padding(
          padding: EdgeInsets.only(top: height*0.02,left: width * 0.02, right: width * 0.02),
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
                          image: NetworkImage(drinkCartData.drinkImage),fit: BoxFit.cover)),
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
                        drinkCartData.drinkName,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.001,
                      ),
                      Text(
                        drinkCartData.drinktpye,
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
