import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_kasir_apps/core/components/spaces.dart';
import 'package:new_kasir_apps/presentation/history/bloc/bloc/history_bloc.dart';
import 'package:new_kasir_apps/presentation/history/widgets/history_transaction_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  void initState() {
    super.initState();
    context.read<HistoryBloc>().add(HistoryEvent.ended());
  }

  @override
  Widget build(BuildContext context) {
    const paddingHorizontal = EdgeInsets.symmetric(horizontal: 16.0);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'History',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return Center(
                  child: Text('No data'),
                );
              },
              loading: () {
                return Center(child: CircularProgressIndicator());
              },
              success: (data) {
                if (data.isEmpty) {
                  return Center(
                    child: Text('No data'),
                  );
                }
                return ListView.separated(
                  separatorBuilder: (context, index) => SpaceHeight(12),
                  itemCount: data.length,
                  itemBuilder: (context, index) => HistoryTransactionCard(
                    padding: paddingHorizontal,
                    data: data[index],
                  ),
                );
              },
            );
          },
        ));
  }
}
