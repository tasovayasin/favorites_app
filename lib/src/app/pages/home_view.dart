// ignore_for_file: no_logic_in_create_state, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:favorites_app/src/app/pages/home_controller.dart';
import 'package:favorites_app/src/data/repositories/data_user_repository.dart';

class HomeView extends View {
  @override
  State<StatefulWidget> createState() {
    return _HomeViewState(
      HomeController(
        DataUserRepository(),
      ),
    );
  }
}

class _HomeViewState extends ViewState<HomeView, HomeController> {
  _HomeViewState(HomeController controller) : super(controller);

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    return ControlledWidgetBuilder<HomeController>(
        builder: (context, controller) {
      if (controller.users == null) {
        return Container();
      }
      return Scaffold(
        key: globalKey,
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    "Users",
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xffFF6F00),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "number of favorites:" +
                        controller.favoritesBox.length.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff686059),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Users",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffFF6F00),
                      ),
                    ),
                    GestureDetector(
                      onTap: (() {
                        controller.navigateToFavoritesPage();
                      }),
                      child: Text(
                        "Favorites",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffFF6F00),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  height: size.height - 210,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                    border: Border.all(
                      width: 3,
                      color: Color(0xffFF6F00),
                    ),
                  ),
                  child: ListView(
                    children: [
                      for (int i = 0; i < controller.users.length; i++)
                        UserDetails(
                          onTap: () {
                            controller.addFavorites(controller.users[i]);
                          },
                          i: i,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class UserDetails extends StatelessWidget {
  final int i;
  final Function onTap;

  const UserDetails({
    Key? key,
    required this.i,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ControlledWidgetBuilder<HomeController>(
        builder: (context, controller) {
      return Container(
        padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(controller.users[i].avatar)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.users[i].displayName,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff686059),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          controller.users[i].age +
                              "/" +
                              controller.users[i].city,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff686059),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 8),
                  child: GestureDetector(
                    onTap: () {
                      controller.addFavorites(controller.users[i]);
                    },
                    child: Icon(
                      Icons.star,
                      size: 35,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 24),
              child: Divider(
                thickness: 2,
              ),
            ),
          ],
        ),
      );
    });
  }
}
