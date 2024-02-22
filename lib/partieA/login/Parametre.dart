// import 'package:client/partieA/login/bottomNavgaBar.dart';
// import 'package:client/partieA/login/switchPage.dart';
import 'package:flutter/material.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  // int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Bannière pour le logo
          Container(
            height: 200, // Ajustez la hauteur selon vos besoins
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.green,
                  Colors.white
                ], // Couleurs du dégradé (vert au blanc)
              ),
            ),
            child: Center(
              child: Text(
                "TRADI SANTE",
                style: TextStyle(
                  fontSize: 32, // Taille de la police
                  color: Colors.green.shade900, // Couleur du texte (blanc)
                  fontWeight: FontWeight.bold, // Texte en gras
                ),
              ),
            ),
          ),

          const ExpansionTile(
            title: Text('Informations sur l\'application'),
            children: [
              ListTile(
                title: Text('Nom de l\'application'),
                subtitle: Text('Nom de votre application'),
              ),
              // Ajoutez d'autres informations sur l'application ici
            ],
          ),
          const ExpansionTile(
            title: Text('Mentions légales'),
            children: [
              ListTile(
                title: Text('Mentions légales'),
                subtitle: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit...'),
              ),
              // Ajoutez d'autres mentions légales ici
            ],
          ),
          const ExpansionTile(
            title: Text('Équipe technique'),
            children: [
              ListTile(
                title: Text('Membre 1'),
                subtitle: Text('Membre de l\'équipe technique 1'),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('asset/images/logo.jpg'),
                ),
              ),
              ListTile(
                title: Text('Membre 2'),
                subtitle: Text('Membre de l\'équipe technique 2'),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('asset/images/logo.jpg'),
                ),
              ),
              // Ajoutez d'autres membres de l'équipe ici
            ],
          ),
          const ExpansionTile(
            title: Text('Autre section d\'information'),
            children: [
              ListTile(
                title: Text('Information 1'),
                subtitle: Text('Description de l\'information 1'),
              ),
              // Ajoutez d'autres informations ici
            ],
          ),
          const ExpansionTile(
            title: Text('Encore une autre section d\'information'),
            children: [
              ListTile(
                title: Text('Information 2'),
                subtitle: Text('Description de l\'information 2'),
              ),
              // Ajoutez d'autres informations ici
            ],
          ),
          // Ajoutez d'autres sections d'informations principales ici
        ],
      ),
      // bottomNavigationBar: CustomBottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   onTap: (index) {
      //     BottomNavigationHelper.onTabTapped(context, index);
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      // ),
    );
  }
}
