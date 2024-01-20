import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kasir_apps_frontend/core/components/buttons.dart';
import 'package:flutter_kasir_apps_frontend/core/components/custom_text_field.dart';
import 'package:flutter_kasir_apps_frontend/core/components/spaces.dart';
import 'package:flutter_kasir_apps_frontend/core/assets/assets.gen.dart';
import 'package:flutter_kasir_apps_frontend/data/data_sources/auth_local.dart';
import 'package:flutter_kasir_apps_frontend/presentation/auth/bloc/login_bloc.dart';
import 'package:flutter_kasir_apps_frontend/presentation/home/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SpaceHeight(80),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 130.0),
            child: Image.asset(
              Assets.images.logo.path,
              width: 100,
              height: 100,
            ),
          ),
          const SpaceHeight(24),
          const Center(
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          const SpaceHeight(8.0),
          const Center(
            child: Text(
              'Login to your account',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ),
          const SpaceHeight(40),
          CustomTextField(controller: usernameController, label: 'username'),
          const SpaceHeight(12.0),
          CustomTextField(
            controller: passwordController,
            label: 'password',
            obscureText: true,
          ),
          const SpaceHeight(24.0),
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                success: (authResponseModel) {
                  AuthLocal().saveAuth(authResponseModel);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                error: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              );
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return Button.filled(
                      onPressed: () {
                        context.read<LoginBloc>().add(LoginEvent.login(
                              email: usernameController.text,
                              password: passwordController.text,
                            ));
                      },
                      label: 'Masuk',
                    );
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
