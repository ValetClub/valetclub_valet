import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Paramètre',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFF7F8FA),
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 10),
                Container(
                  color: Colors.white,
                  child: const ListTile(
                    title: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/logo_valet.png'),
                          radius: 20,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Profil',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.arrow_right),
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: const ListTile(
                        leading: Icon(Icons.stars_outlined),
                        trailing: Icon(Icons.arrow_right),
                        title: Text('star'),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      color: Colors.white,
                      child: const ListTile(
                        leading: Icon(Icons.notifications),
                        trailing: Icon(Icons.arrow_right),
                        title: Text('notification'),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: const ListTile(
                        leading: Icon(Icons.contact_mail),
                        trailing: Icon(Icons.arrow_right),
                        title: Text('mail'),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      color: Colors.white,
                      child: const ListTile(
                        leading: Icon(Icons.looks),
                        trailing: Icon(Icons.arrow_right),
                        title: Text('looks'),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      color: Colors.white,
                      child: const ListTile(
                        leading: Icon(Icons.lock),
                        trailing: Icon(Icons.arrow_right),
                        title: Text('lock'),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
