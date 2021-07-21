part of 'cart_cubit.dart';

@immutable
abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  final List<ProductsInTransaction> cart;
  final List<ProductsInTransaction> invoiceCart;
  final double totalPrice;

  CartInitial(
      {this.cart = const [], this.invoiceCart = const [], this.totalPrice = 0});
  @override
  List<Object?> get props => [cart, totalPrice, invoiceCart];
}
