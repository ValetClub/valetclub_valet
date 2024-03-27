import 'package:flutter/material.dart';
import 'package:valetclub_valet/components/settings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 16),
                _buildSettingsIcon(context),
                const SizedBox(height: 16),
                _buildProfileInfo(),
                const SizedBox(height: 16),
                _buildStatistics(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsIcon(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SettingsScreen(),
          ),
        );
      },
      child: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(16),
        child: Image.asset(
          'assets/images/settings.png',
          width: 30,
          height: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                _buildProfileText('24k\nMissions'),
              ],
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/logo_valet.png'),
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Oussama Rochdi",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                _buildStatus(),
              ],
            ),
            Column(
              children: [
                _buildProfileText('152\nAvis'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileText(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            text.split('\n')[0],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            text.split('\n')[1],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatus() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Text(
        'En mission',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildStatistics() {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderText('Statistiques du jour'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  // padding: EdgeInsets.zero,
                  childAspectRatio: 1.2,
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildCustomCard('0', 'Missions'),
                    _buildCustomCard('0 %', "Taux d'annulation"),
                    _buildCustomCard('0 %', 'Taux de reussite'),
                    _buildCustomCard('0.00 DH', 'Recu en especes'),
                  ],
                ),
              ),
            ),
            _buildFooterText('Mes dernieres missions'),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderText(String text) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey[400],
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildFooterText(String text) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildCustomCard(String title, String content) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
