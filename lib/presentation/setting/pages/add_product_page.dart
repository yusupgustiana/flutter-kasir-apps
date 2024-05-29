import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_kasir_apps/core/components/buttons.dart';
import 'package:new_kasir_apps/core/components/custom_dropdown.dart';
import 'package:new_kasir_apps/core/components/custom_text_field.dart';
import 'package:new_kasir_apps/core/components/image_picker_widget.dart';
import 'package:new_kasir_apps/core/components/spaces.dart';
import 'package:new_kasir_apps/data/model/respons/product_respons.dart';
import 'package:new_kasir_apps/presentation/home/bloc/products/product_bloc.dart';
import 'package:new_kasir_apps/presentation/setting/models/category_model.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController? nameController;
  TextEditingController? priceController;
  TextEditingController? stockController;

  String category = 'food';

  XFile? imageFile;

  bool isBestSeller = false;

  final List<CategoryModel> categories = [
    CategoryModel(name: 'Food', value: 'food'),
    CategoryModel(name: 'Drink', value: 'drink'),
    CategoryModel(name: 'Snack', value: 'snack'),
  ];

  @override
  void initState() {
    nameController = TextEditingController();
    priceController = TextEditingController();
    stockController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController!.dispose();
    priceController!.dispose();
    stockController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('tambah Product'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          ImagePickerWidget(
            label: 'Foto Produk',
            onChanged: (file) {
              if (file == null) {
                return;
              }
              imageFile = file;
            },
          ),
          CustomTextField(
            controller: nameController!,
            label: 'Nama Product',
          ),
          const SpaceHeight(20),
          CustomTextField(
            controller: priceController!,
            label: 'Harga',
            keyboardType: TextInputType.number,
            onChanged: (value) {},
          ),
          const SpaceHeight(20),
          CustomTextField(
            controller: stockController!,
            label: 'Stok',
            keyboardType: TextInputType.number,
          ),

          const SpaceHeight(20),
          CustomDropdown<CategoryModel>(
            value: categories.first,
            items: categories,
            label: 'kategori',
            onChanged: (value) {
              category = value!.value;
            },
          ),
          const SpaceHeight(20),
          //bestSeller
          CheckboxListTile(
            title: const Text('Best Seller'),
            value: isBestSeller,
            onChanged: (value) {
              setState(() {
                isBestSeller = value ?? false;
              });
            },
          ),
          const SpaceHeight(20),

          BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              state.maybeMap(
                orElse: () {},
                success: (_) {
                  Navigator.pop(context);
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                error: (message) => Text(message),
                success: (_) {
                  return Button.filled(
                    onPressed: () {
                      final String name = nameController!.text;
                      final int? price = int.tryParse(priceController!.text);
                      final int? stock = int.tryParse(stockController!.text);
                      if (price == null || stock == null) {
                        // Handle error when parsing fails
                        return;
                      }
                      final Product product = Product(
                        name: name,
                        category: category,
                        price: price,
                        stock: stock,
                        image: imageFile!.path,
                        isBestSeller: isBestSeller,
                      );
                      context
                          .read<ProductBloc>()
                          .add(ProductEvent.addProduct(product, imageFile!));
                    },
                    label: 'Simpan',
                  );
                },
              );
            },
          ),

          const SpaceHeight(30),
          Button.outlined(
              onPressed: () {
                Navigator.pop(context);
              },
              label: 'Batal'),
          const SpaceHeight(30),
        ],
      ),
    );
  }
}
