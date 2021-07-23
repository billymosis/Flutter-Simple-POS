import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  const MainAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text('$title'));
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
