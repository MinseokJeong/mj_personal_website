class ProjectInformation {
  final String projectName;
  final String projectDescription;
  final String projectPeriod;
  final List<String> keywords;
  final List<String> category;
  final String members;
  final String contributionrate;
  final List<String> workDetail;
  final List<String> results;
  final List<({String url, String text})> links;

  ProjectInformation(
      {required this.projectName,
      required this.projectDescription,
      required this.projectPeriod,
      required this.members,
      required this.contributionrate,
      required this.workDetail,
      required this.keywords,
      required this.links,
      required this.results,
      required this.category});

  factory ProjectInformation.fromJson(Map<String, dynamic> json) {
    final urls = <({String url, String text})>[];

    for (final Map<String, dynamic> link in json['links'] as List<dynamic>) {
      final text = link['text'] as String;
      final url = link['url'] as String;
      urls.add((text: text, url: url));
    }

    return ProjectInformation(
      projectName: json['projectName'] as String,
      projectDescription: json['projectDescription'] as String,
      projectPeriod: json['period'] as String,
      keywords: List<String>.from(json['keywords']),
      category: List<String>.from(json['category']),
      members: json['members'] as String,
      contributionrate: json['contribution'] as String,
      workDetail: List<String>.from(json['workDetail']),
      results: List<String>.from(json['results']),
      links: urls,
    );
  }
}
