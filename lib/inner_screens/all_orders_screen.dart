import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../controller/MenuController.dart';
import '../responsive.dart';
import '../services/utils.dart';
import '../widgets/header.dart';
import '../widgets/orders_list.dart';
import '../widgets/side_menu.dart';

class AllOrderScreen extends StatefulWidget {
  const AllOrderScreen({Key? key}) : super(key: key);

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      key: context.read<MenuController>().getOrderscaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            const Expanded(
              child: SideMenu(),
            ),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Header(
                      title: 'All Orders',
                      fct: () {
                        context.read<MenuController>().controlAllOrders();
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: OrdersList(),
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
