import 'package:flutter/material.dart';
import '../services/xano_service.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // void _login() async {
  //   if (_formKey.currentState!.validate()) {
  //     final email = emailController.text;
  //     final password = passwordController.text;

  //     try {
  //       // final success = await XanoService().login(email, password);
  //       final response = await XanoService().login(email, password);
  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         //storer le token dans le local storage
  //         //il faut ajouter le token dans le local storage response.body.authToken
  //         const SnackBar(content: Text('Connecté : ')),
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(builder: (context) => const HomePage()),
  //         );
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Email ou mot de passe incorrect')),
  //         );
  //       }
  //     } catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Erreur lors de la connexion: $e')),
  //       );
  //     }
  //   }
  // }

  void _login() async {
  final email = emailController.text;
  final password = passwordController.text;

  final response = await XanoService().login(email, password);

  if (response['statusCode'] == 200 || response['statusCode'] == 201) {
    final token = response['authToken'] ?? 'inconnu';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Connecté : $token')),
    );
    // Redirection éventuelle ici
  } else {
    print(response['message']);
    print(response['body']);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erreur: ${response['message']}')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connexion')),
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
                onPressed: _login,
                child: const Text('Connexion'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text("Pas encore inscrit ? Crée un compte"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
