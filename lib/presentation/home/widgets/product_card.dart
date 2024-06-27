import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_kasir_apps/core/constants/variable.dart';
import 'package:new_kasir_apps/core/exstensions/int_ext.dart';
import 'package:new_kasir_apps/data/model/respons/product_respons.dart';
import 'package:new_kasir_apps/presentation/home/bloc/checkout/checkout_bloc.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';

class ProductCard extends StatelessWidget {
  final Product data;
  final VoidCallback onCartButton;

  const ProductCard({
    Key? key,
    required this.data,
    required this.onCartButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: AppColors.card),
            borderRadius: BorderRadius.circular(19),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.disabled.withOpacity(0.4),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return CachedNetworkImage(
                      imageUrl: '${Variable.imageBaseUrl}${data.image}',
                      width: constraints
                          .maxWidth, // Lebar maksimal gambar adalah lebar layar
                      height: constraints
                          .maxWidth, // Tinggi maksimal sesuai lebar agar tetap kotak
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.food_bank,
                        color: AppColors.primary,
                      ),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    );
                  },
                ),
              ),
            ),
            const Spacer(),
            Text(
              data.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SpaceHeight(8.0),
            Text(
              data.category,
              style: const TextStyle(
                color: AppColors.grey,
                fontSize: 12,
              ),
            ),
            const SpaceHeight(8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    data.price.currencyFormatRp,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context
                        .read<CheckoutBloc>()
                        .add(CheckoutEvent.addCheckout(data));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(9.0)),
                      color: AppColors.primary,
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 15,
                      color: Colors.white,
                    ), //Assets.icons.orders.svg(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          return state.maybeWhen(
              orElse: () => const SizedBox(),
              success: (products, qty, price) {
                if (qty == 0) {
                  return const SizedBox();
                }

                return products.any((element) => element.product == data)
                    ? products
                                .firstWhere(
                                    (element) => element.product == data)
                                .quantity >
                            0
                        ? Positioned(
                            top: 8,
                            right: 8,
                            child: CircleAvatar(
                              backgroundColor: AppColors.primary,
                              child: Text(
                                products
                                    .firstWhere(
                                        (element) => element.product == data)
                                    .quantity
                                    .toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ))
                        : SizedBox()
                    : SizedBox();
              });
        },
      )
    ]);
  }
}
