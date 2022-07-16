import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_brick_of_resilience/app/global_widgets/button.dart';
import 'package:the_brick_of_resilience/app/modules/questionnaire/questionnaire_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:the_brick_of_resilience/app/utils/responsive.dart';

class QuestionnairePage extends GetView<QuestionnaireController> {
  const QuestionnairePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var buttonWidth = Responsive.of(context).wp(35);

    return GetBuilder<QuestionnaireController>(builder: (_) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 190, 11),
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(40),
            // padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: Responsive.of(context).hp(15),
                    child: Text(
                      areThereQuestionsLoaded(_) ? getQuestionText(_) : '',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: Responsive.of(context).wp(4),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                // five options
                answerOptionWidget(_,
                    option: 1,
                    text: AppLocalizations.of(context)!.firstOption,
                    context: context),
                answerOptionWidget(_,
                    option: 2,
                    text: AppLocalizations.of(context)!.secondOption,
                    context: context),
                answerOptionWidget(_,
                    option: 3,
                    text: AppLocalizations.of(context)!.thirdOption,
                    context: context),
                answerOptionWidget(_,
                    option: 4,
                    text: AppLocalizations.of(context)!.fourthOption,
                    context: context),
                answerOptionWidget(_,
                    option: 5,
                    text: AppLocalizations.of(context)!.fifthOption,
                    context: context),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    button(
                        context,
                        Colors.grey,
                        AppLocalizations.of(context)!.back,
                        buttonWidth,
                        () => isFirstQuestion(_) ? null : _.backQuestion()),
                    const SizedBox(width: 20),
                    isLastQuestion(_)
                        ? isQuestionAnswered(_)
                            ? button(
                                context,
                                Colors.red,
                                AppLocalizations.of(context)!.finish,
                                buttonWidth,
                                () => _.finishQuestionnaire())
                            : button(
                                context,
                                Colors.grey,
                                AppLocalizations.of(context)!.finish,
                                buttonWidth,
                                () {})
                        : isQuestionAnswered(_)
                            ? button(
                                context,
                                Colors.blue,
                                AppLocalizations.of(context)!.next,
                                buttonWidth,
                                () => _.nextQuestion())
                            : button(
                                context,
                                Colors.grey,
                                AppLocalizations.of(context)!.next,
                                buttonWidth,
                                () {})
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  bool isQuestionAnswered(QuestionnaireController _) => _.answer.value != 0;

  bool isLastQuestion(QuestionnaireController _) =>
      _.currentQuestion.value >
      _.globalController.questions.questions.length - 1;

  bool isFirstQuestion(QuestionnaireController _) =>
      _.currentQuestion.value == 1;

  String getQuestionText(QuestionnaireController _) =>
      _.currentQuestion.value.toString() +
      ". " +
      _.globalController.questions.questions[_.currentQuestion.value - 1].text;

  bool areThereQuestionsLoaded(QuestionnaireController _) =>
      _.globalController.questions.questions.length > 1;

  Card answerOptionWidget(QuestionnaireController _,
      {required int option,
      required String text,
      required BuildContext context}) {
    var row = Card(
        margin: EdgeInsets.symmetric(
            horizontal: Responsive.of(context).hp(3), vertical: 1),
        color: Colors.white,
        child: Row(
          children: [
            Checkbox(
              focusColor: Colors.white,
              value: _.answer.value == option,
              onChanged: (value) {
                _.setAnswer(option);
              },
            ),
            Text(text,
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 190, 11),
                )),
          ],
        ));
    return row;
  }
}
