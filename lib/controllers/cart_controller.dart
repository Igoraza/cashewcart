import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashew_cart/models/cart_product_model.dart';
import 'package:cashew_cart/presentation/main_page/widgets/custom_bottom_navbar.dart';
import 'package:cashew_cart/services/api_services.dart';

class CartController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  RxBool isUpdatingCartCount = false.obs;

  Rx<CartProductModel> cartProducts = CartProductModel(count: 0, next: null, previous: null, results: []).obs;

  getCartList() async {
    log("Loading cart list");
    isLoading.value = true;
    isError.value = false;
    print("Fetching cart");
    final response = await ApiServices().getCartList();
    if (response != null) {
      final data = CartProductModel.fromJson(response.data);

      cartProducts.value = data;
      cartCountNotifier.value = data.count;
    } else {
      isError.value = true;
    }

    isLoading.value = false;
  }

  addProductToCart(BuildContext context, String productId) async {
    // isLoading.value = true;
    isError.value = false;
    final response = await ApiServices().addProductToCart(context, productId);
    if (response == null) {
      isError.value = true;
    }
    // isLoading.value = true;
  }

  removeProductFromCart(BuildContext context, String productId) async {
    // isLoading.value = true;
    // isError.value = false;
    final response = await ApiServices().removeFromCart(context, productId);
    if (response == null) {
      isError.value = true;
    } else {
      getCartList();
    }
    // isLoading.value = false;
  }

  updateCartProduct(String productId, int newCount) async {
    isUpdatingCartCount.value = true;
    final response = await ApiServices().updateCartCount(productId, newCount);
    isUpdatingCartCount.value = false;
    return response;
  }
}
