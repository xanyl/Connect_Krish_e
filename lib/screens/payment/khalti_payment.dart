import 'package:e_commerce_app_flutter/services/database/user_database_helper.dart';
import 'package:flutter/material.dart';

class KhaltiPaymentScreen extends StatefulWidget {
  @override
  _KhaltiPaymentScreenState createState() => _KhaltiPaymentScreenState();
}

class _KhaltiPaymentScreenState extends State<KhaltiPaymentScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Khalti Payment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<num>(
              future: UserDatabaseHelper().cartTotal,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final cartTotal = snapshot.data;
                  return Text(
                    "Total Amount: NPR $cartTotal",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),

            SizedBox(height: 20),
            // Add your Khalti payment UI components here
            ElevatedButton(
              
              onPressed: () {
                // Simulate the Khalti payment process
                _simulateKhaltiPayment();
              },
              child: Text("Proceed to Khalti Payment"),
            ),
          ],
        ),
      ),
    );
  }

  // Simulate the Khalti payment process
  void _simulateKhaltiPayment() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Khalti Payment"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder<num>(
                future: UserDatabaseHelper().cartTotal,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final cartTotal = snapshot.data;
                    return Text("Total Amount: NPR $cartTotal");
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Simulate a successful payment
                  Navigator.pop(context); // Close the dialog
                  _showPaymentSuccessDialog();
                },
                child: Text("Complete Payment"),
              ),
              ElevatedButton(
                onPressed: () {
                  // Simulate a failed payment
                  Navigator.pop(context); // Close the dialog
                  _showPaymentFailureDialog();
                },
                child: Text("Cancel Payment"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPaymentSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Payment Successful"),
          content: Text("Your payment was successful."),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Close the payment screen
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showPaymentFailureDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Payment Failed"),
          content: Text("Your payment was not successful."),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: KhaltiPaymentScreen(),
  ));
}



// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';
// import 'package:khalti_flutter/khalti_flutter.dart';

// const String testPublicKey = 'test_secret_key_e5590196bdb34e12b9ce60e9773122ea';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const KhaltiPaymentGate());
// }

// class KhaltiPaymentGate extends StatelessWidget {
//   const KhaltiPaymentGate({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return KhaltiScope(
//       publicKey: testPublicKey,
//       enabledDebugging: true,
//       builder: (context, navKey) {
//         return ChangeNotifierProvider<AppPreferenceNotifier>(
//           create: (_) => AppPreferenceNotifier(),
//           builder: (context, _) {
//             return Consumer<AppPreferenceNotifier>(
//               builder: (context, appPreference, _) {
//                 return MaterialApp(
//                   title: 'Khalti Payment Gateway',
//                   supportedLocales: const [
//                     Locale('en', 'US'),
//                     Locale('ne', 'NP'),
//                   ],
//                   locale: appPreference.locale,
//                   theme: ThemeData(
//                     brightness: appPreference.brightness,
//                     primarySwatch: Colors.deepPurple,
//                     pageTransitionsTheme: const PageTransitionsTheme(
//                       builders: {
//                         TargetPlatform.android: ZoomPageTransitionsBuilder(),
//                       },
//                     ),
//                   ),
//                   debugShowCheckedModeBanner: false,
//                   navigatorKey: navKey,
//                   localizationsDelegates: const [
//                     KhaltiLocalizations.delegate,
//                     AppLocalizations.delegate,
//                     GlobalMaterialLocalizations.delegate,
//                     GlobalCupertinoLocalizations.delegate,
//                     GlobalWidgetsLocalizations.delegate,
//                   ],
//                   routes: {
//                     '/': (_) => const HomePage(key: Key('home')),
//                   },
//                   onGenerateInitialRoutes: (route) {
//                     // Only used for handling response from KPG in Flutter Web.
//                     if (route.startsWith('/kpg/')) {
//                       final uri = Uri.parse('https://khalti.com$route');
//                       return [
//                         MaterialPageRoute(
//                           builder: (context) => HomePage(
//                             key: const Key('kpg-home'),
//                             params: uri.queryParameters,
//                           ),
//                         ),
//                       ];
//                     }
//                     return Navigator.defaultGenerateInitialRoutes(
//                       navKey.currentState,
//                       route,
//                     );
//                   },
//                 );
//               },
//             );
//           },
//         );
//       },
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({Key key, this.params}) : super(key: key);

