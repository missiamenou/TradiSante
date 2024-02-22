import 'package:client/partieA/login/item.dart';
import 'package:client/partieA/login/moyenPayem.dart';
import 'package:flutter/material.dart';

class productsCarousselPage extends StatelessWidget {
  final Item productsCaroussel;

  const productsCarousselPage({super.key, required this.productsCaroussel});

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
                    'Information du produit',
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

          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Image.network(
                  productsCaroussel.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
                const SizedBox(height: 16),
                Text(
                  'Nom du produit: ${productsCaroussel.nomProduit}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Prix: ${productsCaroussel.prix}'),
                const SizedBox(height: 8),
                Text('Catégorie: ${productsCaroussel.categorie}'),
                const SizedBox(height: 8),
                Text('Description: ${productsCaroussel.description}'),
              ],
            ),
          ),
          // Ajoutez d'autres détails selon vos besoins
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 250.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MoyenPay(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green.shade800),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                  ),
                ),
                child: const Text('Acheter'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
