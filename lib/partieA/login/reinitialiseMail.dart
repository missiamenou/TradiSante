import 'package:client/partieA/login/connexion.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReinitialiseMail extends StatefulWidget {
  const ReinitialiseMail({Key? key});

  @override
  State<ReinitialiseMail> createState() => _ReinitialiseMailState();
}

class _ReinitialiseMailState extends State<ReinitialiseMail> {
  final _formKey = GlobalKey<FormState>();
  final nouveauMotDePasseController = TextEditingController();
  final confirmerMotDePasseController = TextEditingController();
  String message = '';

  @override
  void dispose() {
    nouveauMotDePasseController.dispose();
    confirmerMotDePasseController.dispose();

    super.dispose();
  }

  void _reinitialiserMotDePasse() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse('http://s-p5.com/komi/tradi_sante/ChgMot.php'),
        body: {
          'nouveauMotDePasse': nouveauMotDePasseController.text,
          'email': 'l\'email de l\'utilisateur ici',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          message = 'Mot de passe réinitialisé avec succès';
          nouveauMotDePasseController.text =
              ''; // Effacer le champ du nouveau mot de passe
          confirmerMotDePasseController.text =
              ''; // Effacer le champ de confirmation du mot de passe
        });

        // Supprimer le message après deux secondes
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            message = '';
          });
        });

        // Rediriger l'utilisateur vers la page de connexion
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Connexion()),
        );
      } else {
        setState(() {
          message = 'Erreur lors de la réinitialisation du mot de passe';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
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
                'Réinitialisation',
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
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Réinitialiser votre mot de passe',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      fillColor: Color.fromARGB(
                          255, 246, 246, 246), // Couleur de remplissage grise
                      filled: true,
                      labelText: "Nouveau mot de passe",
                      hintText: "Nouveau mot de passe",
                      prefixIcon: Icon(
                        Icons.lock_outline,
                      ),
                    ),
                    controller: nouveauMotDePasseController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un nouveau mot de passe';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      fillColor: Color.fromARGB(
                          255, 246, 246, 246), // Couleur de remplissage grise
                      filled: true,
                      labelText: "Confirmer le mot de passe",
                      hintText: "Confirmer le mot de passe",
                      prefixIcon: Icon(
                        Icons.lock_outline,
                      ),
                    ),
                    obscureText: true,
                    controller: confirmerMotDePasseController,
                    validator: (value) {
                      if (value != nouveauMotDePasseController.text) {
                        return 'Les mots de passe ne correspondent pas';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    child: const Text(
                      'Réinitialiser',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    onPressed: _reinitialiserMotDePasse,
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      backgroundColor: Color(0xFF117C0F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Ajustez le rayon de courbure des bords selon vos préférences
                      ),
                      // Ajustez les styles du bouton selon vos préférences
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
