import 'package:flutter/material.dart';

class MenuController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _gridscaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _addProductscaffoldKey =
      GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _ordersscaffoldKey =
      GlobalKey<ScaffoldState>();

  //getters
  GlobalKey<ScaffoldState> get getScaffoldKey => _scaffoldKey;
  GlobalKey<ScaffoldState> get getGridscaffoldKey => _gridscaffoldKey;
  GlobalKey<ScaffoldState> get getAddProductscaffoldKey =>
      _addProductscaffoldKey;
  GlobalKey<ScaffoldState> get getOrderscaffoldKey => _ordersscaffoldKey;

  //Callbacks
  void controlDashboardMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void controlProductMenu() {
    if (!_gridscaffoldKey.currentState!.isDrawerOpen) {
      _gridscaffoldKey.currentState!.openDrawer();
    }
  }

  void controlAddProductsMenu() {
    if (!_addProductscaffoldKey.currentState!.isDrawerOpen) {
      _addProductscaffoldKey.currentState!.openDrawer();
    }
  }

  void controlAllOrders() {
    if (!_ordersscaffoldKey.currentState!.isDrawerOpen) {
      _ordersscaffoldKey.currentState!.openDrawer();
    }
  }
}
