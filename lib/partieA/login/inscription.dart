// import 'dart:ffi';
import 'dart:io';

import 'package:client/main.dart';
import 'package:client/partieA/login/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class Inscription extends StatefulWidget {
  const Inscription({Key? key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  var formKey = GlobalKey<FormState>();

  var nomController = TextEditingController();
  var emailController = TextEditingController();
  var contactController = TextEditingController();
  var _codePromoController = TextEditingController();
  var motdepasseController = TextEditingController();
  var nomBoutiqueController = TextEditingController();
  var localisationController = TextEditingController();
  var _obscureText = true;
  String? base64Image; // Déclarez la variable base64Image ici
  File? _imageFile; // Variable pour stocker l'image sélectionnée

  String message = ''; // Message de succès ou d'erreur


  void _convertImageToBase64(File image) {
    List<int> imageBytes = image.readAsBytesSync();
    base64Image = base64Encode(imageBytes);
  }

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _convertImageToBase64(_imageFile!);
      });
    }
  }

  @override
  void dispose() {
    nomController.dispose();
    emailController.dispose();
    contactController.dispose();
    motdepasseController.dispose();
    // codePromoController.dispose();
    nomBoutiqueController.dispose();
    localisationController.dispose();

    super.dispose();
  }

  bool montrePopUp = false; // Variable d'état pour afficher la pop-up

  void validerInscription() {
    // Logique pour valider l'inscription avec succès
    setState(() {
      montrePopUp = true; // Afficher la pop-up si l'inscription est réussie
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'image/tradisante.png',
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 5,
              ),
              const SizedBox(
                width: 150,
              ),
              const Text(
                'Inscription',
                style: TextStyle(
                  color: Color(0xFF117C0F),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 8),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 16.0),
                  InkWell(
                    onTap: () {
                      _takePhoto(); // Appel de la méthode pour prendre une photo avec la caméra
                    },
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      size: 55.0,
                      color: Color.fromARGB(176, 0, 151, 5),
                    ),
                  ),
                  const Text('Veuillez sélectionner la photo de votre local'),
                  SizedBox(height: 20),
                ],
              ),
              if (_imageFile != null)
                Container(
                  width: MediaQuery.of(context).size.width *
                      0.8, // Utilisez 80% de la largeur de l'écran
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        10), // Ajustez le rayon du bord selon vos préférences
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      _imageFile!,
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                  ),
                ),
              const SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 0,
                          color: Colors.black26,
                          offset: Offset(0, -3))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 8),
                  child: Column(
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: nomBoutiqueController,
                              validator: (value) => value!.isEmpty
                                  ? "Veuillez saisir le nom de la boutique"
                                  : null,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.store,
                                  color: Colors.black,
                                ),
                                hintText: "Nom de la boutique...",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(color: Colors.white60),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(color: Colors.white60),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(color: Colors.white60),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 6),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            TextFormField(
                              controller: nomController,
                              validator: (value) => value!.isEmpty
                                  ? "Veuillez saisir votre nom"
                                  : null,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                hintText: "Nom & Prenoms...",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(color: Colors.white60),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(color: Colors.white60),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(color: Colors.white60),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 6),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                            const SizedBox(height: 18),
                            TextFormField(
                              controller: emailController,
                              validator: (value) => value!.isEmpty
                                  ? "Veuillez saisir votre E-mail"
                                  : null,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                                hintText: "E-mail...",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(color: Colors.white60),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(color: Colors.white60),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(color: Colors.white60),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 6),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                            const SizedBox(height: 18),
                            TextFormField(
                              controller: localisationController,
                              validator: (value) => value!.isEmpty
                                  ? "Veuillez saisir la localisation de la boutique"
                                  : null,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                ),
                                hintText: "Localisation de la boutique...",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(color: Colors.white60),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(color: Colors.white60),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(color: Colors.white60),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 6),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                            const SizedBox(height: 18),
                            TextFormField(
                              controller: contactController,
                              validator: (value) => value!.isEmpty
                                  ? "Veuillez saisir votre contact"
                                  : null,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(
                                    10), // Limite la longueur à 10 chiffres (ou selon la longueur souhaitée)
                              ],
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.black,
                                ),
                                hintText: "Contact...",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(color: Colors.white60),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(color: Colors.white60),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(color: Colors.white60),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 6),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                            const SizedBox(height: 18),
                            TextFormField(
                              obscureText: _obscureText,
                              controller: motdepasseController,
                              validator: (value) => value!.isEmpty
                                  ? "Veuillez saisir votre mot de passe"
                                  : null,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.vpn_key_sharp,
                                  color: Colors.black,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                                hintText: "Mot de passe...",
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(color: Colors.white60),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(color: Colors.white60),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(color: Colors.white60),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 6),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                            const SizedBox(height: 18),
                            TextFormField(
                              controller: _codePromoController,
                              validator: (value) => value!.isEmpty
                                  ? "Veuillez saisir le code de validation"
                                  : null,
                              
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.security,
                                  color: Colors.black,
                                ),
                                hintText: "Code Promo...",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(color: Colors.white60),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(color: Colors.white60),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(color: Colors.white60),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 6),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                            const SizedBox(height: 18),
                            
                           Material(
  color: couleurPrimaire,
  borderRadius: BorderRadius.circular(30),
  child: InkWell(
    onTap: () {
      // Vérifie la validité du formulaire
      if (formKey.currentState!.validate()) {
        // Vérifie si l'image a été ajoutée
        if (base64Image == null) {
          // Affiche un message d'erreur si aucune photo n'a été ajoutée
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Veuillez ajouter une photo'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          // Appelle la fonction de vérification du code promo
          _completeRegistration();
        }
      } else {
        // Affiche un message d'erreur si l'envoi au serveur échoue
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Échec de l\'envoi des données au serveur'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    },
    borderRadius: BorderRadius.circular(30),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        "S'inscrire",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
),
const SizedBox(height: 20),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // afficherPopup(context);
      // Affiche la pop-up si montrePopUp est vrai
    );
  }

void _completeRegistration() {
  // Appelle la fonction de vérification du code promo
  _checkPromoCode();
}

void _checkPromoCode() async {
  final response = await http.post(
    Uri.parse('http://s-p5.com/komi/tradi_sante/verification_code_promo.php'),  // Mettez à jour le chemin du script PHP
    body: {
      'codePromo': _codePromoController.text,
    },
  );

  if (response.statusCode == 200) {
    _registerUser();
  } else if (response.statusCode == 404) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Code promo invalide. Veuillez saisir un code promo valide.'),
        duration: Duration(seconds: 2),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Erreur inattendue. Veuillez réessayer.'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}


void _registerUser() async {
  final response = await http.post(
    Uri.parse('http://s-p5.com/komi/tradi_sante/inscription.php'),  // Mettez à jour le chemin du script PHP
    body: {
      'nom': nomController.text,
      'email': emailController.text,
      'contact': contactController.text,
      'codePromo': _codePromoController.text,
      'motdepasse': motdepasseController.text,
      'nomBoutique': nomBoutiqueController.text,
      'localisation': localisationController.text,
      'photo': base64Image,
    },
  );

  if (response.statusCode == 200) {
    afficherPopup(context);
    
    setState(() {
      message = 'Enregistrement réussi';
      nomController.clear();
      emailController.clear();
      contactController.clear();
      nomBoutiqueController.clear();
      motdepasseController.clear();
      localisationController.clear();
      _codePromoController.clear();
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        message = '';
      });
    });
  } else if (response.statusCode == 400) {
    setState(() {
      message = 'Erreur d\'enregistrement: ${response.body}';
    });
  }
}


}
