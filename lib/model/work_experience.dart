import 'package:mj_portfolio_web/model/project_information.dart';

class WorkExperience {
  final String companyName;
  final String location;
  final String rank;
  final String mainRole;
  final String workPeriod;
  final String companyWebsite;
  final String aboutCompany;
  final List<ProjectInformation> projects;

  WorkExperience({
    required this.companyName,
    required this.location,
    required this.rank,
    required this.mainRole,
    required this.workPeriod,
    required this.projects,
    required this.companyWebsite,
    required this.aboutCompany,
  });

  factory WorkExperience.fromJson(Map<String, dynamic> json) {
    final companyName = json['company'] as String;
    final location = json['location'] as String;
    final workPeriod = json['lengthOfService'] as String;
    final companyWebsite = json['website'] as String;
    final rank = json['rank'] as String;
    final mainRole = json['mainRole'] as String;
    final aboutCompany = json['aboutCompany'] as String;

    final projects = <ProjectInformation>[];
    final jsonProjects = json['projects'] as List<dynamic>;
    for (var jsonProject in jsonProjects) {
      projects.add(
          ProjectInformation.fromJson(jsonProject as Map<String, dynamic>));
    }

    return WorkExperience(
      companyName: companyName,
      location: location,
      rank: rank,
      mainRole: mainRole,
      workPeriod: workPeriod,
      companyWebsite: companyWebsite,
      projects: projects,
      aboutCompany: aboutCompany,
    );
  }
}
