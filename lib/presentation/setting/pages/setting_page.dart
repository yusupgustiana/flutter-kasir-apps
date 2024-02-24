import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kasir_apps_frontend/core/assets/assets.gen.dart';
import 'package:flutter_kasir_apps_frontend/core/components/menu_button.dart';
import 'package:flutter_kasir_apps_frontend/core/components/spaces.dart';
import 'package:flutter_kasir_apps_frontend/core/constants/colors.dart';
import 'package:flutter_kasir_apps_frontend/core/exstensions/build_context_ext.dart';
import 'package:flutter_kasir_apps_frontend/data/data_sources/auth_local.dart';
import 'package:flutter_kasir_apps_frontend/data/data_sources/sqlite_product_local_data.dart';
import 'package:flutter_kasir_apps_frontend/presentation/auth/pages/login_page.dart';
import 'package:flutter_kasir_apps_frontend/presentation/home/bloc/logout/logout_bloc.dart';
import 'package:flutter_kasir_apps_frontend/presentation/home/bloc/products/product_bloc.dart';
import 'package:flutter_kasir_apps_frontend/presentation/home/pages/manage_printer_page.dart';
import 'package:flutter_kasir_apps_frontend/presentation/setting/pages/manage_product_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('setting'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(children: [
            MenuButton(
              iconPath: Assets.images.manageProduct.path,
              label: 'Kelola Product',
              onPressed: () => context.push(const ManageProductPage()),
              isImage: true,
            ),
            const SpaceWidth(15.0),
            MenuButton(
              iconPath: Assets.images.managePrinter.path,
              label: 'Kelola Printer',
              onPressed: () => context.push(const ManagePrinterPage()),
              isImage: true,
            ),
          ]),
          BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              state.maybeMap(
                orElse: () {},
                success: (_) async {
                  await ProductLocalData.instance.deleteAllProduct();
                  await ProductLocalData.instance.insertAllProduct(_.products.toList());
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: AppColors.primary,
                    content: Text('data updated'),
                  ));
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return ElevatedButton(
                      onPressed: () {
                        context.read<ProductBloc>().add(ProductEvent.fetch());
                      },
                      child: const Text('data'));
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            },
          ),
          const Divider(),
          BlocConsumer<LogoutBloc, LogoutState>(
            listener: (context, state) {
              state.maybeMap(
                  orElse: () {},
                  success: (_) {
                    AuthLocal().removeAuth();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                  });
            },
            builder: (context, state) {
              return ElevatedButton(
                  onPressed: () {
                    context.read<LogoutBloc>().add(const LogoutEvent.logout());
                  },
                  child: const Text('logout'));
            },
          ),
          const Divider()
        ],
      ),
    );
  }
}
