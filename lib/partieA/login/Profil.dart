// import 'package:client/main.dart';
// import 'package:client/partieA/login/bottomNavgaBar.dart';
// import 'package:client/partieA/login/switchPage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


var data = Hive.box("data");
class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  // int _currentIndex = 2;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            // Photo de ProfilPage avec cercle
            
 CircleAvatar(
  radius: 80,
  backgroundImage: NetworkImage(_buildProfileImage()),
),



            const SizedBox(height: 16),
            // Étoiles pour noter la personne
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.brown),
                Icon(Icons.star, color: Colors.brown),
                Icon(Icons.star, color: Colors.brown),
                Icon(Icons.star, color: Colors.brown),
                Icon(Icons.star_border, color: Colors.brown),
              ],
            ),
            const SizedBox(height: 16),
            // Informations : Articles, Followers, Suivis
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoItem('Articles', '0'),
                _buildInfoItem('Followers', '0'),
                _buildInfoItem('Suivis', '0'),
              ],
            ),
            const SizedBox(height: 24),
            // Informations sur l'abonné
            _buildUserInfo('Nom', data.get('NOM')),
            _buildUserInfo('Ville', data.get('EMAIL')),
            _buildUserInfo('Contact', data.get('CONTACT')),
            _buildUserInfo('Nom de la boutique', data.get('NOMBOUTIQUE')),
            _buildUserInfo('Localisation', data.get('LOCALISATION')),
            _buildUserInfo('Mon Code Promo', data.get('CODE')),

            const SizedBox(height: 24),
                      ],
        ),
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

  Widget _buildInfoItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
String _buildProfileImage() {
  // Récupérez le nom de l'image depuis la boîte Hive
  String photoName = data.get('PHOTO', defaultValue: ''); // Assurez-vous que la clé 'PHOTO' est correcte

  // Construisez le chemin complet
  String photoUrl = 'http://s-p5.com/komi/tradi_sante/image_tradi_sante/$photoName';

  return photoUrl;
}
