part of 'form_cubit.dart';

@immutable
abstract class FormStateCubit extends Equatable {
  const FormStateCubit();
}

class FormInitial extends FormStateCubit {
  final List<String> category;
  final List<String> uom;
  FormInitial({
    this.category = const [],
    this.uom = const [],
  });

  @override
  List<Object?> get props => [category, uom];
}
