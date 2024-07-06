import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:new_kasir_apps/data/model/respons/product_respons.dart';
import 'package:new_kasir_apps/presentation/home/models/item_order.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';
part 'checkout_bloc.freezed.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(_Success([], 0, 0)) {
    on<_AddCheckout>((event, emit) {
      var currentStates = state as _Success;
      List<OrderItem> newCheckout = [...currentStates.products];
      emit(const _Loading());

      if (newCheckout.any((element) => element.product == event.product)) {
        var index = newCheckout
            .indexWhere((element) => element.product == event.product);
        newCheckout[index].quantity++;
      } else {
        newCheckout.add(OrderItem(product: event.product, quantity: 1));
      }

      // int totalQuantity = newCheckout.fold(
      //     0, (previousValue, element) => previousValue + element.quantity);
      int totalQuantity = 0;
      int totalPrice = 0;
      for (var element in newCheckout) {
        totalQuantity += element.quantity;
        totalPrice += element.quantity * element.product.price;
      }
      emit(_Success(newCheckout, totalQuantity, totalPrice));
    });

    on<_Started>((event, emit) {
      emit(_Loading());
      emit(_Success([], 0, 0));
    });

    on<_RemoveCheckout>((event, emit) {
      // Mendapatkan state saat ini dan menginisialisasi variabel newCheckout
      var currentStates = state as _Success;
      List<OrderItem> newCheckout = [...currentStates.products];

      // Memancarkan event _Loading untuk menunjukkan bahwa proses sedang berlangsung
      emit(const _Loading());

      // Memeriksa apakah ada item di keranjang belanja yang sesuai dengan event
      if (newCheckout.any((element) => element.product == event.product)) {
        // Jika item ditemukan, cari indeksnya dalam newCheckout
        var index = newCheckout
            .indexWhere((element) => element.product == event.product);

        // Jika jumlah item lebih dari 1, kurangi jumlahnya. Jika tidak, hapus item tersebut dari keranjang belanja
        if (newCheckout[index].quantity > 1) {
          newCheckout[index].quantity--;
        } else {
          newCheckout.removeAt(index);
        }
      }

      // Menghitung total kuantitas dan total harga untuk item-item yang tersisa dalam keranjang belanja baru
      int totalQuantity = 0;
      int totalPrice = 0;
      for (var element in newCheckout) {
        totalQuantity += element.quantity;
        totalPrice += element.quantity * element.product.price;
      }

      // Memancarkan state _Success baru dengan keranjang belanja yang diperbarui, total kuantitas, dan total harga
      emit(_Success(newCheckout, totalQuantity, totalPrice));
    });
    on<_RemoveAllCheckout>((event, emit) {
      var currentStates = state as _Success;
      List<OrderItem> newCheckout = [...currentStates.products];

      // Remove hanya produk yang sesuai dengan event.product
      newCheckout.removeWhere((item) => item.product == event.product);

      int totalQuantity = 0;
      int totalPrice = 0;
      for (var element in newCheckout) {
        totalQuantity += element.quantity;
        totalPrice += element.quantity * element.product.price;
      }

      emit(_Success(newCheckout, totalQuantity, totalPrice));
    });
  }
}
