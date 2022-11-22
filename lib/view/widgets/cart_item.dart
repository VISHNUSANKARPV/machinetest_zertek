import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zartek_machine/data/model/restuarant_model.dart';
import 'package:zartek_machine/view_model/cart_view_model.dart';

class CartItem extends StatelessWidget {
  const CartItem({Key? key, required this.categoryDishes}) : super(key: key);
  final CategoryDishes categoryDishes;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(border: Border.all()),
          child: Icon(
            Icons.circle,
            color: Colors.red,
            size: 17.sp,
          ),
        ),
        SizedBox(
          width: size.width * .25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                categoryDishes.dishName!,
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
              ),
              const SizedBox(height: 10),
              Text(
                "INR ${categoryDishes.dishPrice}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
                maxLines: 2,
              ),
              const SizedBox(height: 5),
              Text(
                "${categoryDishes.dishCalories} calories",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
                maxLines: 2,
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
        SizedBox(
          width: 90.w,
          height: 45.h,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r)),
            color: Colors.green,
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<CartViewModel>(
                builder: (context, value, child) => Consumer<CartViewModel>(
                  builder: (context, value, child) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                          onTap: () => value.removeItem(categoryDishes),
                          child: const Icon(
                            Icons.remove,
                            color: Colors.white,
                          )),
                      Text(
                          !value.categoryDishes.contains(categoryDishes)
                              ? '0'
                              : value
                                  .categoryDishes[value.categoryDishes
                                      .indexOf(categoryDishes)]
                                  .quantity
                                  .toString(),
                          style: const TextStyle(color: Colors.white)),
                      InkWell(
                          onTap: () => value.addItem(categoryDishes),
                          child: const Icon(Icons.add, color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Text("INR ${(categoryDishes.dishPrice!*categoryDishes.quantity).round()}",
            style: TextStyle(color: Colors.black, fontSize: 13.sp))
      ],
    );
  }
}
