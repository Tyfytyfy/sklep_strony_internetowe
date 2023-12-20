import 'package:flutter/material.dart';
import 'package:sklep_strony_internetowe/src/constants/input_decoration.dart';
import 'package:sklep_strony_internetowe/src/services/auth.dart';

class EmailPasswwordChange extends StatefulWidget {
  const EmailPasswwordChange({super.key});

  @override
  State<EmailPasswwordChange> createState() => _EmailPasswwordChangeState();
}

class _EmailPasswwordChangeState extends State<EmailPasswwordChange> {
  final AuthService _auth = AuthService();
  final _emailKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
  final scrollController = ScrollController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(240, 217, 186, 140),
      appBar: AppBar(
        title: const Text(
          "Zmień hasło i email",
        ),
        backgroundColor: const Color.fromARGB(240, 217, 186, 140),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Center(
          child: Column(children: [
            const SizedBox(
              height: 11,
            ),
            Form(
                key: _emailKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: 250,
                      height: 42,
                      child: TextFormField(
                        controller: _emailController,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) => val!.isEmpty ? 'Podaj email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_emailKey.currentState?.validate() ?? false) {
                          await _auth.updateEmail(
                            email,
                            context,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 195, 172, 126),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: const Text("Zmień email"),
                    )
                  ],
                )),
            Form(
                key: _passwordKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 11,
                    ),
                    SizedBox(
                      width: 250,
                      height: 42,
                      child: TextFormField(
                        controller: _currentPasswordController,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Stare hasło '),
                        obscureText: true,
                        validator: (val) =>
                            val!.isEmpty ? 'Podaj stare hasło' : null,
                      ),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    SizedBox(
                      width: 250,
                      height: 42,
                      child: TextFormField(
                        controller: _newPasswordController,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Nowe hasło'),
                        obscureText: true,
                        validator: (val) =>
                            val!.isEmpty ? 'Podaj nowe hasło' : null,
                      ),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    SizedBox(
                      width: 250,
                      height: 42,
                      child: TextFormField(
                        controller: _confirmNewPasswordController,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Potwierdź hasło'),
                        obscureText: true,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Potwierdź nowe hasło';
                          } else if (val != _newPasswordController.text) {
                            return 'Hasła nie są identyczne';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_passwordKey.currentState?.validate() ?? false) {
                          await _auth.updatePassword(
                            password,
                            context,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 195, 172, 126),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100))),
                      child: const Text("Zmień hasło"),
                    )
                  ],
                ))
          ]),
        ),
      ),
    );
  }
}
