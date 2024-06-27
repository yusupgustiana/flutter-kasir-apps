import 'package:flutter/material.dart';

class DenominationList extends StatelessWidget {
  final void Function(String) onDenominationSelected;

  DenominationList({required this.onDenominationSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text('Rp. 10.000'),
              onTap: () {
                onDenominationSelected('Rp. 10.000'); // Tetapkan format "Rp."
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Rp. 20.000'),
              onTap: () {
                onDenominationSelected('Rp. 20.000');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Rp. 50.000'),
              onTap: () {
                onDenominationSelected('Rp. 50.000');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Rp. 100.000'),
              onTap: () {
                onDenominationSelected('Rp. 100.000');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Rp. 200.000'),
              onTap: () {
                onDenominationSelected('Rp. 200.000');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Rp. 500.000'),
              onTap: () {
                onDenominationSelected('Rp. 500.000');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
