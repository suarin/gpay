import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/screens/issue_screen.dart';
import 'package:gpay/screens/recharge_screen.dart';
import 'package:gpay/screens/shop_screen.dart';
import 'package:gpay/screens/transfer_screen.dart';
class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          child: ListView(
            children: [
              DrawerHeader(
                child: Container(
                  child: Stack(
                    children: [
                       Positioned(
                        child: Text(
                            S.of(context).menu,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'VarelaRoundRegular',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Positioned(
                        child: SizedBox(
                          child: Image.asset('images/logos/gpay_white_logo_271x125.png'),
                          height: 140,
                          width: 140,
                        ),
                        left: (MediaQuery.of(context).size.width - 220) /2,
                      ),
                    ],
                  ),
                  width: 500,
                ),
               decoration: const BoxDecoration(
                 color: Color(0xFF194D82),
               ),
              ),
              Container(
                child: TextButton(
                  child:  Text(
                    S.of(context).loads,
                    style: const TextStyle(
                      color: Color(0xFF194D82),
                      fontFamily: 'VarelaRoundRegular',
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RechargeScreen(),
                      ),
                    );
                  },
                ),
                decoration:  BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF194D82)
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(30.0))
                ),
                margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
              ),
              Container(
                child: TextButton(
                  child:  Text(
                    S.of(context).shop,
                    style: const TextStyle(
                        color: Color(0xFF194D82),
                        fontFamily: 'VarelaRoundRegular',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShopScreen(),
                      ),
                    );
                  },
                ),
                decoration:  BoxDecoration(
                    border: Border.all(
                        color: const Color(0xFF194D82)
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(30.0))
                ),
                margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
              ),
              Container(
                child: TextButton(
                  child:  Text(
                    S.of(context).transfer,
                    style: const TextStyle(
                        color: Color(0xFF194D82),
                        fontFamily: 'VarelaRoundRegular',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TransferScreen(),
                      ),
                    );
                  },
                ),
                decoration:  BoxDecoration(
                    border: Border.all(
                        color: const Color(0xFF194D82)
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(30.0))
                ),
                margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
              ),
              Container(
                child: TextButton(
                  child:  Text(
                   S.of(context).requisition,
                    style: const TextStyle(
                        color: Color(0xFF194D82),
                        fontFamily: 'VarelaRoundRegular',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const IssueScreen(),
                      ),
                    );
                  },
                ),
                decoration:  BoxDecoration(
                    border: Border.all(
                        color: const Color(0xFF194D82)
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(30.0))
                ),
                margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
              ),
            ],
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
