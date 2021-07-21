import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_pos/Data/Data_Provider/Platform_Helper/shared.dart';
import 'package:project_pos/Data/Data_Provider/database.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit() : super(InvoiceInitial()) {
    getAllInvoiceItems();
  }

  SharedDatabase x = constructDb();
  List<SalesTransaction> myInvoice = List.empty(growable: true);
  int currentID = 0;

  void getAllInvoiceItems() async {
    myInvoice = await x.allSalesEntries;
    emit(InvoiceInitial(invoice: myInvoice, currentID: currentID));
  }

  void setCurrentId(int id) async {
    myInvoice = await x.allSalesEntries;
    currentID = id;
    emit(InvoiceInitial(invoice: myInvoice, currentID: currentID));
  }
}
