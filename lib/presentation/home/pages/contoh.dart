// import 'package:flutter/material.dart';
// import 'package:new_kasir_apps/core/constants/colors.dart';
// import 'package:new_kasir_apps/presentation/history/pages/history_page.dart';
// import 'package:new_kasir_apps/presentation/home/pages/home_page.dart';
// import 'package:new_kasir_apps/presentation/order/pages/order_page.dart';
// import 'package:new_kasir_apps/presentation/setting/pages/setting_page.dart';

// class DashboardPage extends StatefulWidget {
//   const DashboardPage({Key? key}) : super(key: key);

//   @override
//   _DashboardPageState createState() => _DashboardPageState();
// }

// class _DashboardPageState extends State<DashboardPage> {
//   int _selectedIndex = 0;

//   final List<Widget> _pages = [
//     const HomePage(),
//     const OrderPage(),
//     HistoryPage(),
//     const SettingPage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dashboard'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.dashboard),
//             onPressed: () {
//               _onItemTapped(3); // Panggil _onItemTapped dengan indeks 3 saat ikon di-klik
//             },
//           ),
//         ],
//       ),
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.all(20.0),
//         decoration: BoxDecoration(
//           borderRadius: const BorderRadius.vertical(
//             top: Radius.circular(30),
//           ),
//           color: AppColors.white,
//           boxShadow: [
//             BoxShadow(
//               offset: const Offset(0, -2),
//               blurRadius: 30.0,
//               blurStyle: BlurStyle.outer,
//               spreadRadius: 0,
//               color: AppColors.black.withOpacity(0.08),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             // Hapus NavItem untuk "Home", "Orders", dan "History"
//             // NavItem(
//             //   iconPath: Assets.icon.home.path,
//             //   label: 'Home',
//             //   isActive: _selectedIndex == 0,
//             //   onTap: () => _onItemTapped(0),
//             // ),
//             // NavItem(
//             //   iconPath: Assets.icon.orders.path,
//             //   label: 'Orders',
//             //   isActive: _selectedIndex == 1,
//             //   onTap: () => _onItemTapped(1),
//             // ),
//             // NavItem(
//             //   iconPath: Assets.icon.payments.path,
//             //   label: 'History',
//             //   isActive: _selectedIndex == 2,
//             //   onTap: () => _onItemTapped(2),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
// }

// // Mockup for NavItem, replace with your actual implementation
// class NavItem extends StatelessWidget {
//   final String iconPath;
//   final String label;
//   final bool isActive;
//   final VoidCallback onTap;

//   const NavItem({
//     required this.iconPath,
//     required this.label,
//     required this.isActive,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(Icons.home),
//           SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               color: isActive ? Colors.blue : Colors.grey,
//               fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
