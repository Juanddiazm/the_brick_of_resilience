// To parse this JSON data, do
//
//     final questions = questionsFromJson(jsonString);

import 'dart:convert';

class Questions {
  Questions({
    required this.questions,
  });

  List<Question> questions;

  factory Questions.fromRawJson(String str) =>
      Questions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Questions.fromJson(Map<String, dynamic> json) => Questions(
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  Question({
    required this.id,
    required this.text,
    required this.type,
  });

  int id;
  String text;
  String type;

  factory Question.fromRawJson(String str) =>
      Question.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        text: json["text"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "type": type,
      };
}
