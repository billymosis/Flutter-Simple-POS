import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_pos/Bloc/cubit/products_cubit.dart';
import 'package:project_pos/Presentation/Widgets/widgets.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool selectMode = false;
  List<String> selectedList = [];

  delete() {
    setState(() {
      BlocProvider.of<ProductsCubit>(context).deleteProduct(selectedList);
      BlocProvider.of<ProductsCubit>(context).getAllProducts();
      selectedList = [];
      selectMode = false;
    });
  }

  @override
  void initState() {
    BlocProvider.of<ProductsCubit>(context).getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text(selectMode ? 'Delete Product' : 'Product List'),
      ),
      body: Container(child: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          ProductsInitial mystate = state as ProductsInitial;
          return mystate.products.isEmpty
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.carpenter,
                      size: 100,
                      color: Colors.blue,
                    ),
                    Text('Masih belum ada item di database.'),
                    Text(
                        'Silahkan input dengan tombol (+) di pojok kanan bawah.')
                  ],
                ))
              : ListView.builder(
                  itemCount: mystate.products.length,
                  itemBuilder: (context, index) {
                    var _id = mystate.products[index].id;
                    return ListTile(
                      selectedTileColor: Colors.grey.shade300,
                      onLongPress: () {
                        setState(() {
                          selectMode = true;
                          selectedList.add(_id);
                        });
                      },
                      selected: selectedList.contains(_id),
                      onTap: () {
                        if (selectMode) {
                          setState(() {
                            selectedList.contains(_id)
                                ? selectedList.remove(_id)
                                : selectedList.add(_id);
                            if (selectedList.isEmpty) {
                              selectMode = false;
                            }
                          });
                        } else {
                          Navigator.pushNamed(context, '/edit_product',
                              arguments:
                                  mystate.products[index].toCompanion(false));
                        }
                      },
                      title: Text(mystate.products[index].productName),
                      trailing: Text(mystate.products[index].price.toString() +
                          ' / ' +
                          mystate.products[index].uom),
                    );
                  },
                );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          selectMode ? delete() : Navigator.pushNamed(context, '/add_product');
        },
        child: selectMode ? Icon(Icons.delete) : Icon(Icons.add),
      ),
    );
  }
}
