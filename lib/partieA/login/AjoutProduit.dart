import 'dart:convert';
// import 'package:client/partieA/login/bottomNavgaBar.dart';
// import 'package:client/partieA/login/switchPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProduit extends StatefulWidget {
  const EditProduit({Key? key}) : super(key: key);
  @override
  _EditProduitState createState() => _EditProduitState();
}

class _EditProduitState extends State<EditProduit> {
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productPriceController = TextEditingController();
  TextEditingController _productDescriptionController = TextEditingController();
  TextEditingController _diseaseNameController = TextEditingController();
  String? base64Image; // Déclarez la variable base64Image ici

  // Méthode pour convertir l'image en une chaîne base64
  void _convertImageToBase64(File image) {
    List<int> imageBytes = image.readAsBytesSync();
    base64Image = base64Encode(imageBytes);
  }

  String? selectedOption;
  List<String> options = [
    'Maladies infectieuses',
    'Maladies cardiovasculaires ',
    'Maladies respiratoires',
    'Maladies mentales',
    'Maladies endocriniennes'
  ];

  File? _imageFile; // Variable pour stocker l'image sélectionnée

  bool _isButtonDisabled = true;

  // Méthode pour prendre une photo à partir de la caméra
  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _convertImageToBase64(
            _imageFile!); // Convertir l'image en chaîne base64
      });
    }
  }

  // Méthode pour sélectionner une image depuis la galerie
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Dialog(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.thumb_up,
                  color: Colors.green,
                  size: 64,
                ),
                SizedBox(height: 16),
                Text(
                  'Informations envoyées avec succès!',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _checkFields() {
    if (_productNameController.text.isNotEmpty &&
        _productPriceController.text.isNotEmpty &&
        _productDescriptionController.text.isNotEmpty &&
        _diseaseNameController.text.isNotEmpty &&
        selectedOption != null) {
      setState(() {
        _isButtonDisabled = false;
      });
    } else {
      setState(() {
        _isButtonDisabled = true;
      });
    }
  }

  Future<void> _ajouterProduit() async {
    try {
      if (_productNameController.text.isNotEmpty &&
          _diseaseNameController.text.isNotEmpty &&
          _productPriceController.text.isNotEmpty &&
          _productDescriptionController.text.isNotEmpty &&
          selectedOption != null &&
          _imageFile != null) {
        // Récupérer les données à partir des champs de texte
        String nomProduit = _productNameController.text;
        String maladie = _diseaseNameController.text;
        double prix = double.parse(_productPriceController.text);
        String categorie = selectedOption!;
        String description = _productDescriptionController.text;

        // Convertir l'image en une chaîne base64
        String base64Image = base64Encode(_imageFile!.readAsBytesSync());

        // Préparer les données à envoyer au serveur
        var url = Uri.parse('http://s-p5.com/komi/tradi_sante/get_images.php');
        var response = await http.post(url, body: {
          'nomProduit': nomProduit,
          'maladie': maladie,
          'prix': prix.toString(),
          'categorie': categorie,
          'description': description,
          'image': base64Image,
        });

        // Gérer la réponse du serveur
        if (response.statusCode == 200) {
          print('Données envoyées avec succès');
          _showSuccessDialog(context); // Afficher un dialogue de succès
        } else {
          print(
              'Échec de l\'envoi des données. Code d\'état : ${response.statusCode}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Échec de l\'envoi des données au serveur'),
              duration: Duration(seconds: 2),
            ),
          ); // Afficher une barre de snack pour signaler l'échec
        }

        _productNameController.clear();
        _diseaseNameController.clear();
        _productPriceController.clear();
        _productDescriptionController.clear();
        setState(() {
          selectedOption = null;
          _imageFile = null;
          _isButtonDisabled = true;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Veuillez remplir tous les champs et ajouter une image'),
            duration: Duration(seconds: 2),
          ),
        ); // Afficher une barre de snack pour signaler les champs manquants
      }
    } catch (e) {
      print('Erreur lors de l\'ajout du produit : $e');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Une erreur s\'est produite lors de l\'ajout du produit'),
          duration: Duration(seconds: 2),
        ),
      ); // Afficher une barre de snack pour signaler une erreur
    }
  }

  // int _currentIndex = 1;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            const Text(
              "AJOUTER UN PRODUIT",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              height: 1,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              children: [
                const SizedBox(width: 16.0),
                InkWell(
                  onTap: () {
                    _takePhoto(); // Appel de la méthode pour prendre une photo avec la caméra
                  },
                  child: const Icon(
                    Icons.camera_alt,
                    size: 55.0,
                    color: Color.fromARGB(176, 0, 151, 5),
                  ),
                ),
                const SizedBox(width: 10.0),
                InkWell(
                  onTap: () {
                    _pickImage(); // Appel de la méthode pour sélectionner une image depuis la galerie
                  },
                  child: const Text(
                    'Ajouter une image',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.brown,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            if (_imageFile != null) // Affichage de l'image sélectionnée
              Image.file(
                _imageFile!,
                width: 100,
                height: 100,
              ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12.0),
                  TextField(
                    controller: _productNameController,
                    onChanged: (_) =>
                        _checkFields(), // Vérifier les champs à chaque changement de texte
                    decoration: InputDecoration(
                      labelText: 'Nom de l’article*',
                      hintText: 'Entrez le nom',
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _diseaseNameController,
                    onChanged: (_) =>
                        _checkFields(), // Vérifier les champs à chaque changement de texte
                    decoration: InputDecoration(
                      labelText: 'Nom de la maladie',
                      hintText: 'Entrez le nom de la maladie',
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _productPriceController,
                    onChanged: (_) =>
                        _checkFields(), // Vérifier les champs à chaque changement de texte
                    decoration: InputDecoration(
                      labelText: 'Prix*',
                      hintText: 'Saisir le prix',
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: selectedOption,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedOption = newValue;
                        _checkFields(); // Vérifier les champs lorsque l'option est modifiée
                      });
                    },
                    items: options.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Catégorie*',
                      hintText: 'Choisir la catégorie',
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _productDescriptionController,
                    onChanged: (_) =>
                        _checkFields(), // Vérifier les champs à chaque changement de texte
                    decoration: InputDecoration(
                      labelText: 'Description*',
                      hintText: 'Entrez la description',
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton.icon(
                    onPressed: _isButtonDisabled ? null : _ajouterProduit,
                    icon: const Icon(Icons.add),
                    label: const Text('AJOUTER'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        _isButtonDisabled
                            ? Colors.grey
                            : const Color.fromARGB(176, 0, 151, 5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30)
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: CustomBottomNavigationBar(
      //     currentIndex: _currentIndex,
      //     onTap: (index) {
      //       BottomNavigationHelper.onTabTapped(context, index);
      //       setState(() {
      //         _currentIndex = index;
      //       });
      //     },
      //   ),
    );
  }
}
