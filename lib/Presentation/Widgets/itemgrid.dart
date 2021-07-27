import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
        return mystate.products.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(14),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.carpenter,
                      size: 100,
                      color: Colors.blue,
                    ),
                    Text('Masih belum ada item di database.'),
                    Text(
                      'Silahkan masuk ke menu products lalu input dengan tombol (+) di pojok kanan bawah.',
                      textAlign: TextAlign.center,
                    )
                  ],
                )),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5),
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
    final numberFormat =
        NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);
    return Container(
      margin: EdgeInsets.all(10),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
      child: InkResponse(
        onTap: () {
          var z = ProductsInTransactionsCompanion.insert(
              productId: state.products[index].id,
              transactionId: '',
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
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Container(
                  color: Colors.grey[100],
                  alignment: Alignment.center,
                  child: Text(state.products[index].productName)),
            ),
            Expanded(
              flex: 2,
              child: Container(
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child: Text(
                    '${numberFormat.format(state.products[index].price)} / ${state.products[index].uom}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
