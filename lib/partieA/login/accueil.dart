// // import 'dart:convert';
// import 'package:client/partieA/login/ApiService.dart';
// import 'package:client/partieA/login/ProductDetailsPage.dart';
// // import 'package:client/partieA/login/bottomNavgaBar.dart';
// // import 'package:client/partieA/login/switchPage.dart';
// // import 'package:http/http.dart' as http;

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:client/partieA/login/header.dart';
// import 'package:client/partieA/login/item.dart';
// import 'package:flutter/material.dart';

// class Accueil extends StatefulWidget {
//   const Accueil({Key? key}) : super(key: key);

//   @override
//   _AccueilState createState() => _AccueilState();
// }

// class _AccueilState extends State<Accueil> {
//   late List<String> imageUrls; // Déclaration de la variable 'imageUrls'
//   late List<Item> filteredProducts = [];
//   late List<Item> products = []; // Initialisez la liste des produits
//   late List<Item> productsCaroussel = []; // Initialisez la liste des produits
//   String selectedCategory = "";
//   // int currentIndex = 0;

//   void _changeColor(String category) {
//     setState(() {
//       selectedCategory = category;
//     });
//     // filterProducts(category); // Appliquer le filtre lorsque la catégorie change
//   }

//   void filterProducts(String category) {
//     category = category.trim().toLowerCase();
//     setState(() {
//       // selectedCategory = category;
//       if (category == "tout") {
//         filteredProducts = List.from(productsCaroussel);
//       } else {
//         filteredProducts = productsCaroussel
//             .where(
//                 (product) => product.categorie.trim().toLowerCase() == category)
//             .toList();
//       }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchData(); // Appelez la fonction fetchData au chargement de la page
//   }

//   void fetchData() async {
//     List<Item> products = await ApiService.fetchProducts();
//     List<Item> carousselProducts = await ApiService.fetchCarousselProducts();

//     setState(() {
//       this.products = products;
//       this.productsCaroussel = carousselProducts;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: CustomHeader(),
//         body: SingleChildScrollView(
//           // Votre code existant

//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                     top: 17, left: 20, right: 10, bottom: 0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: SizedBox(
//                         height: 40,
//                         child: TextField(
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: const Color(0xFFEDEDED),
//                             hintText: 'Recherche...',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide: BorderSide.none,
//                             ),
//                             suffixIcon: IconButton(
//                               onPressed: () {},
//                               icon: const Icon(Icons.search),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Stack(
//                 children: [
//                   Padding(
//                       padding: const EdgeInsets.only(
//                           left: 0, right: 0, top: 0, bottom: 0),
//                       child: CarouselSlider(
//                         options: CarouselOptions(
//                           height: 220,
//                           autoPlay: true,
//                           enlargeCenterPage: true,
//                           aspectRatio: 16 / 9,
//                           enableInfiniteScroll: true,
//                           viewportFraction:
//                               1.0, // Utilisez 1.0 pour occuper toute la largeur
//                         ),
//                         items: productsCaroussel.map((product) {
//                           return Image.network(
//                             product
//                                 .image, // Assurez-vous d'avoir la clé d'image correcte selon la structure de vos données
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                           );
//                         }).toList(),
//                       )),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 150),
//                     child: Container(
//                       width: double.infinity,
//                       height: 70,
//                       color: Colors.black.withOpacity(0.5),
//                       child: Center(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Transform.rotate(
//                               angle: -20 * (3.1415926535897932 / 180),
//                               child: const Icon(
//                                 Icons.attach_money,
//                                 color: Colors.white,
//                                 size: 60,
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 350,
//                               child: Text(
//                                 'Souscrivez à un abonnement pour bénéficier de plus de réductions sur vos achats',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 15),

