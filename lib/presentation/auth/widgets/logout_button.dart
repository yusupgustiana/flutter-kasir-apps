// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:new_kasir_apps/presentation/auth/pages/login_page.dart';
// import 'package:new_kasir_apps/presentation/home/bloc/logout/logout_bloc.dart';
// // Ganti dengan import sesuai dengan struktur proyek Anda

// class LogoutButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LogoutBloc, LogoutState>(
//       builder: (context, state) {
//         return ElevatedButton(
//           onPressed: () {
//             // Mengirim event logout
//             context.read<LogoutBloc>().add(const LogoutEvent.logout());
            
//             // Navigasi ke halaman login setelah logout berhasil
//             Navigator.of(context).pushAndRemoveUntil(
//               MaterialPageRoute(builder: (context) => LoginPage()), // Ganti dengan halaman login Anda
//               (route) => false, // Menghapus semua route di atas halaman login dari stack
//             );
//           },
//           child: const Text('Logout'),
//         );
//       },
//     );
//   }
// }
