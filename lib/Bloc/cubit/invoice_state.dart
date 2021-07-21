part of 'invoice_cubit.dart';

@immutable
abstract class InvoiceState extends Equatable {
  const InvoiceState();
}

class InvoiceInitial extends InvoiceState {
  InvoiceInitial({this.invoice = const [], this.currentID = 0});
  final List<SalesTransaction> invoice;
  final int currentID;
  @override
  List<Object?> get props => [invoice, currentID];
}
