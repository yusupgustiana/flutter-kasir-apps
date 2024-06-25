part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.started() = _Started;
  factory ProductEvent.fetch() = _Fetch;
  const factory ProductEvent.fetchByCategory(String category) = _FetchByCategory;
  const factory ProductEvent.fetchLocal() = _FetchLocal;
//add product
const factory ProductEvent.addProduct( Product product, XFile image) = _AddProduct;
//search for products
const factory ProductEvent.searchProduct(String query) = _SearchProduct;
//fecth all from state
const factory ProductEvent.fetchAllFromState() = _FetchAllFromState;
}