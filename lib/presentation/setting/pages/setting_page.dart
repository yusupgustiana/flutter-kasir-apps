import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_kasir_apps/core/constants/colors.dart';
import 'package:new_kasir_apps/core/exstensions/build_context_ext.dart';
import 'package:new_kasir_apps/presentation/setting/pages/manage_printer.dart';
import 'package:new_kasir_apps/presentation/setting/pages/sync_data_page.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/menu_button.dart';
import '../../../core/components/spaces.dart';
import '../../../data/data_sources/auth_local.dart';
import '../../auth/pages/login_page.dart';
import '../../home/bloc/logout/logout_bloc.dart';
import 'manage_product_page.dart';
import 'save_server_key_page.dart';

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
        title: const Text('Setting'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    MenuButton(
                      iconPath: Assets.images.manageProduct.path,
                      label: 'Kelola Produk',
                      onPressed: () => context.push(const ManageProductPage()),
                      isImage: true,
                    ),
                    const SpaceWidth(15.0),
                    MenuButton(
                      iconPath: Assets.images.managePrinter.path,
                      label: 'Kelola Printer',
                      onPressed: () {
                        context.push(const ManagePrinterPage());
                      },
                      isImage: true,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    MenuButton(
                      iconPath: Assets.images.manageProduct.path,
                      label: 'QRIS Server Key',
                      onPressed: () => context.push(const SaveServerKeyPage()),
                      isImage: true,
                    ),
                    const SpaceWidth(15.0),
                    MenuButton(
                      iconPath: Assets.images.managePrinter.path,
                      label: 'Sinkronisasi Data',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SyncDatapage(),
                          ),
                        );
                      },
                      isImage: true,
                    ),
                  ],
                ),
              ),
              const SpaceHeight(60),
              const Divider(),
              BlocConsumer<LogoutBloc, LogoutState>(
                listener: (context, state) {
                  state.maybeMap(
                    orElse: () {},
                    success: (_) {
                      AuthLocal().removeAuth();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                  );
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      context
                          .read<LogoutBloc>()
                          .add(const LogoutEvent.logout());
                    },
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Logout'),
                  );
                },
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
