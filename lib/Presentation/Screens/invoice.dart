import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_pos/Bloc/cubit/cart_cubit.dart';
import 'package:project_pos/Bloc/cubit/invoice_cubit.dart';
import 'package:project_pos/Bloc/cubit/products_cubit.dart';
import 'package:project_pos/Data/Data_Provider/database.dart';
import 'package:project_pos/Presentation/Widgets/widgets.dart';

class InvoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerWidget(),
        appBar: MainAppBar(),
        body: Container(
            child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  child: BlocBuilder<InvoiceCubit, InvoiceState>(
                    builder: (context, state) {
                      List<SalesTransaction> invoice =
                          (state as InvoiceInitial).invoice;
                      void onTap(int x) {
                        print(invoice[x - 1].totalPrice);
                        BlocProvider.of<CartCubit>(context)
                            .getAllCartBySaleID(x);
                      }

                      return ListView.builder(
                        itemCount: invoice.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            selectedTileColor: Colors.greenAccent,
                            title: Text(invoice[index].totalPrice.toString()),
                            trailing:
                                Text(invoice[index].transactionId.toString()),
                            subtitle: Text(
                                invoice[index].updatedAt.toIso8601String()),
                            onTap: () => onTap(invoice[index].transactionId),
                          );
                        },
                      );
                    },
                  ),
                )),
            Expanded(flex: 7, child: IvoiceList())
          ],
        )));
  }
}

class IvoiceList extends StatelessWidget {
  const IvoiceList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Card(
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            var _cartState = (state as CartInitial).invoiceCart;
            double _totalPrice = _cartState
                .map((e) => e.quantity * e.salePrice)
                .reduce((value, element) => value + element);
            return Padding(
              padding: const EdgeInsets.fromLTRB(80, 20, 80, 20),
              child: Column(
                children: [
                  Text(
                    'TOKO BAHAN BANGUNAN KEPUH JAYA',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Jl. Raya Kepuh No.3 📞 085xxxxxx',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _cartState.length,
                      itemBuilder: (context, index) {
                        var _cart = _cartState[index];
                        var _productId = _cart.productId;
                        var _productState =
                            BlocProvider.of<ProductsCubit>(context).state
                                as ProductsInitial;
                        var _product = _productState.products
                            .firstWhere((element) => element.id == _productId);
                        return ListTile(
                          leading: Container(
                            alignment: Alignment.center,
                            width: 50,
                            height: 50,
                            child: Text(
                              _cart.quantity.toString() + ' ' + _product.uom,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          title: Text(_product.productName),
                          subtitle: Text('${_cart.salePrice}'),
                          trailing: Text('${_cart.quantity * _cart.salePrice}'),
                        );
                      },
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(_totalPrice.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  )
                ],
              ),
            );
          },
        ),
      )),
    );
  }
}
