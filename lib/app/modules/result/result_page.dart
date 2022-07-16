import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_brick_of_resilience/app/modules/result/result_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:the_brick_of_resilience/app/utils/responsive.dart';

class ResultPage extends GetView<ResultController> {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResultController>(
        builder: (_) => Scaffold(
              backgroundColor: const Color.fromARGB(255, 58, 134, 255),
              body: Padding(
                padding: EdgeInsets.all(Responsive.of(context).wp(7)),
                child: Column(
                  children: [
                    // image
                    Image.asset(
                      'assets/images/results.png',
                      width: Responsive.of(context).wp(50),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Table(
                        columnWidths: {
                          0: FlexColumnWidth(Responsive.of(context).wp(30)),
                          1: FlexColumnWidth(Responsive.of(context).wp(20)),
                          2: FlexColumnWidth(Responsive.of(context).wp(25)),
                        },
                        border: TableBorder.all(color: Colors.white),
                        children: getResultRows(context, _),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  List<TableRow> getResultRows(BuildContext context, ResultController _) {
    final List<TableRow> rows = [];
    rows.add(TableRow(
      children: [
        Text(
          AppLocalizations.of(context)!.skill,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
        Text(
          AppLocalizations.of(context)!.score,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
        Text(
          AppLocalizations.of(context)!.qualification,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
      ],
    ));

    for (int i = 0; i < _.globalController.questionnaire.results.length; i++) {
      Color backgroundColor = _.getColorByDescription(
          _.globalController.questionnaire.results[i].description);
      rows.add(TableRow(
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        children: [
          Text(
            _.getItemName(
                context, _.globalController.questionnaire.results[i].itemName),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, color: Colors.white),
          ),
          Text(
            _.globalController.questionnaire.results[i].score.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, color: Colors.white),
          ),
          Text(
            _.getDescription(context,
                _.globalController.questionnaire.results[i].description),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, color: Colors.white),
          ),
        ],
      ));
    }
    return rows;
  }
}
