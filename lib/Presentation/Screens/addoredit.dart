import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moor/moor.dart' as moor;
import 'package:project_pos/Bloc/cubit/form_cubit.dart';

import 'package:project_pos/Bloc/cubit/products_cubit.dart';
import 'package:project_pos/Data/Data_Provider/database.dart';

class AddorEdit extends StatefulWidget {
  const AddorEdit({
    Key? key,
    required this.isEditing,
    this.productsCompanion,
  }) : super(key: key);
  final bool isEditing;
  final ProductsCompanion? productsCompanion;
  @override
  _AddorEditState createState() => _AddorEditState();
}

class _AddorEditState extends State<AddorEdit> {
  final _formKey = GlobalKey<FormState>();
  late String _productName;
  late String _category;
  late String _unitOfMeasurement;
  late int _price;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductsCubit>(context).getAllProducts();
    return Scaffold(
      appBar: AppBar(
        title:
            widget.isEditing ? Text('Edit Product') : Text('Add New Product'),
      ),
      body: SingleChildScrollView(
        child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: Container(
              margin: EdgeInsets.fromLTRB(200, 20, 200, 0),
              child: BlocBuilder<FormCubit, FormStateCubit>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: widget.isEditing
                            ? widget.productsCompanion!.productName.value
                            : null,
                        onSaved: (newValue) => _productName = newValue!,
                        decoration: InputDecoration(labelText: 'Product Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mohon di input';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Category: ',
                        textAlign: TextAlign.left,
                      ),
                      DropdownButtonFormField(
                        value: widget.isEditing
                            ? widget.productsCompanion!.category.value
                            : null,
                        onChanged: (newValue) {
                          if (newValue == '-1') {
                            uomDialog(context, 'category');
                          } else {
                            _category = newValue as String;
                          }
                        },
                        onSaved: (newValue) => _category = newValue as String,
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(
                              value: 'Perkakas', child: Text('Perkakas')),
                          DropdownMenuItem(
                              value: 'Material', child: Text('Material')),
                          for (var item in (BlocProvider.of<FormCubit>(context)
                                  .state as FormInitial)
                              .category)
                            DropdownMenuItem(child: Text(item), value: item),
                          DropdownMenuItem(
                            value: '-1',
                            child: Text('Buat kategori baru'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Unit of Measurement: ',
                        textAlign: TextAlign.left,
                      ),
                      DropdownButtonFormField<String>(
                        value: widget.isEditing
                            ? widget.productsCompanion!.uom.value
                            : null,
                        onChanged: (newValue) {
                          if (newValue == '-2') {
                            uomDialog(context, 'uom');
                          } else {
                            _unitOfMeasurement = newValue as String;
                          }
                        },
                        onSaved: (newValue) =>
                            _unitOfMeasurement = newValue as String,
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(child: Text('unit'), value: 'unit'),
                          DropdownMenuItem(
                            child: Text('m³'),
                            value: 'm³',
                          ),
                          for (var item in (BlocProvider.of<FormCubit>(context)
                                  .state as FormInitial)
                              .uom)
                            DropdownMenuItem(child: Text(item), value: item),
                          DropdownMenuItem(
                            value: '-2',
                            child: Text('Buat unit baru'),
                          ),
                        ],
                      ),
                      TextFormField(
                          initialValue: widget.isEditing
                              ? widget.productsCompanion!.price.value.toString()
                              : null,
                          keyboardType: TextInputType.number,
                          onSaved: (newValue) => _price = int.parse(newValue!),
                          decoration:
                              InputDecoration(labelText: 'Harga per satuan')),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: Colors.blue,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              _formKey.currentState!.save();
                              widget.isEditing
                                  ? BlocProvider.of<ProductsCubit>(context)
                                      .updateProduct(ProductsCompanion(
                                          id: widget.productsCompanion!.id,
                                          category: moor.Value(_category),
                                          productName: moor.Value(_productName),
                                          uom: moor.Value(_unitOfMeasurement),
                                          price: moor.Value(_price)))
                                  : BlocProvider.of<ProductsCubit>(context)
                                      .addProduct(ProductsCompanion(
                                          category: moor.Value(_category),
                                          productName: moor.Value(_productName),
                                          uom: moor.Value(_unitOfMeasurement),
                                          price: moor.Value(_price)));
                              Navigator.pop(context);
                              BlocProvider.of<ProductsCubit>(context)
                                  .getAllProducts();
                            },
                            child: Text(
                              'SUBMIT',
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                    ],
                  );
                },
              ),
            )),
      ),
    );
  }

  Future<dynamic> uomDialog(BuildContext context, String mode) {
    return showDialog(
      context: context,
      builder: (context) {
        var _formKey = GlobalKey<FormState>();
        String _value = '';
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
                          mode == 'uom' ? 'Unit Baru' : 'Kategori Baru',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        TextFormField(
                            onChanged: (newValue) => _value = newValue,
                            onSaved: (newValue) => _value = newValue!,
                            decoration: InputDecoration(
                                labelText: mode == 'uom'
                                    ? 'Unit Baru'
                                    : 'Kategori Baru')),
                        ElevatedButton(
                            onPressed: () {
                              _formKey.currentState!.save();
                              mode == 'uom'
                                  ? BlocProvider.of<FormCubit>(context)
                                      .saveUom(_value)
                                  : BlocProvider.of<FormCubit>(context)
                                      .saveCategory(_value);
                              BlocProvider.of<FormCubit>(context)
                                  .getAllEntries();
                              Navigator.pop(context);
                            },
                            child: Text('Submit'))
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
