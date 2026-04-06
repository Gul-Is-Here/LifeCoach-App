// LAYER: Services (Layer 3)
// PURPOSE: Single entry point for ALL Firebase Cloud Function calls.
//          The Claude API key lives only in the Cloud Function — never here.
// USED BY: AiCoachController (aiCoach), GoalController (suggestMilestones)

import 'package:cloud_functions/cloud_functions.dart';

class CloudFunctionsService {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  // ─── AI Coach ────────────────────────────────────────────────────────────
  // Calls the 'aiCoach' Cloud Function with the user's message and context.
  // context shape: { chatHistory, healthSummary, habitSummary, financeSummary, goalsSummary }
  Future<String> callAiCoach({
    required String message,
    required Map<String, dynamic> context,
  }) async {
    final result = await _functions.httpsCallable('aiCoach').call({
      'message': message,
      'context': context,
    });
    return result.data['response'] as String;
  }

  // ─── Milestone Suggestions ───────────────────────────────────────────────
  // Returns List<String> of 5 AI-generated milestone suggestions for a goal.
  Future<List<String>> suggestMilestones({
    required String goalTitle,
    required String targetDate,
  }) async {
    final result = await _functions.httpsCallable('suggestMilestones').call({
      'goalTitle': goalTitle,
      'targetDate': targetDate,
    });
    return List<String>.from(result.data['milestones'] as List);
  }
}
