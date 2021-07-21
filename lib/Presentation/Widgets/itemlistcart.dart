import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_pos/Bloc/cubit/cart_cubit.dart';
import 'package:project_pos/Bloc/cubit/products_cubit.dart';
import 'package:project_pos/Data/Data_Provider/database.dart';

class ItemListCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide())),
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: DropdownButton<String>(
              isExpanded: true,
              value: 'One',
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              underline: Container(
                height: 2,
              ),
              onChanged: (String? newValue) {
                // Callback Function
              },
              items: <String>['One', 'Two', 'Free', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Expanded(child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              CartInitial mystate = state as CartInitial;
              return ListView.builder(
                itemCount: mystate.cart.length,
                itemBuilder: (context, index) {
                  var _cart = mystate.cart[index];
                  var _productId = _cart.productId;
                  var _productState = BlocProvider.of<ProductsCubit>(context)
                      .state as ProductsInitial;
                  var _product = _productState.products
                      .firstWhere((element) => element.id == _productId);
                  var _cartPrice =
                      _cart.salePrice == 0 ? _product.price : _cart.salePrice;
                  var _totalPrice = _cart.quantity * _cartPrice;
                  return Dismissible(
                    background: Container(
                      color: Colors.redAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Icon(Icons.delete), Icon(Icons.delete)],
                        ),
                      ),
                    ),
                    key: Key(_productId + index.toString()),
                    onDismissed: (direction) {
                      BlocProvider.of<CartCubit>(context)
                          .deleteCart(mystate.cart[index].productId);
                    },
                    child: ListTile(
                      onTap: () =>
                          formDialog(context, mystate, index, _product, _cart),
                      leading: Container(
                        alignment: Alignment.center,
                        color: Colors.green,
                        width: 50,
                        height: 50,
                        child: Text(
                          _cart.quantity.toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      title: Text(_product.productName),
                      subtitle: Text(
                          '${_product.price.toString()} / ${_product.uom}'),
                      trailing: Text('$_totalPrice'),
                    ),
                  );
                },
              );
            },
          )),
          Container(
              width: double.infinity,
              height: 30,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text('Total',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          var price = (BlocProvider.of<CartCubit>(context).state
                                  as CartInitial)
                              .totalPrice;
                          return Text(
                            '$price',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                    )
                  ])),
          Container(
            height: 40,
            color: Colors.blue,
            width: double.infinity,
            margin: EdgeInsets.all(5),
            child: TextButton(
                onPressed: () {
                  BlocProvider.of<CartCubit>(context).addCartToDB();
                },
                child: Text(
                  'BAYAR!',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
    );
  }

  Future<dynamic> formDialog(BuildContext context, CartInitial mystate,
      int index, Product _product, ProductsInTransaction _cart) {
    return showDialog(
      context: context,
      builder: (context) {
        var _formKey = GlobalKey<FormState>();
        double _price = mystate.cart[index].salePrice;
        double _quantity = mystate.cart[index].quantity;
        return Center(
          child: Container(
            width: 500,
            child: Card(
              child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListView(
                      children: [
                        Text(
                          _product.productName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        TextFormField(
                            initialValue: _price.toString(),
                            keyboardType: TextInputType.number,
                            onChanged: (newValue) =>
                                _price = double.parse(newValue),
                            onSaved: (newValue) =>
                                _price = double.parse(newValue!),
                            decoration:
                                InputDecoration(labelText: 'Harga per satuan')),
                        TextFormField(
                            initialValue: _quantity.toString(),
                            keyboardType: TextInputType.number,
                            onChanged: (newValue) =>
                                _quantity = double.parse(newValue),
                            onSaved: (newValue) =>
                                _quantity = double.parse(newValue!),
                            decoration: InputDecoration(labelText: 'Quantity')),
                        ElevatedButton(
                            onPressed: () {
                              _formKey.currentState!.save();
                              BlocProvider.of<CartCubit>(context).updateCart(
                                  ProductsInTransactionsCompanion.insert(
                                      productId: _cart.productId,
                                      transactionId: _cart.transactionId,
                                      quantity: _quantity,
                                      salePrice: _price));
                              BlocProvider.of<CartCubit>(context)
                                  .getAllCartItems();
                              Navigator.pop(context);
                            },
                            child: Text('EDIT'))
                      ],
                    ),
                  )),
            ),
          ),
        );
      },
    );
  }
}
