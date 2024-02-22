import 'package:client/partieA/login/AjoutProduit.dart';
import 'package:client/partieA/login/Parametre.dart';
import 'package:client/partieA/login/Profil.dart';
import 'package:client/partieA/login/accueilClient.dart';
import 'package:flutter/material.dart';

class welcome_2 extends StatefulWidget {
  const welcome_2({super.key});

  @override
  State<welcome_2> createState() => _welcome_2State();
}

class _welcome_2State extends State<welcome_2> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        controller: _pageController,
        children: const <Widget>[
          AccueilClient(),
          EditProduit(),
          ProfilPage(),
          SettingsForm(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(_currentIndex);
        },
        selectedItemColor: const Color(0xFF117C0F),
        unselectedItemColor: const Color.fromARGB(255, 27, 27, 27),
        iconSize: 32,
        elevation: 10,
        items: const <BottomNavigationBarItem>[
           BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: 'Accueil',
                    backgroundColor: Color(0xFFD9D9D9),
                  ),
                   BottomNavigationBarItem(
                    icon: Icon(Icons.add_circle_outline_outlined),
                    label: 'Ajout',
                    backgroundColor: Color(0xFFD9D9D9),
                  ),
                   BottomNavigationBarItem(
                    icon: Icon(Icons.person_2_outlined),
                    label: 'Profil',
                  ),
                   BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Paramètre',
                  ),
        ],
      ),
    );
  }
}
