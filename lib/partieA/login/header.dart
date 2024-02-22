// import 'package:client/partieA/login/AjoutProduit.dart';
// import 'package:client/partieA/login/accueilClient.dart';
import 'package:client/partieA/login/welcome_default.dart';
// import 'package:client/partieA/login/welcome_default.dart';
// import 'package:client/partieA/login/accueilClient.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

var box = Hive.box('data');

class CustomHeader extends StatefulWidget implements PreferredSizeWidget {
  const CustomHeader({super.key});

  @override
  State<CustomHeader> createState() => _CustomHeaderState();

  @override
  Size get preferredSize =>
      const Size.fromHeight(56.0); // Ajustez la hauteur selon vos besoins
}

class _CustomHeaderState extends State<CustomHeader> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      leading: const Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: CircleAvatar(
            backgroundImage: AssetImage('image/tradisante.png'),
            backgroundColor: Colors.white,
            radius: 30,
          ),
        ),
      ),
      actions: [
        Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                setState(() {
                  
                  box.put('isLoggedIn', false);
                  
                });
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const Welcome()));
               Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => const Welcome()));
              },
              tooltip: 'Déconnexion',
            );
          },
        )
      ],
    );
  }
}
