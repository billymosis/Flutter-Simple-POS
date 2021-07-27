import 'package:flutter/material.dart';
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
        return MaterialPageRoute(builder: (context) => ProductsScreen());
      case '/invoice':
        return MaterialPageRoute(builder: (context) => InvoiceScreen());
      case '/add_product':
        return MaterialPageRoute(
            builder: (context) => AddorEdit(
                  isEditing: false,
                ));
      case '/edit_product':
        return MaterialPageRoute(
            settings: settings,
            builder: (context) {
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
