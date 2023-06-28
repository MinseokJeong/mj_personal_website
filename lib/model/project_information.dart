class ProjectInformation {
  ProjectInformation({
    required this.projectName,
    required this.projectDescription,
    this.projectPeriod,
    this.projectMembers,
    this.contributionrate,
    this.detailedWorks,
    this.tags,
    this.urls,
  });
  final String projectName;
  final String projectDescription;
  final String? projectPeriod;
  final String? projectMembers;
  final String? contributionrate;
  final List<String>? detailedWorks;
  final List<String>? tags;
  final List<({String url, String text})>? urls;
}
