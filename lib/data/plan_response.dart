class AllUserPlansData {
  AllUserPlansData({
    required this.date,
    required this.plans,
  });

  final String? date;
  final List<Plan> plans;

  factory AllUserPlansData.fromJson(Map<String, dynamic> json) {
    return AllUserPlansData(
      date: json["date"] ?? "",
      plans: json["plans"] == null
          ? []
          : List<Plan>.from(json["plans"]!.map((x) => Plan.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "date": date,
        "plans": plans.map((x) => x.toJson()).toList(),
      };
}

class Plan {
  Plan({
    required this.id,
    required this.title,
    required this.level,
    required this.date,
    required this.time,
    required this.room,
    required this.trainer,
    required this.createdAt,
  });

  final int id;
  final String title;
  final String level;
  final String? date;
  final String time;
  final String room;
  final String trainer;
  final String? createdAt;

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      level: json["level"] ?? "",
      date: json["date"] ?? "",
      time: json["time"] ?? "",
      room: json["room"] ?? "",
      trainer: json["trainer"] ?? "",
      createdAt: json["created_at"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "level": level,
        "date": date,
        "time": time,
        "room": room,
        "trainer": trainer,
        "created_at": createdAt,
      };
}

class AddUpdatePlanPayload {
  AddUpdatePlanPayload({
    required this.date,
    required this.plans,
  });

  final String? date;
  final List<PlanUpdatePayload> plans;

  factory AddUpdatePlanPayload.fromJson(Map<String, dynamic> json) {
    return AddUpdatePlanPayload(
      date: json["date"] ?? "",
      plans: json["plans"] == null
          ? []
          : List<PlanUpdatePayload>.from(
              json["plans"]!.map((x) => Plan.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "date": date,
        "plans": plans.map((x) => x.toJson()).toList(),
      };
}

class PlanUpdatePayload {
  PlanUpdatePayload({
    required this.title,
    required this.level,
    required this.time,
    required this.room,
    required this.trainer,
  });

  final String title;
  final String level;
  final String time;
  final String room;
  final String trainer;

  factory PlanUpdatePayload.fromJson(Map<String, dynamic> json) {
    return PlanUpdatePayload(
      title: json["title"] ?? "",
      level: json["level"] ?? "",
      time: json["time"] ?? "",
      room: json["room"] ?? "",
      trainer: json["trainer"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "level": level,
        "time": time,
        "room": room,
        "trainer": trainer,
      };
}
