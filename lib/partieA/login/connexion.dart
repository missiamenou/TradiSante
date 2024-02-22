import 'dart:convert';

import 'package:client/main.dart';
import 'package:client/partieA/login/AccueilClient.dart';
// import 'package:client/partieA/login/VerifMail.dart';
// import 'package:client/partieA/login/accueil.dart';
// import 'package:client/partieA/login/accueilClient.dart';
import 'package:client/partieA/login/header.dart';
import 'package:client/partieA/login/inscription.dart';
import 'package:client/partieA/login/welcome2.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

var box = Hive.box('data');

class Connexion extends StatefulWidget {
  const Connexion({Key? key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final motdepasseController = TextEditingController();
  String message = '';
  bool _showMessage = false;
  var _obscureText = true;
  bool isLoggedIn = false;

  @override
  void dispose() {
    emailController.dispose();
    motdepasseController.dispose();
    super.dispose();
  }

  void _hideMessageAfterDelay() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        message = '';
      });
    });
  }

  void _navigateToHomePageAfterDelay() {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AccueilClient()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 8),
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40)),
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
                                      borderSide:
                                          BorderSide(color: Colors.white60),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      borderSide:
                                          BorderSide(color: Colors.white60),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      borderSide:
                                          BorderSide(color: Colors.white60),
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
                                      borderSide:
                                          BorderSide(color: Colors.white60),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      borderSide:
                                          BorderSide(color: Colors.white60),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      borderSide:
                                          BorderSide(color: Colors.white60),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 6),
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Material(
                                  color: couleurPrimaire,
                                  borderRadius: BorderRadius.circular(30),
                                  child: InkWell(
                                    onTap: () async {
                                      if (formKey.currentState!.validate()) {
                                        final response = await http.post(
                                          Uri.parse(
                                              'http://s-p5.com/komi/tradi_sante/connexion.php'),
                                          body: {
                                            'email': emailController.text,
                                            'motdepasse':
                                                motdepasseController.text,
                                          },
                                        );

                                        if (response.statusCode == 200) {
                                          setState(() {
                                            emailController.text = '';
                                            motdepasseController.text = '';
                                            isLoggedIn = true;
                                            box.put('isLoggedIn', true);
                                            box.put(
                                                'NOM',
                                                jsonDecode(
                                                    response.body)["nom"]);
                                            box.put(
                                                'EMAIL',
                                                jsonDecode(
                                                    response.body)["email"]);
                                            box.put(
                                                'CONTACT',
                                                jsonDecode(
                                                    response.body)["contact"]);
                                            box.put(
                                                'NOMBOUTIQUE',
                                                jsonDecode(response.body)[
                                                    "nomBoutique"]);
                                            box.put(
                                                'LOCALISATION',
                                                jsonDecode(response.body)[
                                                    "localisation"]);
                                            box.put(
                                                'PHOTO',
                                                jsonDecode(
                                                    response.body)["photo"]);
                                            box.put(
                                                'CODE',
                                                jsonDecode(
                                                    response.body)["codeUser"]);
                                          });

                                          Future.delayed(const Duration(seconds: 2),
                                              () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const welcome_2(),
                                              ),
                                            );
                                          });
                                        } else if (response.statusCode == 404) {
                                          setState(() {
                                            _showMessage = true;
                                            message = 'Compte inexistant';
                                          });
                                          Future.delayed(const Duration(seconds: 2),
                                              () {
                                            setState(() {
                                              _showMessage = false;
                                            });
                                          });
                                        } else {
                                          setState(() {
                                            _showMessage = true;
                                            message = 'Mot de passe incorrect';
                                          });

                                          Future.delayed(const Duration(seconds: 2),
                                              () {
                                            setState(() {
                                              _showMessage = false;
                                            });
                                          });
                                        }
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(30),
                                    child: Material(
                                      color: couleurPrimaire,
                                      borderRadius: BorderRadius.circular(30),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 10),
                                        child: Text(
                                          "Se connecter",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Pas de compte  ?'),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Inscription()));
                                      },
                                      child: const Text('cliquer ici'),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                    const SizedBox(height: 50,),
                    Visibility(
                  visible: _showMessage,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      message,
                      style: const TextStyle(
                        backgroundColor: Colors.red,
                      ),
                      selectionColor: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
