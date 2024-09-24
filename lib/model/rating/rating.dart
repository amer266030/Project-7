class Rating {
  int idea;
  int design;
  int tools;
  int practices;
  int presentation;
  int investment;
  String note;

  Rating({
    required this.idea,
    required this.design,
    required this.tools,
    required this.practices,
    required this.presentation,
    required this.investment,
    required this.note,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        idea: json["idea"],
        design: json["design"],
        tools: json["tools"],
        practices: json["practices"],
        presentation: json["presentation"],
        investment: json["investment"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "idea": idea,
        "design": design,
        "tools": tools,
        "practices": practices,
        "presentation": presentation,
        "investment": investment,
        "note": note,
      };
}