//   final Map<String, String> params;

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   void initState() {
//     super.initState();
//     if (widget.params != null) {
//       SchedulerBinding.instance?.addPostFrameCallback((_) {
//         onSuccess(PaymentSuccessModel.fromMap(widget.params));
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final config = PaymentConfig(
//       amount: 10,
//       productIdentity: 'Fruit',
//       productName:
//       'Oranges',
//       productUrl:
//       'https://firebase.com/oranges/34vv43v',
//       additionalData: {
//         'vendor': 'connectkrishi',
//         'image_url':
//         'https://firebasestorage.googleapis.com/v0/b/new-connect-krishi.appspot.com/o/products%2Fimages%2FazNKsM83qliHGWr2drSq_0?alt=media&token=6eba9f53-a335-4c63-86c7-02ea9205a749',
//       },
//     );
//     final localization = AppLocalizations.of(context)!;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(localization.kpg),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Card(
//               child: Consumer<AppPreferenceNotifier>(
//                 builder: (context, appPreference, _) {
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 16, left: 16),
//                         child: Text(
//                           localization.appPreference.toUpperCase(),
//                           style: Theme.of(context).textTheme.overline,
//                         ),
//                       ),
//                       SwitchListTile(
//                         value: appPreference.isDarkMode,
//                         title: Text(localization.darkMode),
//                         onChanged: (isDarkMode) {
//                           context
//                               .read<AppPreferenceNotifier>()
//                               .updateBrightness(isDarkMode: isDarkMode);
//                         },
//                       ),
//                       ListTile(
//                         title: Text(localization.language),
//                         trailing: DropdownButtonHideUnderline(
//                           child: DropdownButton<Locale>(
//                             items: {
//                               'English': const Locale('en', 'US'),
//                               'नेपाली': const Locale('ne', 'NP'),
//                             }
//                                 .entries
//                                 .map(
//                                   (e) => DropdownMenuItem(
//                                 child: Text(e.key),
//                                 value: e.value,
//                               ),
//                             )
//                                 .toList(growable: false),
//                             value: appPreference.locale,
//                             onChanged: (locale) {
//                               if (locale != null) {
//                                 appPreference.updateLocale(locale);
//                               }
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Flexible(
//                   child: Column(
//                     children: [
//                       KhaltiButton(
//                         config: config,
//                         onSuccess: onSuccess,
//                         onFailure: onFailure,
//                         onCancel: onCancel,
//                       ),
//                       const SizedBox(height: 8),
//                       KhaltiButton.eBanking(
//                         config: config,
//                         onSuccess: onSuccess,
//                         onFailure: onFailure,
//                         onCancel: onCancel,
//                       ),
//                       const SizedBox(height: 8),
//                       KhaltiButton.mBanking(
//                         config: config,
//                         onSuccess: onSuccess,
//                         onFailure: onFailure,
//                         onCancel: onCancel,
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Flexible(
//                   child: Column(
//                     children: [
//                       KhaltiButton.wallet(
//                         config: config,
//                         onSuccess: onSuccess,
//                         onFailure: onFailure,
//                         onCancel: onCancel,
//                       ),
//                       const SizedBox(height: 8),
//                       KhaltiButton.sct(
//                         config: config,
//                         onSuccess: onSuccess,
//                         onFailure: onFailure,
//                         onCancel: onCancel,
//                       ),
//                       const SizedBox(height: 8),
//                       KhaltiButton.connectIPS(
//                         config: config,
//                         onSuccess: onSuccess,
//                         onFailure: onFailure,
//                         onCancel: onCancel,
//                       ),
//                     ],
//                   ),
//                 ),
//                 if (MediaQuery.of(context).size.width > 500)
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 16),
//                       child: _CustomButton(
//                         config: config,
//                         onSuccess: onSuccess,
//                         onFailure: onFailure,
//                         onCancel: onCancel,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             if (MediaQuery.of(context).size.width < 500)
//               Padding(
//                 padding: const EdgeInsets.only(top: 24),
//                 child: _CustomButton(
//                   config: config,
//                   onSuccess: onSuccess,
//                   onFailure: onFailure,
//                   onCancel: onCancel,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   void onSuccess(PaymentSuccessModel success) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Payment Successful'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Image.network(
//                 success.additionalData?['image_url']?.toString() ?? '',
//                 height: 100,
//               ),
//               Text.rich(
//                 TextSpan(
//                   text: 'Payment for ',
//                   children: [
//                     TextSpan(
//                       text: success.productName,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w300,
//                         fontStyle: FontStyle.italic,
//                       ),
//                     ),
//                     const TextSpan(text: ' of '),
//                     TextSpan(
//                       text: 'Rs. ${success.amount ~/ 100} ',
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     const TextSpan(text: ' was successfully made.'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void onFailure(PaymentFailureModel failure) {
//     log(failure.toString(), name: 'Failure');
//   }

//   void onCancel() {
//     log('Cancelled');
//   }
// }

// class _CustomButton extends StatelessWidget {
//   const _CustomButton({
//     Key key,
//     this.config,
//     this.onSuccess,
//     this.onFailure,
//      this.onCancel,
//   }) : super(key: key);

//   final PaymentConfig config;
//   final ValueChanged<PaymentSuccessModel> onSuccess;
//   final ValueChanged<PaymentFailureModel> onFailure;
//   final VoidCallback? onCancel;

//   @override
//   Widget build(BuildContext context) {
//     final headline6 = Theme.of(context).textTheme.headline6?.copyWith(
//       color: Colors.pink,
//       fontWeight: FontWeight.bold,
//     );

//     return InkWell(
//       borderRadius: BorderRadius.circular(20),
//       splashColor: Colors.orange.withOpacity(0.3),
//       highlightColor: Colors.orange.withOpacity(0.2),
//       hoverColor: Colors.orange.withOpacity(0.1),
//       onTap: () {
//         KhaltiScope.of(context).pay(
//           config: config,
//           preferences: [
//             PaymentPreference.khalti,
//             PaymentPreference.eBanking,
//           ],
//           onSuccess: onSuccess,
//           onFailure: onFailure,
//           onCancel: onCancel,
//         );
//       },
//       child: Material(
//         color: Colors.transparent,
//         shape: RoundedRectangleBorder(
//           side: const BorderSide(color: Colors.orange, width: 2.5),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 8,
//             vertical: 16,
//           ),
//           child: Center(
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SvgPicture.asset(
//                   'assets/logo/khalti.svg',
//                   package: 'khalti_flutter',
//                   width: 200,
//                 ),
//                 const SizedBox(width: 8),
//                 Text('PAY', style: headline6),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }