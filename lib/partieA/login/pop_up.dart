import 'package:client/partieA/login/connexion.dart';
import 'package:flutter/material.dart';

void afficherPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding:
            const EdgeInsets.only(bottom: 250, top: 280, left: 0, right: 0),
        child: AlertDialog(
          icon: const Icon(
            Icons.check_circle,
            size: 100,
            color: Color(0xFF4CAF50),
          ),
          content: Center(child: Text('Enregistrement réussi')),
          actions: <Widget>[
            ElevatedButton(
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Connexion()), // Assurez-vous que la classe Acceuil est correcte
                );
                ;
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                backgroundColor: const Color(0xFF734234),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      7.0), // Ajustez le rayon de courbure des bords selon vos préférences
                ),
                // Ajustez les styles du bouton selon vos préférences
              ),
            ),
          ],
        ),
      );
    },
  );
}
