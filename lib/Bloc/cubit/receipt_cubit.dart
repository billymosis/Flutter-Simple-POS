import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_pos/Data/Data_Provider/database.dart';

part 'receipt_state.dart';

class ReceiptCubit extends Cubit<ReceiptState> {
  ReceiptCubit() : super(ReceiptInitial());

  var x = SharedDatabase.x;
  List<SalesTransaction> _myInvoice = [];
  SalesTransaction? _currentInvoice;

  void getAllInvoiceItems() async {
    _myInvoice = await x.allSalesEntries;
    emit(ReceiptInitial(invoice: _myInvoice, currentInvoice: _currentInvoice));
  }

  void getInvoiceByID(String id) async {
    _currentInvoice = await x.selectInvoicetById(id);
    emit(ReceiptInitial(invoice: _myInvoice, currentInvoice: _currentInvoice));
  }
}
