import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_kasir_apps/core/components/buttons.dart';
import 'package:new_kasir_apps/core/components/custom_text_field.dart';
import 'package:new_kasir_apps/core/components/spaces.dart';
import 'package:new_kasir_apps/core/constants/colors.dart';
import 'package:new_kasir_apps/core/exstensions/build_context_ext.dart';
import 'package:new_kasir_apps/core/exstensions/int_ext.dart';
import 'package:new_kasir_apps/core/exstensions/string_ext.dart';
import 'package:new_kasir_apps/data/data_sources/sqlite_product_local_data.dart';
import 'package:new_kasir_apps/presentation/order/bloc/order/order_bloc.dart';
import 'package:new_kasir_apps/presentation/order/models/order_model.dart';
import 'package:new_kasir_apps/presentation/order/widgets/button_uang.dart';
import 'package:new_kasir_apps/presentation/order/widgets/payment_success_dialog.dart';

class PaymentCashDialog extends StatefulWidget {
  final int price;
  const PaymentCashDialog({super.key, required this.price});

  @override
  State<PaymentCashDialog> createState() => _PaymentCashDialogState();
}

class _PaymentCashDialogState extends State<PaymentCashDialog> {
  TextEditingController? priceController;

  @override
  void initState() {
    priceController =
        TextEditingController(text: widget.price.currencyFormatRp);

    super.initState();
  }

  void _showDenominationsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DenominationList(
          onDenominationSelected: (denomination) {
            setState(() {
              priceController!.text = denomination;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Stack(
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: Icon(Icons.highlight_off),
            color: AppColors.primary,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                'Pembayaran - Tunai',
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: priceController!,
            label: '',
            showLabel: false,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final int priceValue = value.toIntegerFromText;
              priceController!.text = priceValue.currencyFormatRp;
              priceController!.selection = TextSelection.fromPosition(
                  TextPosition(offset: priceController!.text.length));
            },
          ),
          Flexible(
            child: Button.outlined(
              onPressed: () {
                _showDenominationsModal(context);
              },
              label: 'pilih',
              textColor: AppColors.primary,
              fontSize: 13.0,
              height: 25,
              width: 80,
            ),
          ),
          SpaceHeight(30.0),
          BlocConsumer<OrderBloc, OrderState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                success:
                    (data, qty, total, payment, nominal, idKasir, namaKasir) {
                  final orderModel = OrderModel(
                    paymentMethod: payment,
                    nominalBayar: nominal,
                    orders: data,
                    totalQuantity: qty,
                    totalPrice: total,
                    namaKasir: namaKasir,
                    idKasir: idKasir,
                    transactionTime: DateFormat('yyyy-MM-ddTHH:mm:ss')
                        .format(DateTime.now()),
                    isSync: false,
                  );
                  ProductLocalData.instance.saveOrder(orderModel);
                  context.pop();
                  showDialog(
                      context: context,
                      builder: (context) => PaymentSuccessDialog());
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return SizedBox();
                },
                success: (data, qty, total, payment, _, idKasir, namaKasir) {
                  return Button.filled(
                      onPressed: () {
                        context.read<OrderBloc>().add(
                            OrderEvent.addNominalbayar(
                                priceController!.text.toIntegerFromText));
                      },
                      label: 'Prosess');
                },
              );
              // return Button.filled(
              //     onPressed: () {
              //       context.pop();
              //       showDialog(
              //         context: context,
              //         builder: (context) => PaymentSuccessDialog(),
              //       );
              //     },
              //     label: 'Proses');
            },
          )
        ],
      ),
    );
  }
}
