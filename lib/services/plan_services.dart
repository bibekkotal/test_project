import 'package:test_project/data/plan_response.dart';

import '../repositories/plan_repositories.dart';
import '../utils/api_request.dart';
import '../utils/colorful_log.dart';
import '../utils/strings.dart';

class PlanServices extends PlanRepositories {
  @override
  Future<ApiResult> addUpdatePlans({
    required String date,
    required AddUpdatePlanPayload planDataPayload,
  }) async {
    dynamic queryParameter = {'date': date};
    dynamic body = planDataPayload.toJson();
    ColorLog.devLog(body);

    return await ApiRequest().request(
      headers: {
        "Content-Type": "application/json",
      },
      method: ApiMethods.post,
      endpoint: API.plan,
      queryParameters: queryParameter,
      body: body,
    );
  }

  @override
  Future<ApiResult> getAllPlanByDate({required String date}) async {
    dynamic queryParameter = {'date': date};
    return await ApiRequest().request(
      headers: {
        "Content-Type": "application/json",
      },
      method: ApiMethods.get,
      endpoint: API.plan,
      queryParameters: queryParameter,
    );
  }
}
