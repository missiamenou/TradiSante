import 'package:flutter/material.dart';

class PopUpDialogPersonnalise extends StatelessWidget {
  final String titre;
  final String message;
  final Function onClosePressed;

  const PopUpDialogPersonnalise({
    required Key key,
    required this.titre,
    required this.message,
    required this.onClosePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                titre,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(message),
            ),
            // ElevatedButton(
            //   child: const Text('Fermer'),
            //   onPressed: Navigator.,
            // ),
          ],
        ),
      ),
    );
  }
}
