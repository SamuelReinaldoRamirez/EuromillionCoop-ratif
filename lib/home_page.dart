import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  Future<void> _logout() async {
    try {
      // Supprimer le token d'authentification
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('authToken');
      
      // Naviguer vers la page de connexion
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la déconnexion: $e')),
      );
    }
  }
  late TabController _tabController;


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CoopLoto'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Déconnexion',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.home), text: 'Accueil'),
            Tab(icon: Icon(Icons.gamepad), text: 'Jeux'),
            Tab(icon: Icon(Icons.person), text: 'Profil'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildHomeTab(),
          _buildGamesTab(),
          _buildProfileTab(),
        ],
      ),
    );
  }

  String? _authToken;

  //   @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(length: 3, vsync: this);
  // }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadAuthToken();
  }

  Future<void> _loadAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _authToken = prefs.getString('authToken');
    });
  }

  Widget _buildHomeTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Bienvenue sur CoopLoto !'),
          const SizedBox(height: 20),
          if (_authToken != null)
            Text(
              'Token d\'authentification:\n$_authToken',
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          if (_authToken == null)
            const Text('Pas de token d\'authentification'),
        ],
      ),
    );
  }

  Widget _buildGamesTab() {
    return const Center(
      child: Text('Contenu de l\'onglet Jeux'),
    );
  }

  Widget _buildProfileTab() {
    return const Center(
      child: Text('Contenu de l\'onglet Profil'),
    );
  }
}
