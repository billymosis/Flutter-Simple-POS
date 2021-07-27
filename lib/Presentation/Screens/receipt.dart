import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_pos/Bloc/cubit/cart_cubit.dart';
import 'package:project_pos/Bloc/cubit/receipt_cubit.dart';
import 'package:project_pos/Bloc/cubit/products_cubit.dart';
import 'package:project_pos/Data/Data_Provider/database.dart';
import 'package:project_pos/Presentation/Widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:project_pos/responsive.dart';

class InvoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerWidget(),
        appBar: MainAppBar(
          title: 'Nota',
        ),
        body: Responsive(
          mobile: InvoiceList(),
          tablet: Container(
              child: Row(
            children: [
              Expanded(flex: 3, child: InvoiceList()),
              Expanded(flex: 7, child: IvoiceDetail())
            ],
          )),
        ));
  }
}

class InvoiceList extends StatelessWidget {
  const InvoiceList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<ReceiptCubit, ReceiptState>(
        builder: (context, state) {
          List<SalesTransaction> invoice = (state as ReceiptInitial).invoice;
          BlocProvider.of<ReceiptCubit>(context).getAllInvoiceItems();
          void onTap(String x) {
            BlocProvider.of<CartCubit>(context).getAllCartBySaleID(x);
            BlocProvider.of<ReceiptCubit>(context).getInvoiceByID(x);
            Responsive.isDisplayMobile(context)
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Scaffold(appBar: AppBar(), body: IvoiceDetail())))
                : print('');
          }

          return RefreshIndicator(
            onRefresh: () async =>
                BlocProvider.of<ReceiptCubit>(context).getAllInvoiceItems(),
            child: ListView.builder(
              itemCount: invoice.length,
              itemBuilder: (context, index) {
                return ListTile(
                  selectedTileColor: Colors.greenAccent,
                  title: Text(NumberFormat.simpleCurrency(
                          locale: 'id_ID', decimalDigits: 0)
                      .format(invoice[index].totalPrice)),
                  trailing: Text(invoice[index].transactionId.substring(0, 8)),
                  subtitle: Text(DateFormat("dd/MM/yy | HH : mm").format(
                      DateTime.fromMillisecondsSinceEpoch(
                          invoice[index].updatedAt * 1000))),
                  onTap: () => onTap(invoice[index].transactionId),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class IvoiceDetail extends StatelessWidget {
  const IvoiceDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberFormat =
        NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);
    return Container(
      child: Card(
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            var _cartState = (state as CartInitial).invoiceCart;
            if (_cartState.isEmpty) {
              return Center(child: Text('Silahkan lakukan transaksi'));
            } else {
              var _invoiceState = BlocProvider.of<ReceiptCubit>(context).state
                  as ReceiptInitial;
              double _totalPrice = _invoiceState.currentInvoice!.totalPrice;
              return Padding(
                padding: Responsive.isDisplayTablet(context)
                    ? EdgeInsets.fromLTRB(80, 20, 80, 10)
                    : EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'TOKO BAHAN BANGUNAN KEPUH JAYA',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Jl. Raya Kepuh No.3 📞 08123393111',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Pelanggan: ${_invoiceState.currentInvoice!.customer}'),
                          Text(
                            DateFormat("EEEE, d MMMM y | HH : mm").format(
                                (DateTime.fromMillisecondsSinceEpoch(
                                    _invoiceState.currentInvoice!.updatedAt *
                                        1000))),
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Divider(),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _cartState.length,
                        itemBuilder: (context, index) {
                          var _cart = _cartState[index];
                          var _productId = _cart.productId;
                          var _productState =
                              BlocProvider.of<ProductsCubit>(context).state
                                  as ProductsInitial;
                          var _product = _productState.products.firstWhere(
                              (element) => element.id == _productId);
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
                            subtitle: Text('${numberFormat.format(
                              _cart.salePrice,
                            )}'),
                            trailing: Text(
                                '${numberFormat.format(_cart.quantity * _cart.salePrice)}'),
                          );
                        },
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(numberFormat.format(_totalPrice),
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pembayaran',
                          ),
                          Text(
                            numberFormat
                                .format(_invoiceState.currentInvoice!.payment),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Kembalian',
                          ),
                          Text(
                            numberFormat.format(
                                _invoiceState.currentInvoice!.payment -
                                    _invoiceState.currentInvoice!.totalPrice),
                          ),
                        ],
                      ),
                      Divider(),
                      Text('#${_invoiceState.currentInvoice!.transactionId}')
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
