import 'package:client/main.dart';
import 'package:client/partieA/login/reinitialiseMail.dart';
// import 'package:client/partieA/login/reinitialiseMail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class VerifMail extends StatefulWidget {
  const VerifMail({Key? key});

  @override
  State<VerifMail> createState() => _VerifMailState();
}

class _VerifMailState extends State<VerifMail> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  String message = '';

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  // Fonction pour valider une adresse e-mail
  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(email);
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
                                SizedBox(
                                  height: 20,
                                ),
                                Material(
                                  color: couleurPrimaire,
                                  borderRadius: BorderRadius.circular(30),
                                  child: InkWell(
                                    onTap: () async {
                                      if (formKey.currentState!.validate()) {
                                        final response = await http.post(
                                          Uri.parse(
                                              'http://s-p5.com/komi/tradi_sante/check_email.php'),
                                          body: {
                                            'email': emailController.text,
                                          },
                                        );
                                        if (response.statusCode == 200) {
                                          setState(() {
                                            message = 'Enregistrement réussi';
                                            emailController.clear();
                                          });
                                          // Fait disparaître le message après trois secondes
                                          Future.delayed(
                                              const Duration(seconds: 3), () {
                                            setState(() {
                                              message = '';
                                            });
                                          });
                                        } else {
                                          setState(() {
                                            message =
                                                'Erreur d\'enregistrement';
                                          });
                                        }
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ReinitialiseMail()), // Assurez-vous que la classe Acceuil est correcte
                                        );
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(30),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 10),
                                      child: Text(
                                        "Se connecter",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
