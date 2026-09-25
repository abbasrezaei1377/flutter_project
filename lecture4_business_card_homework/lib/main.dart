import 'package:flutter/material.dart';

void main() {
  runApp(const BusinessCardApp());
}

class BusinessCardApp extends StatelessWidget {
  const BusinessCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Business Card',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const BusinessCardScreen(),
    );
  }
}

class BusinessCardScreen extends StatelessWidget {
  const BusinessCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF169C91),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 30,
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // ==========================
                // PROFILE IMAGE
                // ==========================
                const CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(
                    'assets/images/profile.jpg',
                  ),
                ),

                const SizedBox(height: 20),

                // ==========================
                // NAME
                // ==========================
                const Text(
                  'Abbas Rezaie',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                // ==========================
                // JOB TITLE
                // ==========================
                const Text(
                  'FLUTTER DEVELOPER',
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 3,
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 15),

                // ==========================
                // DIVIDER
                // ==========================
                const SizedBox(
                  width: 180,
                  child: Divider(
                    color: Colors.white54,
                    thickness: 1,
                  ),
                ),

                const SizedBox(height: 20),

                // ==========================
                // PHONE CARD
                // ==========================
                Card(
                  color: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),

                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 6,
                    ),

                    child: ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: Color(0xFF169C91),
                        size: 30,
                      ),

                      title: Text(
                        '+93 700 000 000',
                        style: TextStyle(
                          color: Color(0xFF167B73),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // ==========================
                // EMAIL CARD
                // ==========================
                Card(
                  color: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),

                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 6,
                    ),

                    child: ListTile(
                      leading: Icon(
                        Icons.email,
                        color: Color(0xFF169C91),
                        size: 30,
                      ),

                      title: Text(
                        'your_email@gmail.com',
                        style: TextStyle(
                          color: Color(0xFF167B73),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // ==========================
                // LOCATION CARD
                // ==========================
                Card(
                  color: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),

                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 6,
                    ),

                    child: ListTile(
                      leading: Icon(
                        Icons.location_on,
                        color: Color(0xFF169C91),
                        size: 30,
                      ),

                      title: Text(
                        'Kabul, Afghanistan',
                        style: TextStyle(
                          color: Color(0xFF167B73),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}