//               // Texte "Les plus recommandés" aligné à gauche
//               const Padding(
//                 padding: EdgeInsets.only(
//                   left: 16.0,
//                 ),
//                 child: Text(
//                   'Les plus recommandés',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: List.generate(5, (index) {
//                     if (index < products.length) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 5),
//                         child: Stack(
//                           children: [
//                             SizedBox(
//                               width: 150,
//                               height: 150,
//                               child: Image.network(
//                                 products[index].image,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             Positioned(
//                               bottom: -4,
//                               left: 0,
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   // Mettez ici votre logique lorsque le bouton est cliqué
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Color(0xFF734234),
//                                   minimumSize: const Size(150,
//                                       40), // Ajustez la largeur et la hauteur en conséquence
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal:
//                                           20), // Ajustez l'espacement horizontal
//                                 ),
//                                 child: Text(
//                                   products[index].nomProduit,
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     } else {
//                       return const SizedBox(
//                           width: 10); // Ou un widget de remplacement
//                     }
//                   }),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               // Texte "Les plus recommandés" aligné à gauche
//               const Padding(
//                 padding: EdgeInsets.only(left: 16.0, top: 0, bottom: 8.0),
//                 child: Text(
//                   'Catégories de maladie',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 5),

//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//                     const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
//                     TextButton(
//                       onPressed: () {
//                         filterProducts("Tout");
//                         _changeColor("Tout");
//                       },
//                       style: TextButton.styleFrom(
//                         backgroundColor: selectedCategory == "Tout"
//                             ? Colors.green
//                             : const Color(0xFFD9D9D9),
//                         padding: EdgeInsets.zero,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: SizedBox(
//                         height: 50,
//                         width: 150,
//                         child: Center(
//                           child: Text(
//                             "Tout",
//                             style: TextStyle(
//                               color: selectedCategory == "Tout"
//                                   ? Colors.white
//                                   : Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         filterProducts("  Maladies cardiovasculaires ");
//                         _changeColor("cardiovasculaires");
//                       },
//                       style: TextButton.styleFrom(
//                         backgroundColor: selectedCategory == "cardiovasculaires"
//                             ? Colors.green
//                             : const Color(0xFFD9D9D9),
//                         padding: EdgeInsets.zero,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: SizedBox(
//                         height: 50,
//                         width: 150,
//                         child: Center(
//                           child: Text(
//                             "cardiovasculaires",
//                             style: TextStyle(
//                               color: selectedCategory == "cardiovasculaires"
//                                   ? Colors.white
//                                   : Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         filterProducts("Maladies infectieuses");
//                         _changeColor("infectieuses");
//                       },
//                       style: TextButton.styleFrom(
//                         backgroundColor: selectedCategory == "infectieuses"
//                             ? Colors.green
//                             : const Color(0xFFD9D9D9),
//                         padding: EdgeInsets.zero,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: SizedBox(
//                         height: 50,
//                         width: 150,
//                         child: Center(
//                           child: Text(
//                             "infectieuses",
//                             style: TextStyle(
//                               color: selectedCategory == "infectieuses"
//                                   ? Colors.white
//                                   : Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         filterProducts("Maladies respiratoires");
//                         _changeColor("respiratoires");
//                       },
//                       style: TextButton.styleFrom(
//                         backgroundColor: selectedCategory == "respiratoires"
//                             ? Colors.green
//                             : const Color(0xFFD9D9D9),
//                         padding: EdgeInsets.zero,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: SizedBox(
//                         height: 50,
//                         width: 150,
//                         child: Center(
//                           child: Text(
//                             "respiratoires",
//                             style: TextStyle(
//                               color: selectedCategory == "respiratoires"
//                                   ? Colors.white
//                                   : Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         filterProducts("Maladies mentales");
//                         _changeColor("mentales");
//                       },
//                       style: TextButton.styleFrom(
//                         backgroundColor: selectedCategory == "mentales"
//                             ? Colors.green
//                             : const Color(0xFFD9D9D9),
//                         padding: EdgeInsets.zero,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: SizedBox(
//                         height: 50,
//                         width: 150,
//                         child: Center(
//                           child: Text(
//                             "mentales",
//                             style: TextStyle(
//                               color: selectedCategory == "mentales"
//                                   ? Colors.white
//                                   : Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         filterProducts("Maladies endocriniennes");
//                         _changeColor("endocriniennes");
//                       },
//                       style: TextButton.styleFrom(
//                         backgroundColor: selectedCategory == "endocriniennes"
//                             ? Colors.green
//                             : const Color(0xFFD9D9D9),
//                         padding: EdgeInsets.zero,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: SizedBox(
//                         height: 50,
//                         width: 150,
//                         child: Center(
//                           child: Text(
//                             "endocriniennes",
//                             style: TextStyle(
//                               color: selectedCategory == "endocriniennes"
//                                   ? Colors.white
//                                   : Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 15),

//               SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: List.generate((filteredProducts.length / 2).ceil(),
//                       (rowIndex) {
//                     int startIndex = rowIndex * 2;
//                     int endIndex = (rowIndex + 1) * 2;
//                     if (endIndex > filteredProducts.length) {
//                       endIndex = filteredProducts.length;
//                     }
//                     double containerWidth =
//                         MediaQuery.of(context).size.width / 2;
//                     return SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Column(
//                         children: [
//                           Row(
//                             children:
//                                 List.generate(endIndex - startIndex, (index) {
//                               int productIndex = startIndex + index;
//                               // String category =
//                               //     filteredProducts[productIndex].categorie;

//                               return Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 5),
//                                 child: Container(
//                                   width: 195,
//                                   height: 150,
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                       color:
//                                           Colors.white, // Couleur de la bordure
//                                       width: 2.0, // Largeur de la bordure
//                                     ),
//                                     borderRadius: BorderRadius.circular(
//                                         8.0), // Rayon des bords de la boîte
//                                   ),
//                                   child: Stack(
//                                     children: [
//                                       GestureDetector(
//                                         onTap: () {
//                                           // Ajoutez ici le code à exécuter lorsque l'image est cliquée
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   productsCarousselPage(
//                                                 productsCaroussel:
//                                                     filteredProducts[
//                                                         productIndex],
//                                               ),
//                                             ),
//                                           );
//                                           // _changeColor(category);
//                                         },
//                                         child: Image.network(
//                                           filteredProducts[productIndex].image,
//                                           fit: BoxFit.cover,
//                                           width: containerWidth,
//                                           height: 150,
//                                         ),
//                                       ),
//                                       Positioned(
//                                         bottom: 8,
//                                         left: 0,
//                                         child: ElevatedButton(
//                                           onPressed: () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     productsCarousselPage(
//                                                   productsCaroussel:
//                                                       filteredProducts[
//                                                           productIndex],
//                                                 ),
//                                               ),
//                                             );
//                                             // _changeColor(category);
//                                           },
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor: Color(0xFF734234),
//                                             minimumSize: Size(200, 0),
//                                           ),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 filteredProducts[productIndex]
//                                                     .nomProduit,
//                                                 style: const TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                               Text(
//                                                 'Prix: ${filteredProducts[productIndex].prix}',
//                                                 style: const TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 14,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             }),
//                           ),
//                           const SizedBox(height: 50), // Espace entre les lignes
//                         ],
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ],
//           ),
        
//         ),
        
//         // bottomNavigationBar: BottomNavigationBar(
//         // //   onDestinationSelected: (int index) {
//         // //   setState(() {
//         // //     currentIndex = index;
//         // //   });
//         // // },
//         // // indicatorColor: Color(0xFF117C0F),
//         // // selectedIndex: currentIndex,
//         // // destinations: const <Widget>[
//         // //   NavigationDestination(
//         // //      selectedIcon: Icon(Icons.home),
//         // //     icon: Icon(Icons.home_outlined),
//         // //   label: "Home",
//         // //  ),
//         // //   NavigationDestination(
//         // //     icon: Icon(Icons.person_2_outlined),
//         // //   label: 'Devenir vendeur',
//         // //  )
//         // // ],
          
//         //   currentIndex: currentIndex,
//         //   // onTap: onTap,
//         //   selectedItemColor: const Color(0xFF117C0F),
//         //   unselectedItemColor: const Color.fromARGB(255, 27, 27, 27),
//         //   iconSize: 32,
//         //   elevation: 10,
//         //   items: const <BottomNavigationBarItem>[
//         //     BottomNavigationBarItem(
//         //       icon: Icon(
//         //         Icons.home,
//         //       ),
//         //       label: 'Accueil',
//         //       backgroundColor: Color(0xFFD9D9D9),
//         //     ),
//         //     const BottomNavigationBarItem(
//         //       icon: Icon(Icons.person_2_outlined),
//         //       label: 'Devenir vendeur',
//         //     ),
//         //   ],
//         // ),
//       ),
//     );
//   }
// }
