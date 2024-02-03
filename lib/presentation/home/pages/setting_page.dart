import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kasir_apps_frontend/core/constants/colors.dart';
import 'package:flutter_kasir_apps_frontend/data/data_sources/auth_local.dart';
import 'package:flutter_kasir_apps_frontend/data/data_sources/sqlite_product_local_data.dart';
import 'package:flutter_kasir_apps_frontend/presentation/auth/pages/login_page.dart';
import 'package:flutter_kasir_apps_frontend/presentation/home/bloc/logout/logout_bloc.dart';
import 'package:flutter_kasir_apps_frontend/presentation/home/bloc/products/product_bloc.dart';

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
          BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              state.maybeMap(
                orElse: () {},
                success: (_) async {
                  await ProductLocalData.instance.deleteAllProduct();
                  await ProductLocalData.instance.insertProduct(_.products.toList());
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
