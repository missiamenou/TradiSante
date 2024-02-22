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
const SizedBox(
                              height: 20,
                            )
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
      // Affiche la pop-up si montrePopUp est vrai
    );
  }
// ...

void _completeRegistration() {
  // Appelle la fonction de vérification du code promo
  _checkPromoCode();
}

void _checkPromoCode() async {
  // Envoie une requête HTTP pour vérifier le code promo
  final response = await http.post(
    Uri.parse('http://s-p5.com/komi/tradi_sante/inscription.php'),
    body: {
      'verification_code_promo': 'true',
      'codePromo': _codePromoController.text,
    },
  );

  // Si la réponse du serveur est 200, le code promo est valide
  if (response.statusCode == 200) {
    // Appelle la fonction pour enregistrer l'utilisateur
    _registerUser();
  } else if (response.statusCode == 404) {
    // Affiche un message d'erreur si le code promo est invalide
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Code promo invalide. Veuillez saisir un code promo valide.'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

void _registerUser() async {
  // Envoie une requête HTTP pour enregistrer l'utilisateur
  final response = await http.post(
    Uri.parse('http://s-p5.com/komi/tradi_sante/inscription.php'),
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

  // Si la réponse du serveur est 200, l'enregistrement est réussi
  if (response.statusCode == 200) {
    // Met à jour l'état pour afficher un message de réussite
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

    // Fait disparaître le message après trois secondes
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        message = '';
      });
    });
  } else if (response.statusCode == 400) {
    // Si la réponse du serveur est 400, il y a une erreur d'enregistrement
    setState(() {
      message = 'Erreur d\'enregistrement: ${response.body}';
    });
  }
}
