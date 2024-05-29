import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_kasir_apps/core/constants/colors.dart';
import 'package:new_kasir_apps/data/data_sources/auth_local.dart';
import 'package:new_kasir_apps/data/data_sources/auth_remote.dart';
import 'package:new_kasir_apps/data/data_sources/product_remote.dart';
import 'package:new_kasir_apps/presentation/auth/bloc/login/login_bloc.dart';
import 'package:new_kasir_apps/presentation/auth/pages/login_page.dart';
import 'package:new_kasir_apps/presentation/home/bloc/bloc/checkout_bloc.dart';
import 'package:new_kasir_apps/presentation/home/bloc/logout/logout_bloc.dart';
import 'package:new_kasir_apps/presentation/home/bloc/products/product_bloc.dart';
import 'package:new_kasir_apps/presentation/home/pages/dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRemote()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(
            AuthRemote(),
          ),
        ),
        BlocProvider(
          create: (context) => ProductBloc(ProductRemote())
            ..add(const ProductEvent.fetchLocal()),
        ),
        BlocProvider(create: (context) => CheckoutBloc())
      ],
      child: MaterialApp(
        title: 'Flutter',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
          textTheme: GoogleFonts.quicksandTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            color: AppColors.white,
            elevation: 0,
            titleTextStyle: GoogleFonts.quicksand(
              color: AppColors.primary,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            iconTheme: const IconThemeData(
              color: AppColors.primary,
            ),
          ),
        ),
        home: FutureBuilder<bool>(
            future: AuthLocal().isAuth(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == true) {
                return const DashboardPage();
              } else {
                return const LoginPage();
              }
            }),
      ),
    );
  }
}
