import 'package:fincalculator/Screens/emiscreen.dart';
import 'package:fincalculator/Screens/investmentscreen.dart';
import 'package:fincalculator/Widgets/availablecalculators.dart';
import 'package:fincalculator/locator.dart';
import 'package:fincalculator/theme.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = locator<FinAppTheme>();
    return Scaffold(
      backgroundColor: theme.screenBgc,
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: theme.drawerBarDecoration(),
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                        child: Image(
                      image: AssetImage('assets/images/Fin4.png'),
                    )))),
            GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => InvestmentScreen())),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Investment Calculator",
                          style: theme.display14w1000(),
                        ),
                        Icon(Icons.chevron_right),
                      ]),
                )),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => EMIScreen())),
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("EMI Calculator", style: theme.display14w1000()),
                        Icon(Icons.chevron_right),
                      ])),
            )
          ],
        ),
      ),
      appBar: AppBar(
        flexibleSpace: Container(decoration: theme.appbardecoration()),
        backgroundColor: theme.appBarColor,
        title: Text(
          "FinoCal - Financial Calculators",
          style: theme.display24w600(),
        ),
      ),
      body: SingleChildScrollView(
        child: AvailableCalculators(),
      ),
    );
  }
}
