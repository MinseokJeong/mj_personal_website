class ProjectInformation {
  final String projectName;
  final String projectDescription;
  final String projectPeriod;
  final String projectMembers;
  final String contributionrate;
  final List<String> detailedWorks;
  final List<String> tags;
  final List<({String url, String text})> urls;
  final List<String> results;

  ProjectInformation(
      {required this.projectName,
      required this.projectDescription,
      required this.projectPeriod,
      required this.projectMembers,
      required this.contributionrate,
      required this.detailedWorks,
      required this.tags,
      required this.urls,
      required this.results});

  factory ProjectInformation.fromJson(Map<String, dynamic> json) {
    final projectName = json['projectName'] as String;
    final projectDescription = json['projectDescription'] as String;
    final period = json['period'] as String;
    final keywords = List<String>.from(json['keywords']);
    final workDetail = List<String>.from(json['workDetail']);
    final members = json['members'] as String;
    final contribution = json['contribution'] as String;
    final results = List<String>.from(json['results']);
    final urls = <({String url, String text})>[];

    for (final Map<String, dynamic> link in json['links'] as List<dynamic>) {
      final text = link['text'] as String;
      final url = link['url'] as String;
      urls.add((text: text, url: url));
    }

    return ProjectInformation(
        projectName: projectName,
        projectDescription: projectDescription,
        projectPeriod: period,
        projectMembers: members,
        contributionrate: contribution,
        detailedWorks: workDetail,
        tags: keywords,
        urls: urls,
        results: results);
  }
}
