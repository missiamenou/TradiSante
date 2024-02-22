// item.dart
class Item {
  final String nomProduit;
  final String maladie;
  final String prix;
  final String categorie;
  final String description;
  final String image;
  
  final DateTime dateCreation;

  Item({
    required this.nomProduit,
    required this.maladie,
    required this.prix,
    required this.categorie,
    required this.description,
    required this.image,
    required this.dateCreation,
  });
}
