import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/MenuController.dart';
import '../responsive.dart';
import '../services/utils.dart';
import '../widgets/grid_product.dart';
import '../widgets/header.dart';
import '../widgets/side_menu.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({Key? key}) : super(key: key);

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      key: context.read<MenuController>().getGridscaffoldKey,
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
                      title: 'All Products',
                      fct: () {
                        context.read<MenuController>().controlProductMenu();
                      }),
                  const SizedBox(
                    height: 25,
                  ),
                  Responsive(
                    mobile: ProductGrid(
                      crossAxisCount: size.width < 650 ? 2 : 4,
                      childAspectRatio:
                          size.width < 650 && size.width > 350 ? 1.1 : .8,
                      isInMain: false,
                    ),
                    desktop: ProductGrid(
                      isInMain: false,
                      childAspectRatio: size.width < 1400 ? .8 : 1.05,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
