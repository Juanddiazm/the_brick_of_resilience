import 'dart:convert';

class Questionnaire {
  Questionnaire({
    required this.answers,
    required this.results,
  });

  List<Answer> answers;
  List<Result> results;

  factory Questionnaire.fromRawJson(String str) =>
      Questionnaire.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Questionnaire.fromJson(Map<String, dynamic> json) => Questionnaire(
        answers:
            List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Answer {
  Answer({
    required this.id,
    required this.answer,
  });

  int id;
  int answer;

  factory Answer.fromRawJson(String str) => Answer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json["id"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "answer": answer,
      };
}

class Result {
  Result({
    required this.itemName,
    required this.score,
    required this.description,
  });

  String itemName;
  int? score;
  String description;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        itemName: json["itemName"],
        score: json["score"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "itemName": itemName,
        "score": score,
        "description": description,
      };
}
