import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:project_pos/Bloc/cubit/invoice_cubit.dart';
import 'package:project_pos/Data/Data_Provider/Platform_Helper/shared.dart';
import 'package:project_pos/Data/Data_Provider/database.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial(cart: [], totalPrice: 0));

  SharedDatabase x = constructDb();
  List<ProductsInTransaction> myCart = [];
  List<ProductsInTransaction> invoiceCart = [];

  double totalPrice = 0;

  void getAllCartItems() async {
    totalPrice = myCart
        .map((e) => e.salePrice * e.quantity)
        .reduce((value, element) => value + element);
    emit(CartInitial(
        invoiceCart: invoiceCart, cart: myCart, totalPrice: totalPrice));
  }

  void getAllCartBySaleID(int id) async {
    invoiceCart = await x.allCartBySaleID(id);
    print(invoiceCart);
    emit(CartInitial(
        invoiceCart: invoiceCart, cart: myCart, totalPrice: totalPrice));
  }

  void addCart(ProductsInTransactionsCompanion pt) async {
    var y = ProductsInTransaction(
      productId: pt.productId.value,
      transactionId: pt.transactionId.value,
      quantity: pt.quantity.value,
      salePrice: pt.salePrice.value,
    );
    myCart.add(y);
    totalPrice = myCart
        .map((e) => e.salePrice * e.quantity)
        .reduce((value, element) => value + element);

    emit(CartInitial(
        invoiceCart: invoiceCart, cart: myCart, totalPrice: totalPrice));
    //x.addCart(pt);
  }

  void updateCart(ProductsInTransactionsCompanion pt) async {
    var index =
        myCart.indexWhere((element) => element.productId == pt.productId.value);
    var y = ProductsInTransaction(
      productId: pt.productId.value,
      transactionId: pt.transactionId.value,
      quantity: pt.quantity.value,
      salePrice: pt.salePrice.value,
    );
    myCart[index] = y;

    totalPrice = myCart
        .map((e) => e.salePrice * e.quantity)
        .reduce((value, element) => value + element);
    emit(CartInitial(
        invoiceCart: invoiceCart, cart: myCart, totalPrice: totalPrice));
    //x.updateCart(pt);
  }

  void deleteCart(String id) async {
    myCart.removeWhere((element) => element.productId == id);
    myCart.isEmpty
        ? totalPrice = 0
        : totalPrice = myCart
            .map((e) => e.salePrice * e.quantity)
            .reduce((value, element) => value + element);
    emit(CartInitial(
        invoiceCart: invoiceCart, cart: myCart, totalPrice: totalPrice));
  }

  void addCartToDB() async {
    SalesTransactionsCompanion y =
        SalesTransactionsCompanion.insert(totalPrice: totalPrice, note: 'new');
    int id = await x.addSales(y);
    List<ProductsInTransaction> zz =
        myCart.map((e) => e = e.copyWith(transactionId: id)).toList();

    List<ProductsInTransactionsCompanion> pt =
        zz.map((e) => e.toCompanion(false)).toList();
    x.addCartList(pt);
    clearCart();
  }

  void clearCart() {
    totalPrice = 0;
    myCart.clear();
    emit(CartInitial(
        invoiceCart: invoiceCart, cart: myCart, totalPrice: totalPrice));
  }
}
