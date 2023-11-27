import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/input_decoration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: 360,
              height: 214,
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Color.fromARGB(240, 217, 186, 140),
              ),
            ),
            const SizedBox(
              height: 71,
            ),
            Form(
              child: Column(
                children: [
                  Container(
                    width: 205,
                    height: 47,
                    margin: const EdgeInsets.only(left: 77, right: 78),
                    child: TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) => val!.isEmpty ? 'Podaj email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Container(
                    width: 205,
                    height: 47,
                    margin: const EdgeInsets.only(left: 77, right: 78),
                    child: TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Hasło'),
                      validator: (val) => val!.isEmpty ? 'Podaj hasło' : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                  ),
                  Container(
                    width: 156,
                    height: 42,
                    margin: const EdgeInsets.only(left: 94, right: 110),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                5), // Zaokrąglenie rogów checkboxa
                          ),
                        ),
                        const Text('Zapamiętaj mnie'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(215, 55),
                      backgroundColor: const Color.fromARGB(255, 195, 172, 126),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            100), // Zaokrąglenie rogów przycisku
                      ), // Dostosuj szerokość i wysokość przycisku
                    ),
                    child: const Text('Zaloguj się'),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {}, //tutaj link będzie
                    child: const Text('Nie posiadasz konta? Zarejestruj się',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontFamily: 'Inter',
                            fontSize: 12,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                            height: 1)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {}, //tutaj link będzie
                    child: const Text('Zapomniałeś hasła?',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontFamily: 'Inter',
                            fontSize: 12,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                            height: 1)),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
          margin: const EdgeInsets.only(left: 48),
          child: Row(
            children: [
              Container(
                width: 63,
                height: 63,
                margin: const EdgeInsets.only(bottom: 29),
                child: FloatingActionButton(
                  onPressed: () {
                    // Obsługa pierwszego przycisku w dolnym lewym rogu
                  },
                  backgroundColor: const Color.fromARGB(40, 204, 162, 79),
                  elevation: 0,
                  child: SvgPicture.asset('assets/images/phone.svg',
                      semanticsLabel: 'phone'),
                ),
              ),
              const SizedBox(
                width: 170,
              ),
              // Dodane, aby uzyskać odstęp między przyciskami
              Container(
                width: 63,
                height: 63,
                margin: const EdgeInsets.only(bottom: 29),
                child: FloatingActionButton(
                  onPressed: () {
                    // Obsługa drugiego przycisku w dolnym prawym rogu
                  },
                  backgroundColor: const Color.fromARGB(40, 204, 162, 79),
                  elevation: 0,
                  child: SvgPicture.asset('assets/images/faq.svg',
                      semanticsLabel: 'faq'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
