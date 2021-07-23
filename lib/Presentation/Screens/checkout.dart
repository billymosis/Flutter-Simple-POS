import 'package:flutter/material.dart';
import 'package:project_pos/Presentation/Widgets/widgets.dart';

class CheckOutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerWidget(),
        appBar: MainAppBar(
          title: 'Kasir',
        ),
        body: Container(
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: ItemGrid(),
              ),
              Expanded(flex: 4, child: ItemListCart())
            ],
          ),
        ));
  }
}
