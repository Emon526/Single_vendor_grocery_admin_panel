import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../consts/consts.dart';
import '../controller/MenuController.dart';
import '../inner_screens/add_product.dart';
import '../responsive.dart';
import '../services/utils.dart';
import '../widgets/button_widget.dart';
import '../widgets/grid_product.dart';
import '../widgets/header.dart';
import '../widgets/orders_list.dart';
import '../widgets/text_widget.dart';

class DashBoardScreens extends StatelessWidget {
  const DashBoardScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    Color color = Utils(context).color;
    return SafeArea(
        child: SingleChildScrollView(
      controller: ScrollController(),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Header(
              title: 'Dashboard',
              fct: () {
                context.read<MenuController>().controlDashboardMenu();
              }),
          TextWidget(
            text: 'Latest Products',
            color: color,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ButtonWidget(
                  onpressed: () {},
                  text: 'View All',
                  icon: Icons.store,
                  backgroundColor: Colors.blue,
                ),
                const Spacer(),
                ButtonWidget(
                  onpressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UploadProductForm(),
                        ));
                  },
                  text: 'Add Product',
                  icon: Icons.add,
                  backgroundColor: Colors.blue,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                // flex: 5,
                child: Column(
                  children: [
                    // ProductWidget(),
                    Responsive(
                      mobile: ProductGrid(
                        crossAxisCount: size.width < 650 ? 2 : 4,
                        childAspectRatio:
                            size.width < 650 && size.width > 350 ? 1.1 : .8,
                      ),
                      desktop: ProductGrid(
                        childAspectRatio: size.width < 1400 ? .8 : 1.05,
                      ),
                    ),
                    const OrdersList(),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
