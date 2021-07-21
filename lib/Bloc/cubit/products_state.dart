part of 'products_cubit.dart';

@immutable
abstract class ProductsState extends Equatable {
  const ProductsState();
}

class ProductsInitial extends ProductsState {
  ProductsInitial({
    this.products = const [],
  });
  final List<Product> products;

  @override
  List<Object?> get props => [products];
}
