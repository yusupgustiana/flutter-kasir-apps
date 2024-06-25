import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:new_kasir_apps/data/data_sources/auth_local.dart';
import 'package:new_kasir_apps/presentation/home/models/item_order.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(_Success([], 0, 0, '', 0, 0, '')) {
    on<_AddPaymentMethod>((event, emit) async {
      emit(_Loading());
      final userData = await AuthLocal().getAuth();
      emit(_Success(
          event.orders,
          event.orders.fold(
              0, (previousValue, element) => previousValue + element.quantity),
          event.orders.fold(
              0,
              (previousValue, element) =>
                  previousValue + (element.quantity * element.product.price)),
          event.paymentMethod,
          0,
          userData.user.id,
          userData.user.name));
    });

    on<_AddNominalbayar>((event, emit) {
      var currentStates = state as _Success;
      emit(_Loading());
      emit(_Success(
        currentStates.products,
        currentStates.totalQuantity,
        currentStates.totalPrice,
        currentStates.paymentMethod,
        event.nominal,
        currentStates.idKasir,
        currentStates.namaKasir,
      ));
    });

    on<_Started>((event, emit) {
      emit(_Loading());
      emit(_Success([], 0, 0, '', 0, 0, ''));
    });
  }
}
