
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:client/partieA/login/item.dart';

var data;

class ApiService {
  static Future<List<Item>> fetchProducts() async {
    var url = Uri.parse('http://s-p5.com/komi/tradi_sante/plusRom.php');
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        data = json.decode(response.body);
        return data.map((e) {
          return Item(
            nomProduit: e["nomProduit"],
            maladie: e["maladie"],
            prix: e["prix"],
            categorie: e["categorie"],
            description: e["description"],
            dateCreation: DateTime.parse(e["date_creation"]),
            image: "http://s-p5.com/komi/tradi_sante/${e['image']}",
          );
        }).toList();
      } else if (response.statusCode == 401) {
        // Mot de passe incorrect
        print('Mot de passe incorrect');
        return [];
      } else if (response.statusCode == 404) {
        // Utilisateur inexistant
        print('Utilisateur inexistant');
        return [];
      } else {
        // Autres erreurs
        print(
            'Erreur lors de la requête au serveur. Code d\'état : ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Une erreur s\'est produite : $e');
      return [];
    }
  }

  static Future<List<Item>> fetchCarousselProducts() async {
    var url = Uri.parse('http://s-p5.com/komi/tradi_sante/caroussel.php');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((e) {
          return Item(
            nomProduit: e["nomProduit"],
            maladie: e["maladie"],
            prix: e["prix"],
            categorie: e["categorie"],
            description: e["description"],
            dateCreation: DateTime.parse(e["date_creation"]),
            image: "http://s-p5.com/komi/tradi_sante/${e['image']}",
          );
        }).toList();
      } else {
        print(
            'Erreur lors de la requête au serveur. Code d\'état : ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Une erreur s\'est produite : $e');
      return [];
    }
  }
}
