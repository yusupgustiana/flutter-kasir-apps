import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new_kasir_apps/core/constants/variable.dart';
import 'package:new_kasir_apps/data/model/respons/product_respons.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';

class MenuProductItem extends StatelessWidget {
  final Product data;
  const MenuProductItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 3, color: AppColors.blueLight),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            child: CachedNetworkImage(
              imageUrl: '${Variable.imageBaseUrl}${data.image}',
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(
                Icons.food_bank_outlined,
                size: 80,
              ),
              width: 80,
              height: 80,
              fit: BoxFit
                  .cover, // Mengubah ukuran gambar agar sesuai tanpa memotong bagian atas
              alignment: Alignment
                  .topCenter, // Mengatur gambar agar bagian atasnya terlihat
            ),
          ),
          const SpaceWidth(10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SpaceHeight(5.0),
                Text(
                  data.category,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SpaceHeight(10.0),
                Row(
                  children: [
                    Expanded(
                      child: Button.filled(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  contentPadding: const EdgeInsets.all(16.0),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data.name,
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(Icons.close),
                                          ),
                                        ],
                                      ),
                                      const SpaceHeight(10.0),
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              '${Variable.imageBaseUrl}${data.image}',
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.food_bank_outlined,
                                            size: 80,
                                          ),
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.contain,
                                          alignment: Alignment.topCenter,
                                        ),
                                      ),
                                      const SpaceHeight(10.0),
                                      Text(
                                        data.category,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SpaceHeight(10.0),
                                      Text(
                                        data.price.toString(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SpaceHeight(10.0),
                                      Text(
                                        data.stock.toString(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SpaceHeight(10.0),
                                    ],
                                  ),
                                );
                              });
                        },
                        label: 'Detail',
                        fontSize: 8.0,
                        height: 31,
                      ),
                    ),
                    Expanded(
                      child: Button.filled(
                        onPressed: () {
                          // context.push(EditProductPage(data: data));
                        },
                        label: 'Ubah Produk',
                        fontSize: 8.0,
                        color: Colors.blueAccent,
                        height: 31,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
