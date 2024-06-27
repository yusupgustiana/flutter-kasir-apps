import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:new_kasir_apps/data/data_sources/order_remote.dart';
import 'package:new_kasir_apps/data/data_sources/sqlite_product_local_data.dart';
import 'package:new_kasir_apps/data/model/request/order_request-model.dart';

part 'sync_order_event.dart';
part 'sync_order_state.dart';
part 'sync_order_bloc.freezed.dart';

class SyncOrderBloc extends Bloc<SyncOrderEvent, SyncOrderState> {
  final OrderRemote orderRemote;

  SyncOrderBloc(this.orderRemote) : super(_Initial()) {
    on<_SendOrder>((event, emit) async {
      emit(SyncOrderState.loading());
      //get order from local is sync
      final orderIsSyncZero =
          await ProductLocalData.instance.getOrderByIsSync();
      for (final order in orderIsSyncZero) {
        final orderItems = await ProductLocalData.instance
            .getOrderItemByOrderIdLocal(order.id!);

        final orderRequest = OrderRequestModel(
            transactionTime: order.transactionTime,
            kasirId: order.idKasir,
            totalPrice: order.totalPrice,
            totalItem: order.totalQuantity,
            paymentMethod: order.paymentMethod,
            orderItems: orderItems
            // .map((e) => OrderItemModel(
            //     productId: e.productId,
            //     quantity: e.quantity,
            //     totalPrice: e.totalPrice * e.quantity))
            // .toList(),
            );
        final response = await orderRemote.sendOrder(orderRequest);
        if (response) {
          await ProductLocalData.instance.updateIsSyncOrderById(order.id!);
        }
      }

      emit(SyncOrderState.success());
      // final response = await orderRemote.sendOrder(orderRequest);
      // if (response) {
      //   emit(SyncOrderState.success());
      // } else {
      //   emit(SyncOrderState.error('Failed to send order'));
      // }
    });
  }
}
