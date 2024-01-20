import 'package:flutter/material.dart';
import 'package:flutter_kasir_apps_frontend/core/exstensions/build_context_ext.dart';
import 'package:flutter_kasir_apps_frontend/presentation/home/pages/home_page.dart';
import 'package:flutter_kasir_apps_frontend/presentation/home/pages/manage_menu_page.dart';
import 'package:flutter_kasir_apps_frontend/presentation/home/pages/order_page.dart';
import 'package:flutter_kasir_apps_frontend/presentation/home/widget/nav_item.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/constants/colors.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const OrderPage(),
    const Placeholder(),
    const ManageMenuPage(),
  ];

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
      // floatingActionButton: GestureDetector(
      //   onTap: () => context.push(const AddProductpage()),
      //   child: Container(
      //     padding: const EdgeInsets.all(12.0),
      //     decoration: const BoxDecoration(
      //       shape: BoxShape.circle,
      //       color: AppColors.primary,
      //     ),
      //     child: const Icon(
      //       Icons.add,
      //       color: AppColors.white,
      //       size: 40.0,
      //     ),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
