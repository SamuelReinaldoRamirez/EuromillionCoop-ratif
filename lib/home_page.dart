import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

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

  Widget _buildHomeTab() {
    return const Center(
      child: Text('Contenu de l\'onglet Accueil'),
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
