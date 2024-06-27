import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_kasir_apps/core/exstensions/int_ext.dart';
import 'package:new_kasir_apps/presentation/home/bloc/checkout/checkout_bloc.dart';

import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';

class ProcessButton extends StatelessWidget {
  final int price;
  final VoidCallback onPressed;

  const ProcessButton({
    super.key,
    required this.price,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
          color: AppColors.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // Menyebarkan elemen secara merata
          children: [
            BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return const Text(
                      '0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  },
                  success: (data, qty, total) {
                    return Text(
                      total.currencyFormatRp,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  },
                );
              },
            ),
            Row(
              children: [
                const Text(
                  'Proses',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SpaceWidth(5.0),
                const Icon(
                  Icons.add_shopping_cart_rounded,
                  color: AppColors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
