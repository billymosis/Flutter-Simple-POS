import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moor_db_viewer/moor_db_viewer.dart';
import 'package:project_pos/Bloc/cubit/form_cubit.dart';
import 'package:project_pos/Data/Data_Provider/Platform_Helper/shared.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Container(
              child: Text(
                'TOKO KEPUH JAYA',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white),
              ),
            )),
        ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/');
            },
            leading: Icon(Icons.shopping_cart),
            title: Text('Cashier')),
        ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/invoice');
            },
            leading: Icon(Icons.contact_page),
            title: Text('Receipts')),
        ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/products');
            },
            leading: Icon(Icons.carpenter),
            title: Text('Products')),
        ListTile(
          onTap: () {
            final db = constructDb(); //This should be a singleton
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MoorDbViewer(db)));
          },
          title: Text('Debug'),
          leading: Icon(Icons.bug_report),
        ),
        ListTile(
          onTap: () {
            BlocProvider.of<FormCubit>(context).deleteAll();
          },
          title: Text('Reset Category and Unit'),
          leading: Icon(Icons.delete),
        )
      ]),
    );
  }
}
