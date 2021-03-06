import 'package:fincalculator/Widgets/donutchart.dart';
import 'package:fincalculator/Widgets/repaymentschedule.dart';
import 'package:fincalculator/Widgets/results.dart';
import 'package:fincalculator/Widgets/sliderinput.dart';
import 'package:fincalculator/locator.dart';
import 'package:fincalculator/providers/emicalprovider.dart';

import 'package:fincalculator/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EMICalculator extends StatelessWidget {
  EMICalculator({Key? key}) : super(key: key);

  final _tabs = [
    const Tab(text: 'ANALYSIS'),
    const Tab(text: 'STATEMENT'),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = locator<FinAppTheme>();
    return Container(
        height: theme.emiScreenHeight,
        child: DefaultTabController(
            length: _tabs.length,
            child: Column(children: [
              Container(
                color: Color(0xff1C7EC9),
                height: theme.defaultNavBarHeight,
                child: TabBar(
                    tabs: _tabs,
                    indicatorColor: theme.white,
                    labelPadding: EdgeInsets.zero),
              ),
              Expanded(
                  child:
                      TabBarView(children: [Analysis(), RepaymentSchedule()]))
            ])));
  }
}

class Analysis extends StatelessWidget {
  Analysis({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final emiProvider = Provider.of<EMIProvider>(context, listen: true);
    var emiVariables = emiProvider.emiVariables;
    var theme = locator<FinAppTheme>();
    return Padding(
        padding: EdgeInsets.fromLTRB(
            theme.screenWidth * 0.02, 0, theme.screenWidth * 0.02, 0),
        child: Column(children: [
          SizedBox(height: theme.screenWidth * 0.04),
          Expanded(
              flex: 5,
              child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: emiVariables.keys.map((e) {
                        return Container(
                            height: theme.fullheight * 0.145,
                            child: SliderInput(
                                heading: e,
                                label: emiVariables[e]!.representation,
                                sliderValue: emiProvider.sliderValue(e),
                                controller: emiVariables[e]!.controller!,
                                min: emiVariables[e]!.min!,
                                max: emiVariables[e]!.max!,
                                divisions: emiVariables[e]!.divisions!,
                                action: emiProvider.setValue));
                      }).toList()))),
          Expanded(
              flex: 4,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                          alignment: Alignment.center,
                          child: DonutRepresentation(
                            dataMap: emiProvider.dataMap,
                          ))),
                  Expanded(
                      flex: 1,
                      child: Results(
                        label1: "EMI",
                        value1: emiProvider.emi,
                        label2: "Total Interest",
                        value2: emiProvider.interestPayable,
                        label3: "Total Payment (P+I)",
                        value3: emiProvider.totalPayable,
                      ))
                ],
              ))
        ]));
  }
}
