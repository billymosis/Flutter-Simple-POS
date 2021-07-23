part of 'receipt_cubit.dart';

@immutable
abstract class ReceiptState extends Equatable {
  const ReceiptState();
}

class ReceiptInitial extends ReceiptState {
  ReceiptInitial({
    this.invoice = const [],
    this.currentInvoice,
  });
  final List<SalesTransaction> invoice;
  final SalesTransaction? currentInvoice;

  @override
  List<Object?> get props => [invoice, currentInvoice];
}
