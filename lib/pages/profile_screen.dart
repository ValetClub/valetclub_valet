import 'package:flutter/material.dart';
import 'package:valetclub_valet/common/theme.dart';
import 'package:valetclub_valet/components/settings.dart';

class ProfileScreen extends StatelessWidget {
  final bool isFromBottomNavBar;

  const ProfileScreen({
    super.key,
    required this.isFromBottomNavBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Condition Of showing AppBar or Not based on
      // whether the screen is opened from BottomNavigationBar or not
      appBar: isFromBottomNavBar
          ? null
          : AppBar(
              title: const Text(
                'Profile',
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
              backgroundColor: MainTheme.secondaryColor,
              foregroundColor: MainTheme.darkColor,
            ),
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
          color: MainTheme.secondaryColor,
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
                //Making the circle around the Image
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: MainTheme.thirdColor,
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
                    color: MainTheme.secondaryColor,
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
              color: MainTheme.secondaryColor,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            text.split('\n')[1],
            style: const TextStyle(
              color: MainTheme.secondaryColor,
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
        color: MainTheme.warningColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: MainTheme.darkColor.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Text(
        'En mission',
        style: TextStyle(
          color: MainTheme.secondaryColor,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildStatistics() {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: MainTheme.secondaryColor,
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
          color: MainTheme.greyColor.withOpacity(0.4),
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildFooterText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40, left: 20),
      child: Text(
        text,
        style: const TextStyle(
          color: MainTheme.thirdColor,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildCustomCard(String title, String content) {
    return Container(
      decoration: BoxDecoration(
        color: MainTheme.greyColor.withOpacity(0.3),
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
