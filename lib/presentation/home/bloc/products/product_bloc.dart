import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kasir_apps_frontend/data/data_sources/product_remote.dart';
import 'package:flutter_kasir_apps_frontend/data/data_sources/sqlite_product_local_data.dart';
import 'package:flutter_kasir_apps_frontend/data/model/respons/product_respons.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
      final allProduct = await ProductLocalData.instance.getAllProducts();
      products = allProduct;

      emit(ProductState.success(products));
    });

    on<_FetchByCategory>((event, emit) async {
      emit(const ProductState.loading());

      final newProducts =
          event.category == 'all' ? products : products.where((element) => element.category == event.category).toList();
      emit(ProductState.success(newProducts));
    });
  }
}
