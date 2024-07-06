import 'package:flutter/material.dart';
import 'package:new_kasir_apps/core/exstensions/int_ext.dart';
import 'package:new_kasir_apps/presentation/order/models/order_model.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/constants/colors.dart';

class HistoryTransactionCard extends StatelessWidget {
  final OrderModel data;
  final EdgeInsetsGeometry? padding;

  const HistoryTransactionCard({
    super.key,
    required this.data,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 48.0,
            blurStyle: BlurStyle.outer,
            spreadRadius: 0,
            color: AppColors.black.withOpacity(0.06),
          ),
        ],
      ),
      child: ListTile(
        leading: Assets.icon.payments.svg(),
        title: Text(data.paymentMethod),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${data.totalQuantity} items'),
            Text(
              'Kasir : ${data.namaKasir}',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: Text(
          data.totalPrice.currencyFormatRp,
          style: const TextStyle(
            color: AppColors.green,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
