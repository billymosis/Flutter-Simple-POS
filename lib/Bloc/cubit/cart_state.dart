part of 'cart_cubit.dart';

@immutable
abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  final List<ProductsInTransaction> cart;
  final List<ProductsInTransaction> invoiceCart;
  final double totalPrice;
  final double payment;
  final String customer;
  CartInitial({
    this.cart = const [],
    this.invoiceCart = const [],
    this.totalPrice = 0,
    this.payment = 0,
    this.customer = '',
  });
  @override
  List<Object?> get props => [cart, totalPrice, invoiceCart, payment];
}
