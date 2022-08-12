import 'package:flutter/widgets.dart';
import 'package:grocery_admin_panel/responsive.dart';
import 'package:grocery_admin_panel/services/utils.dart';
import 'package:grocery_admin_panel/widgets/grid_product.dart';
import 'package:grocery_admin_panel/widgets/product_widget.dart';
import 'package:provider/provider.dart';

import '../consts/consts.dart';
import '../controller/MenuController.dart';
import '../widgets/header.dart';

class DashBoardScreens extends StatelessWidget {
  const DashBoardScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return SafeArea(
        child: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Header(fct: () {
            context.read<MenuController>().controlDashboardMenu();
          }),
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
