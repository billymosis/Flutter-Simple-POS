import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:project_pos/Bloc/cubit/cart_cubit.dart';
import 'package:project_pos/Bloc/cubit/receipt_cubit.dart';
import 'package:project_pos/Bloc/cubit/products_cubit.dart';
import 'package:project_pos/Data/Data_Provider/database.dart';

class ItemListCart extends StatelessWidget {
  final numberFormat =
      NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide())),
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                var mystate = state as CartInitial;
                String nama = mystate.customer == ''
                    ? 'Tambah Nama Pelanggan'
                    : mystate.customer;
                return DropdownButton<String>(
                  isExpanded: true,
                  value: nama,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  underline: Container(
                    height: 2,
                  ),
                  onChanged: (String? newValue) {
                    if (newValue == nama) {
                      customerDialog(context, mystate, nama);
                      nama = newValue ?? 'Tanpa Nama';
                    } else {
                      BlocProvider.of<CartCubit>(context).clearCart();
                    }
                  },
                  items: <String>[nama, 'Clear']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Container(
            child: Expanded(child: CartList()),
          ),
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
                            '${numberFormat.format(price)}',
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
                  paymentDialog(context);
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

  Future<dynamic> paymentDialog(BuildContext context) {
    final numberFormat =
        NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);
    return showDialog(
      context: context,
      builder: (context) {
        BlocProvider.of<CartCubit>(context).setPayment(0);
        var _pembayaran = TextEditingController();
        return Scaffold(
          appBar: AppBar(),
          body: Container(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: CartList(),
                ),
                Expanded(
                    flex: 7,
                    child: SingleChildScrollView(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                          child: BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) {
                              var _mystate = (state as CartInitial);
                              _pembayaran.text = _mystate.payment.toString();
                              print(_mystate.customer);
                              return Column(
                                children: [
                                  Text(
                                    '${numberFormat.format(_mystate.totalPrice)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    height: 14,
                                    child:
                                        _mystate.payment >= _mystate.totalPrice
                                            ? Text(
                                                'Kembalian: ${numberFormat.format(_mystate.payment - _mystate.totalPrice)}',
                                              )
                                            : Container(),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      'Pelanggan: ${_mystate.customer == '' ? 'Tanpa Nama' : _mystate.customer}',
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  ListTile(
                                    trailing: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: _mystate.payment >=
                                                  _mystate.totalPrice
                                              ? Colors.blue
                                              : Colors.red),
                                      child: _mystate.payment >=
                                              _mystate.totalPrice
                                          ? Text('Bayar')
                                          : Text('Utang'),
                                      onPressed: () {
                                        var _payStats = _mystate.payment >=
                                                _mystate.totalPrice
                                            ? true
                                            : false;
                                        BlocProvider.of<CartCubit>(context)
                                            .addCartToDB(
                                                _mystate.payment, _payStats);
                                        BlocProvider.of<ReceiptCubit>(context)
                                            .getAllInvoiceItems();
                                      },
                                    ),
                                    title: TextField(
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      controller: _pembayaran,
                                      onEditingComplete: () {
                                        BlocProvider.of<CartCubit>(context)
                                            .setPayment(
                                                double.parse(_pembayaran.text));
                                        FocusScope.of(context).unfocus();
                                      },
                                    ),
                                    leading: Icon(Icons.attach_money),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      _myButton(context, _mystate,
                                          _mystate.totalPrice),
                                      _myButton(context, _mystate, 1000),
                                      _myButton(context, _mystate, 2000),
                                      _myButton(context, _mystate, 5000),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      _myButton(context, _mystate, 10000),
                                      _myButton(context, _mystate, 20000),
                                      _myButton(context, _mystate, 50000),
                                      _myButton(context, _mystate, 100000),
                                    ],
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _myButton(BuildContext context, CartInitial state, double value) {
  return ConstrainedBox(
    constraints: BoxConstraints.tightFor(width: 100, height: 40),
    child: TextButton(
        style: TextButton.styleFrom(
            side: BorderSide(color: Colors.grey),
            primary: Colors.grey.shade700),
        onPressed: () {
          BlocProvider.of<CartCubit>(context).setPayment(state.payment + value);
        },
        child: Text(value.toString())),
  );
}

class CartList extends StatelessWidget {
  const CartList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberFormat =
        NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        CartInitial mystate = state as CartInitial;
        return ListView.builder(
          itemCount: mystate.cart.length,
          itemBuilder: (context, index) {
            var _cart = mystate.cart[index];
            var _productId = _cart.productId;
            var _productState = BlocProvider.of<ProductsCubit>(context).state
                as ProductsInitial;
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
                subtitle:
                    Text('${_product.price.toString()} / ${_product.uom}'),
                trailing: Text('${numberFormat.format(_totalPrice)}'),
              ),
            );
          },
        );
      },
    );
  }
}

Future<dynamic> customerDialog(
    BuildContext context, CartInitial mystate, String customer) {
  return showDialog(
      context: context,
      builder: (context) {
        var _formKey = GlobalKey<FormState>();
        String _customer = customer;
        return Center(
          child: Container(
            width: 500,
            child: Card(
              child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: ListView(children: [
                      TextFormField(
                          onChanged: (newValue) => _customer = newValue,
                          onSaved: (newValue) => _customer = newValue!,
                          decoration: InputDecoration(
                              labelText: 'Input Nama Kustomer')),
                      ElevatedButton(
                          onPressed: () {
                            _formKey.currentState!.save();
                            BlocProvider.of<CartCubit>(context)
                                .addCustomer(_customer);
                            BlocProvider.of<CartCubit>(context)
                                .getAllCartItems();
                            Navigator.pop(context);
                          },
                          child: Text('Submit'))
                    ]),
                  )),
            ),
          ),
        );
      });
}

Future<dynamic> formDialog(BuildContext context, CartInitial mystate, int index,
    Product _product, ProductsInTransaction _cart) {
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
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          onChanged: (newValue) =>
                              _price = double.parse(newValue),
                          onSaved: (newValue) =>
                              _price = double.parse(newValue!),
                          decoration:
                              InputDecoration(labelText: 'Harga per satuan')),
                      TextFormField(
                          initialValue: _quantity.toString(),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
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
