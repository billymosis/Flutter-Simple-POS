import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:project_pos/Data/Data_Provider/database.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  var x = SharedDatabase.x;

  void getAllProducts() async {
    var z = await x.allProductEntries;
    emit(ProductsInitial(products: z));
  }

  void getProductById(String id) async {
    Product re = await x.selectProductById(id);
    emit(ProductsInitial(products: [re]));
  }

  void addProduct(ProductsCompanion pc) async {
    x.addProduct(pc);
  }

  void updateProduct(ProductsCompanion pc) async {
    x.updateProduct(pc);
  }

  void deleteProduct(List<String> id) async {
    x.deleteProductByList(id);
  }
}
