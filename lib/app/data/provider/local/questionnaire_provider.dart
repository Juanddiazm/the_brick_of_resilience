import 'dart:convert';

import 'package:get/get.dart';
import 'package:the_brick_of_resilience/app/data/model/questionnaire.dart';
import 'package:the_brick_of_resilience/app/data/provider/local/sql_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class QuestionnaireProvider {
  final SQLHelper _sqlHelper = Get.find<SQLHelper>();

  QuestionnaireProvider();

  // Create new questionnaire (questionnaire)
  Future<int> createQuestionnaire(Questionnaire questionnaire) async {
    final db = await _sqlHelper.db();

    final String dataAsJson = json.encode(questionnaire);

    final data = {'questionnaire': dataAsJson};
    final id = await db.insert('questionnaires', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all questionnaires (questionnaires)
  Future<List<Map<String, dynamic>>> getQuestionnaires() async {
    final db = await _sqlHelper.db();
    return db.query('questionnaires', orderBy: "id");
  }

  // Read questionnaire 
  Future<List<Map<String, dynamic>>> getQuestionnaire() async {
    final db = await _sqlHelper.db();
    return db.query('questionnaires', limit: 1);
  }

  // isQuestionnaireSaved
  Future<bool> isQuestionnaireSaved() async {
    final db = await _sqlHelper.db();
    final queryResult = await  db.query('questionnaires');
    if (queryResult.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  // Update an questionnaire by id
  Future<int> updateQuestionnaire(int id, Questionnaire questionnaire) async {
    final db = await _sqlHelper.db();

    final String dataAsJson = json.encode(questionnaire);
    final data = {
      'questionnaire': dataAsJson,
      'createdAt': DateTime.now().toString()
    };

    final result = await db
        .update('questionnaires', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  Future<void> deleteQuestionnaire() async {
    final db = await _sqlHelper.db();
    try {
      await db.delete("questionnaires");
    } catch (err) {
      debugPrint("Something went wrong when deleting an questionnaire: $err");
    }
  }
}
