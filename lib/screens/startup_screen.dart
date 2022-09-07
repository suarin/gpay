import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/screens/forms/registration_form.dart';
import 'package:gpay/screens/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({Key? key}) : super(key: key);

  @override
  _StartupScreenState createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  var screenSize, screenWidth, screenHeight;

  _openURL() async {
    const url = 'https://wa.me/17864443669';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
    throw 'Could not launch $url';
  }
  }

  _openEmail() async {
    launch(
    "mailto:soportecliente@gpspay.me?subject=Ayuda Email&body=");
  }

  _showHelpOptions(BuildContext context){

    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.greenAccent,
          child: Center(
            child: Column(
              children: <Widget>[
                IconButton(onPressed: (){
                  _openEmail();
                }, icon: const Icon(Icons.attach_email)),
                IconButton(onPressed: (){
                  _openURL();
                }, icon: const Icon(Icons.chat)),
                ElevatedButton(
                  child:  Text(S.of(context).close),
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0XFF0E325F),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );

  }
  @override
  Widget build(BuildContext context) {

    screenSize = MediaQuery.of(context).size;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      child: Scaffold(
        body: SizedBox(
          child: Stack(
            children: [
              Positioned(
                child: SizedBox(
                  child: Image.asset(
                    'images/backgrounds/page_header.png',
                    fit: BoxFit.fitWidth,
                  ),
                  height: screenHeight / 2,
                ),
              ),
              Positioned(
                child: Image.asset('images/logos/gpay_white_logo_271x125.png'),
                top: screenHeight / 8,
                left: (screenWidth - 271) / 2,
              ),
              Positioned(
                child: Column(
                  children: [
                    Container(
                      child: TextButton(
                        child: Text(
                            S.of(context).signIn,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'VarelaRoundRegular',
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0
                          ),
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context){
                                return LoginScreen();
                              }
                            ),
                          );
                        },
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFF00FFD5),
                        borderRadius: BorderRadius.all(Radius.circular(25.0))
                      ),
                      margin: const EdgeInsets.only(bottom: 10.0),
                      width: 300,
                    ),
                   Container(
                     child:  TextButton(
                       child:  Text(
                           S.of(context).signUp,
                         style: const TextStyle(
                           color: Colors.black,
                           fontFamily: 'VarelaRoundRegular',
                           fontWeight: FontWeight.bold,
                           fontSize: 20.0
                         ),
                       ),
                       onPressed: (){
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => const RegistrationForm()
                           ),
                         );
                       },
                     ),
                     decoration: const BoxDecoration(
                       color: Color(0xFF00FFD5),
                       borderRadius: BorderRadius.all(Radius.circular(25.0))
                     ),
                     margin: const EdgeInsets.only(bottom: 20.0),
                     width: 300.0,
                   ),
                    Container(
                      child: TextButton(
                        child: Text(
                          S.of(context).help,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'VarelaRoundRegular',
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0
                          ),
                        ),
                        onPressed: (){
                          _showHelpOptions(context);
                        },
                      ),
                    )
                  ],
                ),
                top: screenHeight / 2,
                left: (screenWidth  - 300) / 2,
              ),
              Positioned(
                child: SizedBox(
                  child: Image.asset('images/logos/gpay_blue_logo_87x40.png'),
                ),
                top: screenHeight - 75.0,
                left: (screenWidth - 87) / 2,
              )
            ],
          ),
          height: screenHeight,
        ),
      ),
      onWillPop: () async => false,
    );
  }
}


