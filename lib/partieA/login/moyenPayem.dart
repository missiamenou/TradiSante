// import 'package:flutter/material.dart';

// class MoyenPay extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: AppBar(
//           backgroundColor: Colors.green,
//           leading: const Padding(
//             padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: CircleAvatar(
//                 backgroundImage: AssetImage('image/tradisante.png'),
//                 backgroundColor: Colors.white,
//                 radius: 30,
//               ),
//             ),
//           ),
//           actions: [
//             Builder(
//               builder: (BuildContext context) {
//                 return IconButton(
//                   icon: const Icon(Icons.menu),
//                   onPressed: () {
//                     Scaffold.of(context).openDrawer();
//                   },
//                   tooltip:
//                       MaterialLocalizations.of(context).openAppDrawerTooltip,
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 // Logique pour le paiement par Orange Money
//                 // Vous pouvez ajouter ici le code nécessaire pour le paiement Orange Money
//               },
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
//                 padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//                   EdgeInsets.all(16.0),
//                 ),
//               ),
//               child: Text('Orange Money'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // Logique pour le paiement par MTN Mobile Money
//                 // Vous pouvez ajouter ici le code nécessaire pour le paiement MTN Mobile Money
//               },
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
//                 padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//                   EdgeInsets.all(16.0),
//                 ),
//               ),
//               child: Text('MTN Mobile Money'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // Logique pour le paiement par Wave
//                 // Vous pouvez ajouter ici le code nécessaire pour le paiement Wave
//               },
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//                 padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//                   EdgeInsets.all(16.0),
//                 ),
//               ),
//               child: Text('Wave'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // Logique pour le paiement par PayPal
//                 // Vous pouvez ajouter ici le code nécessaire pour le paiement PayPal
//               },
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//                 padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//                   EdgeInsets.all(16.0),
//                 ),
//               ),
//               child: Text('PayPal'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:client/partieA/login/classPayement.dart';
import 'package:flutter/material.dart';



class MoyenPay extends StatefulWidget {
  @override
  _MoyenPayState createState() => _MoyenPayState();
}

class _MoyenPayState extends State<MoyenPay> {
  String? selectedPaymentMethod;

  // Liste des moyens de paiement avec leurs images
  List<PaymentMethod> paymentMethods = [
    PaymentMethod(name: 'Wave', value: 'wave', imagePath: 'wave logo.png'),
    PaymentMethod(
        name: 'Orange Money',
        value: 'orange',
        imagePath: 'Orange-Money-logo.png'),
    PaymentMethod(
        name: 'Moov Money', value: 'moov', imagePath: 'Moov_Africa_logo.png'),
    PaymentMethod(
        name: 'MTN Mobile Money', value: 'mtn', imagePath: 'mtn_logo.jpg'),
    PaymentMethod(
        name: 'Payer à la livraison',
        value: 'livraison',
        imagePath: 'livraison1.png'),
    // Ajoutez d'autres moyens de paiement avec leurs images selon vos besoins
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.green,
          leading: const Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CircleAvatar(
                backgroundImage: AssetImage('image/tradisante.png'),
                backgroundColor: Colors.white,
                radius: 30,
              ),
            ),
          ),
          actions: [
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.grey.shade200, // Couleur de fond gris
            height: 50,
            child: const Center(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Paiement',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Expanded(
            child: ListView(
              shrinkWrap:
                  true, // Permet au ListView de prendre seulement l'espace nécessaire
              physics:
                  NeverScrollableScrollPhysics(), // Empêche le défilement du ListView
              children: paymentMethods
                  .map((paymentMethod) => buildPaymentMethodTile(paymentMethod))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  ListTile buildPaymentMethodTile(PaymentMethod paymentMethod) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Container(
        color: Colors.grey.shade200,
        child: Row(
          children: [
            // Logo ou icône du moyen de paiement
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal:
                    10, // Ajustez la valeur pour l'espacement horizontal
                vertical: 10, // Ajustez la valeur pour l'espacement vertical
              ),
              child: SizedBox(
                width: 40,
                height: 40,
                child: Image.asset(
                  'image/${paymentMethod.imagePath}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Espacement entre le logo et le texte
            Expanded(
              child: Text(
                paymentMethod.name,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Radio<String>(
              value: paymentMethod.value,
              groupValue: selectedPaymentMethod,
              onChanged: (String? newValue) {
                setState(() {
                  selectedPaymentMethod = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
