import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sklep_strony_internetowe/src/authenticate/login_screen.dart';
import 'package:sklep_strony_internetowe/src/models/user.dart' as custom_user;
import 'package:sklep_strony_internetowe/src/services/auth.dart';
import 'package:sklep_strony_internetowe/src/settings/settings_change_password_email.dart';
import 'package:sklep_strony_internetowe/src/shared/color_themes.dart';

class ProfileScreen extends StatefulWidget {
  final ThemeNotifier themeNotifier;

  const ProfileScreen({super.key, required this.themeNotifier});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _auth = AuthService();
  bool isSwitched = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    loadSwitchState();
  }

  Future<void> loadSwitchState() async {
    await loadThemeMode();
    setState(() {
      _loading = false;
    });
  }

  Future<void> loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    widget.themeNotifier.setTheme(AppTheme.getThemeData(isDarkMode));
    setState(() {
      isSwitched = isDarkMode;
    });
  }

  Future<void> saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = widget.themeNotifier.currentTheme;
    final user = Provider.of<custom_user.User?>(context);
    final MaterialStateProperty<Icon?> thumbIcon =
        MaterialStateProperty.resolveWith<Icon?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const Icon(Icons.bedtime);
        }
        return const Icon(Icons.sunny);
      },
    );
    String? email = user?.email;
    List<String>? emailParts = email?.split('@');
    String? username = emailParts?[0];

    if (_loading) {
      return const CircularProgressIndicator();
    }

    return Scaffold(
      backgroundColor: currentTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Profil użytkownika ${username ?? ''}",
          style: currentTheme.appBarTheme.titleTextStyle,
        ),
        backgroundColor: currentTheme.appBarTheme.backgroundColor,
        iconTheme: currentTheme.appBarTheme.iconTheme,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 11,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await _auth.signOut();
                if (!mounted) return;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(
                      themeNotifier: widget.themeNotifier,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.logout, color: Colors.white),
              label:
                  const Text('Wyloguj', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 40),
                  backgroundColor: currentTheme
                      .elevatedButtonTheme.style!.backgroundColor
                      ?.resolve({})),
            ),
            const SizedBox(
              height: 11,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmailPasswwordChange(
                      themeNotifier: widget.themeNotifier,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 40),
                  backgroundColor: currentTheme
                      .elevatedButtonTheme.style!.backgroundColor
                      ?.resolve({})),
              child: const Text("Zmień hasło lub email",
                  style: TextStyle(color: Colors.white)),
            ),
            Switch(
              trackColor: currentTheme.switchTheme.trackColor,
              thumbIcon: thumbIcon,
              value: isSwitched,
              onChanged: (value) async {
                setState(() {
                  isSwitched = value;
                });

                await saveSwitchState(value);

                if (mounted) {
                  final ThemeData newTheme =
                      value ? AppTheme.darkTheme() : AppTheme.lightTheme();
                  Provider.of<ThemeNotifier>(context, listen: false)
                      .setTheme(newTheme);
                }

                setState(() {
                  isSwitched = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
