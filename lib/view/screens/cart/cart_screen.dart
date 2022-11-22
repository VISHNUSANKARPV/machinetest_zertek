import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zartek_machine/view/widgets/cart_item.dart';
import 'package:zartek_machine/view_model/cart_view_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.grey,
        ),
        title: const Text(
          "Order summary",
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          color: Colors.white,
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 42, 70, 43),
                      borderRadius: BorderRadius.circular(4.r)),
                  child: Consumer<CartViewModel>(
                    builder: (context, value, child) => Text(
                      "${value.categoryDishes.length}  Dishes - ${value.categoryDishes.length} Items",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child:
                      Consumer<CartViewModel>(builder: (context, value, child) {
                    if (value.categoryDishes.isEmpty) {
                      return const Center(child: Text('Cart Is Empty'));
                    }
                    return ListView.separated(
                      itemCount: value.categoryDishes.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(16),
                        child: CartItem(
                            categoryDishes: value.categoryDishes[index]),
                      ),
                    );
                  }),
                ),
                SizedBox(
                  height: 45,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Amount",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Consumer<CartViewModel>(
                          builder: (context, value, child) => Text(
                            "INR ${value.totalPrize.round()}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Consumer<CartViewModel>(
          builder: (context, value, child) => InkWell(
            onTap: () {
              value.cleaProducts();
              
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Order Placing Successfully')));
            },
            child: Container(
              alignment: Alignment.center,
              height: 50.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 42, 70, 43),
                  borderRadius: BorderRadius.circular(400.r)),
              child: Text(
                "Place Order",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
