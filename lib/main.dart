import 'package:client/Auth_Provider.dart';
// import 'package:client/partieA/login/AjoutProduit.dart';
// import 'package:client/partieA/login/Connexion.dart';
// import 'package:client/partieA/login/Parametre.dart';
// import 'package:client/partieA/login/Profil.dart';
// import 'package:client/partieA/login/accueil.dart';
import 'package:client/partieA/login/welcome_default.dart';
import 'package:flutter/material.dart';
// import 'package:client/partieA/login/AccueilClient.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
// import 'path/to/auth_provider.dart'; // Remplacez par le chemin réel de votre fichier AuthProvider


const couleurPrimaire = Color(0xFF117C0F);
// var data = Hive.box('data');
var box = Hive.box('data');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('data');

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MyWidget(),
    ),
  );
}

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Welcome(),
    );
  }
}
