import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruitshop/model/fruit_model.dart';

import '../colors.dart';
import 'DetailScreen.dart';

class MainFruitScreen extends StatefulWidget {
  @override
  _MainFruitScreenState createState() => _MainFruitScreenState();
}

class _MainFruitScreenState extends State<MainFruitScreen>
    with SingleTickerProviderStateMixin {
  final List<Color> colors_light = <Color>[
    AppColors.light_yellow,
    AppColors.light_y,
    AppColors.light_blue,
    AppColors.light_pink,
    AppColors.light_green,
    AppColors.light_p
  ];

  final List<Color> colors_dark = <Color>[
    AppColors.dark_yellow,
    AppColors.dark_y,
    AppColors.dark_blue,
    AppColors.dark_pink,
    AppColors.dark_green,
    AppColors.dark_p
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                _topBar(),
                SizedBox(height: 20),
                _middleView(),
                Expanded(child: _bottomView()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppColors.gray,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Icon(
            Icons.navigate_before,
            color: AppColors.black,
          ),
        ),
        Container(/*
          child: Icon(
            Icons.shopping_cart,
            color: AppColors.black,
          ),*/
          child: SvgPicture.asset("assets/images/signs.svg",height: 30,width: 20,),
        )
      ],
    );
  }

  Widget _middleView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          child: Text(
            "Fruits and berries",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.w900, height: 2.2),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: AppColors.gray),
          child: TextField(
            cursorColor: AppColors.black,
            style: TextStyle(color: AppColors.black, fontSize: 16),
            decoration: InputDecoration(
                icon: Icon(
                  Icons.search,
                  color: AppColors.black,
                ),
                hintText: "Search",
                hintStyle: TextStyle(color: AppColors.gray_light),
                border: InputBorder.none),
          ),
        )
      ],
    );
  }

  Widget _bottomView() {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: StaggeredGridView.countBuilder(
        shrinkWrap: true,
        crossAxisCount: 4,
        itemCount: fruits.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                // builder: (_) => FruitDetailScreen(fruit : fruits[index],index: index),
                // builder: (_)=>TestClass()
                builder: (_) =>
                    DetailScreen(fruit: fruits[index], index: index),
              ),
            );
          },
          child: Container(
            // height: 200,
            decoration: BoxDecoration(
                color: colors_light[index],
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: <Widget>[
                _itemTopView(index),
                _columnOfItems(index),
                _bottomofItem(index),
              ],
            ),
          ),
        ),
        staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
    );
  }

  Widget _itemTopView(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10, top: 20, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            fruits[index].name,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                fontFamily: "Raleway"),
          ),
          Icon(
            Icons.more_vert,
            color: colors_dark[index],
          )
        ],
      ),
    );
  }

  Widget _columnOfItems(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            fruits[index].quantity,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w100,
                fontFamily: "Raleway"),
          ),
          Text(
            "\$" + fruits[index].price,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                fontFamily: "Raleway"),
          ),
          SizedBox(
            height: 5,
          ),
          Image(
            image: AssetImage(fruits[index].imageUrl),
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }

  Widget _bottomofItem(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: colors_dark[index],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Icon(
            Icons.add,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
