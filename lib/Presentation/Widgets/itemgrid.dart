import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moor/moor.dart' as moor;
import 'package:project_pos/Bloc/cubit/cart_cubit.dart';
import 'package:project_pos/Bloc/cubit/products_cubit.dart';
import 'package:project_pos/Data/Data_Provider/database.dart';

class ItemGrid extends StatelessWidget {
  const ItemGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductsCubit>(context).getAllProducts();
    return Container(child: BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        var mystate = state as ProductsInitial;
        return GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
          itemCount: mystate.products.length,
          itemBuilder: (context, index) => _GridContainer(
            index: index,
            state: mystate,
          ),
        );
      },
    ));
  }
}

class _GridContainer extends StatelessWidget {
  final ProductsInitial state;
  final int index;

  const _GridContainer({
    Key? key,
    required this.state,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _counter = 1;
    return GridTile(
      child: InkResponse(
        onTap: () {
          var z = ProductsInTransactionsCompanion.insert(
              productId: state.products[index].id,
              transactionId: 0,
              quantity: _counter,
              salePrice: state.products[index].price.toDouble());
          var x = (BlocProvider.of<CartCubit>(context).state as CartInitial)
              .cart
              .map((e) => e.productId == z.productId.value)
              .contains(true);

          if (x) {
            _counter = _counter + 1;
            BlocProvider.of<CartCubit>(context)
                .updateCart(z.copyWith(quantity: moor.Value(_counter)));
          } else {
            BlocProvider.of<CartCubit>(context).addCart(z);
            _counter = 1;
          }
        },
        child: Container(
          margin: EdgeInsets.all(10),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
          child: Center(child: Text(state.products[index].productName)),
        ),
      ),
    );
  }
}
