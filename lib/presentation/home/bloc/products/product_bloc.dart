import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_kasir_apps/data/data_sources/product_remote.dart';
import 'package:new_kasir_apps/data/data_sources/sqlite_product_local_data.dart';
import 'package:new_kasir_apps/data/model/request/product_request_model.dart';
import 'package:new_kasir_apps/data/model/respons/product_respons.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRemote _productRemote;
  List<Product> products = [];
  ProductBloc(this._productRemote) : super(const _Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const ProductState.loading());
      final response = await _productRemote.getProducts();
      response.fold((l) => emit(ProductState.error(l)), (r) {
        products = r.data;
        emit(ProductState.success(r.data));
      });
    });

    on<_FetchLocal>((event, emit) async {
      emit(const ProductState.loading());
      final localProduct = await ProductLocalData.instance.getAllProducts();
      products = localProduct;

      emit(ProductState.success(products));
    });

    on<_FetchByCategory>((event, emit) async {
      emit(const ProductState.loading());

      final newProducts = event.category == 'all'
          ? products
          : products
              .where((element) => element.category == event.category)
              .toList();
      emit(ProductState.success(newProducts));
    });

    on<_AddProduct>((event, emit) async {
      emit(const ProductState.loading());

      final requestData = ProductRequestModel(
        name: event.product.name,
        price: event.product.price,
        stock: event.product.stock,
        category: event.product.category,
        isBestSeller: event.product.isBestSeller ? 1 : 0,
        image: event.image,
      );

      final response = await _productRemote.addProduct(requestData);
      response.fold(
        (error) {
          emit(ProductState.error(error)); // Tangani kesalahan
        },
        (data) {
          // Tangani hasil respons sukses
          products.add(data.data);
          emit(ProductState.success(products));
        },
      );
    });
  }
}
