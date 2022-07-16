import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_brick_of_resilience/app/global_widgets/button_card.dart';
import 'package:the_brick_of_resilience/app/modules/home/home_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:the_brick_of_resilience/app/global_widgets/button.dart';
import 'package:the_brick_of_resilience/app/utils/responsive.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double opacity = 0.4;
    const iconSize = 150.0;
    return GetBuilder<HomeController>(
        builder: (_) => Scaffold(
              backgroundColor: const Color.fromARGB(255,131, 56, 236),
              body: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.homeTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Responsive.of(context).wp(8),
                            color: Colors.white,
                            fontWeight: FontWeight.bold,

                          )),
                      Obx(
                        () => _.globalController.isAbleToContinueQuestionnaire
                                .value
                            ? ButtonCard(
                                colors: [Colors.blue[700]!, Colors.blue[100]!],
                                shadowColor: Colors.blue[100]!.withOpacity(opacity),
                                text: AppLocalizations.of(context)!
                                    .continueQuestionnaireTitle,
                                iconTag: 'continue',
                                icon: const Icon(Icons.play_circle,
                                    size: iconSize, color: Colors.white),
                                onPressed: () => _.goToContinueQuestionnaire())
                            : ButtonCard(
                                colors: [Colors.grey[700]!, Colors.grey],
                                shadowColor: Colors.grey.withOpacity(opacity),
                                text: AppLocalizations.of(context)!
                                    .continueQuestionnaireTitle,
                                iconTag: 'continue',
                                icon: const Icon(Icons.play_circle_outline_sharp,
                                    size: iconSize, color: Colors.white),
                                onPressed: () {}),
                      ),
                      ButtonCard(
                        colors: [Colors.blue[700]!, Colors.blue[100]!],
                        shadowColor: Colors.blue[100]!.withOpacity(opacity),
                        text:
                            AppLocalizations.of(context)!.startQuestionnaireTitle,
                        iconTag: 'start',
                        icon: const Icon(Icons.new_label,
                            size: iconSize, color: Colors.white),
                        onPressed: () => _.goToNewQuestionnaire(),
                      ),
                      Obx(
                        () => _.globalController.isAbleToShowResults.value
                            ? ButtonCard(
                                colors: [Colors.blue[700]!, Colors.blue[100]!],
                                shadowColor: Colors.blue[100]!.withOpacity(opacity),
                                text: AppLocalizations.of(context)!
                                    .consultResultsTitle,
                                iconTag: 'results',
                                icon: const Icon(Icons.assessment,
                                    size: iconSize, color: Colors.white),
                                onPressed: () => _.goToResults(),
                              )
                            : ButtonCard(
                                colors: [Colors.grey[700]!, Colors.grey],
                                shadowColor: Colors.grey.withOpacity(opacity),
                                text: AppLocalizations.of(context)!
                                    .consultResultsTitle,
                                iconTag: 'results',
                                icon: const Icon(Icons.assessment,
                                    size: iconSize, color: Colors.white),
                                onPressed: () {}),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
