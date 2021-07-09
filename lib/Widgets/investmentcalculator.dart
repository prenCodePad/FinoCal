import 'package:fincalculator/Widgets/donutchart.dart';
import 'package:fincalculator/Widgets/results.dart';
import 'package:fincalculator/Widgets/sliderinput.dart';
import 'package:fincalculator/locator.dart';
import 'package:fincalculator/providers/investmentcalprovider.dart';
import 'package:fincalculator/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvestmentCalculator extends StatelessWidget {
  InvestmentCalculator({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = locator<FinAppTheme>();
    final investmentProvider =
        Provider.of<InvestmentProvider>(context, listen: true);
    var investmentVariables = investmentProvider.investmentVariables;
    return Container(
        height: theme.investmentScreenheight,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(children: [
          Expanded(flex: 1, child: InvestmentType()),
          SizedBox(height: 15),
          Expanded(
              flex: 5,
              child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: investmentVariables.keys
                          .map((e) => SliderInput(
                                action: investmentProvider.setValue,
                                heading: e,
                                label: investmentVariables[e]!.representation,
                                controller: investmentVariables[e]!.controller!,
                                divisions:
                                    investmentVariables[e]!.divisions!.toInt(),
                                max: investmentVariables[e]!.max!,
                                min: investmentVariables[e]!.min!,
                                sliderValue:
                                    investmentProvider.sliderValue(e).toInt(),
                              ))
                          .toList()))),
          Expanded(
              flex: 5,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                          alignment: Alignment.center,
                          child: DonutRepresetation(
                            dataMap: investmentProvider.dataMap,
                          ))),
                  Expanded(
                      flex: 1,
                      child: Results(
                        estimatedReturns: investmentProvider.finalReturns,
                        investedValue: investmentProvider.finalInvestedAmount,
                        totalValue: investmentProvider.finalTotalAmount,
                      ))
                ],
              ))
        ]));
  }
}

class InvestmentType extends StatelessWidget {
  InvestmentType({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = locator<FinAppTheme>();
    final investmentProvider =
        Provider.of<InvestmentProvider>(context, listen: true);
    final radioValue = investmentProvider.typeOfInvestment;
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: investmentProvider.typesOfInvestment
            .map((e) => Row(children: [
                  Radio<String>(
                      value: e,
                      groupValue: radioValue,
                      onChanged: (String? value) {
                        investmentProvider.setTypesOfInvestment(value);
                      }),
                  Text(e, style: theme.display16w600()),
                  if (e == "SIP") SizedBox(width: 30)
                ]))
            .toList());
  }
}