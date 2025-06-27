import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/xano_service.dart';
import 'dart:convert';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // // void _signup() {
  // //   if (_formKey.currentState!.validate()) {
  // //     final email = emailController.text;
  // //     final password = passwordController.text;

  // //     // TODO: Enregistrer l'utilisateur avec ton backend ici
  // //     ScaffoldMessenger.of(context).showSnackBar(
  // //       SnackBar(content: Text('Compte créé pour $email')),
  // //     );

  // //     Navigator.pop(context); // Retour à la page de login
  // //   }
  // // }

  // void _signup() async {
  //   if (_formKey.currentState!.validate()) {
  //     final email = emailController.text;
  //     final password = passwordController.text;

  //     // final url = Uri.parse('https://x8ki-letl-twmt.n7.xano.io/api:y8YLSaQk/users');

  //     try {
  //       final response = await XanoService().register(email, password, null);
  //       // final response = await http.post(
  //       //   url,
  //       //   headers: {'Content-Type': 'application/json'},
  //       //   body: jsonEncode({
  //       //     'email': email,
  //       //     'password': password,
  //       //   }),
  //       // );

  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         //il faut ajouter le token dans le local storage response.body.authToken
          
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Compte créé pour $email')),
  //         );
  //         Navigator.pop(context);
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Erreur: ${response.statusCode}')),
  //         );
  //         // print('Erreur: ${response.get("message")}');
  //         print('Erreur: signup');
  //       }
  //     } catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Erreur réseau : $e')),
  //       );
  //     }
  //   }
  // }


  void _signup() async {
  if (_formKey.currentState!.validate()) {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      final response = await XanoService().register(email, password);

      if (response['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Compte créé pour $email')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: ${response['statusCode']}')),
        );
        print('Erreur: ${response['body']}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur réseau : $e')),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inscription')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    value != null && value.contains('@') ? null : 'Email invalide',
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
                validator: (value) =>
                    value != null && value.length >= 6 ? null : 'Mot de passe trop court',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signup,
                child: const Text('Créer un compte'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
