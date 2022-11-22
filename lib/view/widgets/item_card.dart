import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zartek_machine/data/model/restuarant_model.dart';
import 'package:zartek_machine/view_model/cart_view_model.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({Key? key, required this.categoryDishes}) : super(key: key);
  final CategoryDishes categoryDishes;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(border: Border.all()),
              child: Icon(
                Icons.circle,
                color: categoryDishes.dishType == 1 ? Colors.red : Colors.green,
              ),
            ),
            SizedBox(
              width: 230.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    categoryDishes.dishName ?? '',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${categoryDishes.dishCurrency ?? ''} ${categoryDishes.dishPrice ?? '0'}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${categoryDishes.dishCalories ?? ''} calories",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    categoryDishes.dishDescription ?? '',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                    maxLines: 5,
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: 120,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r)),
                      color: Colors.green,
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Consumer<CartViewModel>(
                            builder: (context, value, child) {
                          return Row(
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
                                  child: const Icon(Icons.add,
                                      color: Colors.white)),
                            ],
                          );
                        }),
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Image.network(
            //   categoryDishes.dishImage ?? '',
            //   width: 60.w,
            //   height: 60.h,
            //   errorBuilder: (context, error, stackTrace) => Image.asset(
            //     'assets/login-registration-removebg-preview.png',
            //     width: 60.w,
            //     height: 60.h,
            //   ),
            // )
            SizedBox(
              height: 60.h,
              width: 60.w,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: categoryDishes.dishImage ?? '',
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => Image.network(
                  "https://www.zoopindia.com/blog/wp-content/uploads/2022/09/satvik-food-for-navratri.webp",
                  width: 60.w,
                  height: 60.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
