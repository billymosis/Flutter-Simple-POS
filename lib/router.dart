import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_pos/Bloc/cubit/invoice_cubit.dart';
import 'package:project_pos/Data/Data_Provider/database.dart';
import 'package:project_pos/Presentation/Screens/addoredit.dart';
import 'package:project_pos/Presentation/Screens/screens.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => CheckOutScreen(),
        );
      case '/products':
        return MaterialPageRoute(builder: (context) {
          return ProductsScreen();
        });
      case '/invoice':
        return MaterialPageRoute(builder: (context) {
          BlocProvider.of<InvoiceCubit>(context).getAllInvoiceItems();
          return InvoiceScreen();
        });
      case '/add_product':
        return MaterialPageRoute(
            builder: (context) => AddorEdit(
                  isEditing: false,
                ));
      case '/edit_product':
        return MaterialPageRoute(
            settings: settings,
            builder: (context) {
              var x = ModalRoute.of(context)!.settings.arguments
                  as ProductsCompanion;
              print(x);
              final args = ModalRoute.of(context)!.settings.arguments
                  as ProductsCompanion;
              return AddorEdit(
                isEditing: true,
                productsCompanion: args,
              );
            });
      default:
        throw Exception();
    }
  }
}