import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import 'package:zartek_machine/view/screens/cart/cart_screen.dart';
import 'package:zartek_machine/view/widgets/drawer.dart';
import 'package:zartek_machine/view/widgets/item_card.dart';
import 'package:zartek_machine/view_model/cart_view_model.dart';
import 'package:zartek_machine/view_model/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (BuildContext context, value, Widget? child) =>
          DefaultTabController(
        length: !value.isLoading || value.error.isNotEmpty
            ? value.restuarantModel.tableMenuList!.length
            : 0,
        child: Scaffold(
          backgroundColor: Colors.white,
          key: _key,
          drawer: const Drawers(),
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                  onPressed: () {
                    _key.currentState!.openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.black,
                  )),
              actions: [
                Consumer<CartViewModel>(
                  builder: (context, value, child) => Badge(
                    position: BadgePosition.topEnd(top: 10, end: 4),
                    badgeContent: Text(
                      "${value.categoryDishes.length}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const CartScreen())),
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
              bottom: !value.isLoading || value.error.isNotEmpty
                  ? TabBar(
                      indicatorColor: Colors.pink,
                      isScrollable: true,
                      labelColor: Colors.pink,
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                      unselectedLabelColor: Colors.black,
                      tabs: value.restuarantModel.tableMenuList!
                          .map(
                            (e) => Tab(text: e.menuCategory),
                          )
                          .toList(),
                    )
                  : const PreferredSize(
                      preferredSize: Size(0, 0), child: SizedBox())),
          body: Builder(
            builder: (context) {
              if (value.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (value.error.isNotEmpty) {
                return Center(
                  child: Text(value.error),
                );
              }
              return TabBarView(
                  children: value.restuarantModel.tableMenuList!
                      .map(
                        (e) => ListView.separated(
                          itemCount: e.categoryDishes!.length,
                          itemBuilder: (context, index) {
                            return ItemCard(
                              categoryDishes: e.categoryDishes![index],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },
                        ),
                      )
                      .toList());
            },
          ),
        ),
      ),
    );
  }
}


