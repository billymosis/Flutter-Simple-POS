import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'form_state.dart';

class FormCubit extends Cubit<FormStateCubit> {
  FormCubit() : super(FormInitial());

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<String> myCategory = [];
  List<String> myUom = [];

  void getAllEntries() async {
    final SharedPreferences prefs = await _prefs;
    myCategory = prefs.getStringList('category') ?? [];
    myUom = prefs.getStringList('uom') ?? [];
    emit(FormInitial(category: myCategory, uom: myUom));
  }

  void saveCategory(String newCategory) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setStringList('category', [newCategory, ...myCategory]);
    emit(FormInitial(category: [newCategory, ...myCategory], uom: myUom));
  }

  void saveUom(String newUom) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setStringList('uom', [newUom, ...myUom]);
    emit(FormInitial(category: myCategory, uom: [newUom, ...myUom]));
  }

  void deleteAll() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove('uom');
    prefs.remove('category');
    myCategory = [];
    myUom = [];
    emit(FormInitial(category: myCategory, uom: myUom));
  }
}
