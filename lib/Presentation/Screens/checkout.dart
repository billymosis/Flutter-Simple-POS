import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_pos/Presentation/Widgets/widgets.dart';
import 'package:project_pos/responsive.dart';

class CheckOutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final numberFormat =
        NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);
    return Scaffold(
        drawer: DrawerWidget(),
        appBar: MainAppBar(
          title: 'Kasir',
        ),
        body: Responsive(
          mobile: Stack(children: [
            ItemGrid(),
            DraggableScrollableSheet(
                initialChildSize: 0.30,
                builder: (context, scrollController) => Container(
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(50))),
                      child: ListView(controller: scrollController, children: [
                        Container(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Icon(Icons.arrow_upward),
                              ),
                              CartTotalPrice(numberFormat: numberFormat),
                              CartPayButton(),
                              HeaderCartList(),
                              SideCartList(),
                            ],
                          ),
                        ),
                      ]),
                    ))
          ]),
          tablet: Container(
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: ItemGrid(),
                ),
                Expanded(flex: 4, child: ItemListCart())
              ],
            ),
          ),
        ));
  }
}
