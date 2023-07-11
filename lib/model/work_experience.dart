import 'package:mj_portfolio_web/model/project_information.dart';

class WorkExperience {
  final String company;
  final String companyFullName;
  final String website;
  final String lengthOfService;
  final String location;
  final String rank;
  final String developmentCategory;
  final String companyCategory;
  final String aboutCompany;
  final String myRoleInCompany;

  final List<ProjectInformation> projects;

  WorkExperience({
    required this.company,
    required this.companyFullName,
    required this.website,
    required this.lengthOfService,
    required this.location,
    required this.rank,
    required this.developmentCategory,
    required this.companyCategory,
    required this.aboutCompany,
    required this.myRoleInCompany,
    required this.projects,
  });

  factory WorkExperience.fromJson(Map<String, dynamic> json) {
    final projects = <ProjectInformation>[];
    final jsonProjects = json['projects'] as List<dynamic>;
    for (var jsonProject in jsonProjects) {
      projects.add(
          ProjectInformation.fromJson(jsonProject as Map<String, dynamic>));
    }

    return WorkExperience(
      company: json['company'] as String,
      companyFullName: json['companyFullName'] as String,
      website: json['website'] as String,
      lengthOfService: json['lengthOfService'] as String,
      location: json['location'] as String,
      rank: json['rank'] as String,
      developmentCategory: json['developmentCategory'] as String,
      companyCategory: json['companyCategory'] as String,
      aboutCompany: json['aboutCompany'] as String,
      myRoleInCompany: json['myRoleInCompany'] as String,
      projects: projects,
    );
  }
}
