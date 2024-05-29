import 'package:flutter/material.dart';
import 'package:new_kasir_apps/core/exstensions/build_context_ext.dart';
import 'package:new_kasir_apps/core/gen/assets.gen.dart';
import 'package:new_kasir_apps/presentation/home/pages/home_page.dart';
import 'package:new_kasir_apps/presentation/home/pages/order_page.dart';
import 'package:new_kasir_apps/presentation/home/widgets/nav_item.dart';
import 'package:new_kasir_apps/presentation/setting/pages/manage_product_page.dart';
import 'package:new_kasir_apps/presentation/setting/pages/setting_page.dart';

import '../../../core/constants/colors.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [const HomePage(), const OrderPage(), const ManageProductPage(), const SettingPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: 30.0,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              color: AppColors.black.withOpacity(0.08),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
              iconPath: Assets.icon.home.path,
              label: 'Home',
              isActive: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            NavItem(
                iconPath: Assets.icon.orders.path,
                label: 'Orders',
                isActive: _selectedIndex == 1,
                onTap: () {
                  // _onItemTapped(1);
                  context.push(const OrderPage());
                }),
            NavItem(
              iconPath: Assets.icon.payments.path,
              label: 'History',
              isActive: _selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            NavItem(
              iconPath: Assets.icon.dashboard.path,
              label: 'Kelola',
              isActive: _selectedIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
