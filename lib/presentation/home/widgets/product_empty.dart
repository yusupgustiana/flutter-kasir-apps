import 'package:flutter/material.dart';
import 'package:new_kasir_apps/core/components/spaces.dart';
import 'package:new_kasir_apps/core/constants/colors.dart';
import 'package:new_kasir_apps/core/gen/assets.gen.dart';


class ProductEmpty extends StatelessWidget {
  const ProductEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icon.orders.svg(width: 114.0),
          const SpaceHeight(4.0),
          const Text(
            'Belum ada Produk',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
