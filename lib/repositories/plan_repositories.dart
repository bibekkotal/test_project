import '../data/plan_response.dart';
import '../utils/api_request.dart';

abstract class PlanRepositories {
  Future<ApiResult> getAllPlanByDate({
    required String date,
  });
  Future<ApiResult> addUpdatePlans({
    required String date,
    required AddUpdatePlanPayload planDataPayload,
  });
}
