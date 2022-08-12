import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../controller/MenuController.dart';
import '../responsive.dart';
import '../widgets/side_menu.dart';
import 'dashboard_screens.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().getScaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            const Expanded(
              child: SideMenu(),
            ),
          const Expanded(
            flex: 5,
            child: DashBoardScreens(),
          ),
        ],
      )),
    );
  }
}
