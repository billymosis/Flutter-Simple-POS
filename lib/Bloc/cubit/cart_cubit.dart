import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:project_pos/Data/Data_Provider/Platform_Helper/shared.dart';
import 'package:project_pos/Data/Data_Provider/database.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial(cart: [], totalPrice: 0));

  SharedDatabase x = constructDb();
  List<ProductsInTransaction> _myCart = [];
  List<ProductsInTransaction> _invoiceCart = [];
  double _payment = 0;
  double _totalPrice = 0;
  String _customer = '';
  void getAllCartItems() async {
    if (_myCart.isNotEmpty) {
      _totalPrice = _myCart
          .map((e) => e.salePrice * e.quantity)
          .reduce((value, element) => value + element);
    }
    emit(CartInitial(
        invoiceCart: _invoiceCart,
        cart: _myCart,
        totalPrice: _totalPrice,
        payment: _payment,
        customer: _customer));
  }

  void getAllCartBySaleID(int id) async {
    _invoiceCart = await x.allCartBySaleID(id);
    print(_invoiceCart);
    emit(CartInitial(
        invoiceCart: _invoiceCart,
        cart: _myCart,
        totalPrice: _totalPrice,
        payment: _payment,
        customer: _customer));
  }

  void addCart(ProductsInTransactionsCompanion pt) async {
    var y = ProductsInTransaction(
      productId: pt.productId.value,
      transactionId: pt.transactionId.value,
      quantity: pt.quantity.value,
      salePrice: pt.salePrice.value,
    );
    _myCart.add(y);
    _totalPrice = _myCart
        .map((e) => e.salePrice * e.quantity)
        .reduce((value, element) => value + element);

    emit(CartInitial(
        invoiceCart: _invoiceCart,
        cart: _myCart,
        totalPrice: _totalPrice,
        payment: _payment,
        customer: _customer));
    //x.addCart(pt);
  }

  void updateCart(ProductsInTransactionsCompanion pt) async {
    var index = _myCart
        .indexWhere((element) => element.productId == pt.productId.value);
    var y = ProductsInTransaction(
      productId: pt.productId.value,
      transactionId: pt.transactionId.value,
      quantity: pt.quantity.value,
      salePrice: pt.salePrice.value,
    );
    _myCart[index] = y;

    _totalPrice = _myCart
        .map((e) => e.salePrice * e.quantity)
        .reduce((value, element) => value + element);
    emit(CartInitial(
        invoiceCart: _invoiceCart,
        cart: _myCart,
        totalPrice: _totalPrice,
        payment: _payment,
        customer: _customer));
    //x.updateCart(pt);
  }

  void deleteCart(String id) async {
    _myCart.removeWhere((element) => element.productId == id);
    _myCart.isEmpty
        ? _totalPrice = 0
        : _totalPrice = _myCart
            .map((e) => e.salePrice * e.quantity)
            .reduce((value, element) => value + element);
    emit(CartInitial(
        invoiceCart: _invoiceCart,
        cart: _myCart,
        totalPrice: _totalPrice,
        payment: _payment,
        customer: _customer));
  }

  void setPayment(double payment) {
    _payment = payment;
    emit(CartInitial(
        invoiceCart: _invoiceCart,
        cart: _myCart,
        totalPrice: _totalPrice,
        payment: _payment,
        customer: _customer));
  }

  void addCustomer(String customer) {
    _customer = customer;
    emit(CartInitial(
        invoiceCart: _invoiceCart,
        cart: _myCart,
        totalPrice: _totalPrice,
        payment: _payment,
        customer: _customer));
  }

  void addCartToDB(double payment, bool paymentStatus) async {
    if (_myCart.isEmpty) {
      return;
    } else {
      SalesTransactionsCompanion y = SalesTransactionsCompanion.insert(
          totalPrice: _totalPrice,
          note: 'new',
          customer: _customer,
          payment: payment,
          paymentStatus: paymentStatus);
      int id = await x.addSales(y);
      List<ProductsInTransaction> zz =
          _myCart.map((e) => e = e.copyWith(transactionId: id)).toList();
      List<ProductsInTransactionsCompanion> pt =
          zz.map((e) => e.toCompanion(false)).toList();
      x.addCartList(pt);
      clearCart();
    }
  }

  void clearCart() {
    _totalPrice = 0;
    _myCart.clear();
    _customer = '';
    emit(CartInitial(
        invoiceCart: _invoiceCart,
        cart: _myCart,
        totalPrice: _totalPrice,
        payment: _payment,
        customer: _customer));
  }
}
