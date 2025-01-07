// import 'package:aloka_mobile_app/src/modules/payment/view/al_qr_read.dart';
// import 'package:flutter/material.dart';

// import '../../qr_code_screen/view/read_payment.dart';

// class PaymentTabBar extends StatefulWidget {
//   const PaymentTabBar({super.key});

//   @override
//   State<PaymentTabBar> createState() => _PaymentTabBarState();
// }

// class _PaymentTabBarState extends State<PaymentTabBar> {
//   @override
//   void initState() {
//     super.initState();
//     debugPrint("PaymentTabBar initialized.");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2, // Number of tabs
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Payment Screen"),
//           bottom: const TabBar(
//             tabs: [
//               Tab(text: "O/L Payment"),
//               Tab(text: "A/L Payment"),
//             ],
//           ),
//         ),
//         body: const TabBarView(
//           children: [
//             QRCodeReadPaymentScreen(
//               title: "ordinary-level",
//             ),
//             AlQrRead(
//               title: "advance-level",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
