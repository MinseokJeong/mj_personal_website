import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mj_portfolio_web/model/project_information.dart';
import 'package:mj_portfolio_web/model/resume_info_manager.dart';
import 'package:mj_portfolio_web/model/work_experience.dart';
import 'package:mj_portfolio_web/util/text_highligher.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Text Highlight Parser Test', () {
    const testText =
        '대학생 시절 해외 인턴십 프로그램에 선발되어 미국 LA에 있는 회사에서 <Android> 개발자로서 인턴생활을 하였으며, 캐나다 Vancouver에 있는 회사에서 재택근무를 하며 Windows 개발자로 일을 하였고, 스타트업 회사를 공동창업하며 Android/iOS 개발자로 일을 하였고, 방위산업체에서 근무하며 Embedded System/Windows 개발자로 일을 한 경험이 있습니다.';
    final highlighter = TextHighlighter(testText);
    final highlightTextModels = highlighter.getTexthighlightModel();
    expect(highlightTextModels.length, 3);
    expect(highlightTextModels[0].highlight, false);
    expect(highlightTextModels[0].text,
        '대학생 시절 해외 인턴십 프로그램에 선발되어 미국 LA에 있는 회사에서 ');

    expect(highlightTextModels[1].highlight, true);
    expect(highlightTextModels[1].text, 'Android');

    expect(highlightTextModels[2].highlight, false);
    expect(highlightTextModels[2].text,
        ' 개발자로서 인턴생활을 하였으며, 캐나다 Vancouver에 있는 회사에서 재택근무를 하며 Windows 개발자로 일을 하였고, 스타트업 회사를 공동창업하며 Android/iOS 개발자로 일을 하였고, 방위산업체에서 근무하며 Embedded System/Windows 개발자로 일을 한 경험이 있습니다.');
  });

  test('Print Project Information', () async {
    final resumeInfoManger = ResumeInfoManager.getInstance();
    final resumeJson = await resumeInfoManger.getResumeJson();

    final workExperiencesJson = resumeJson['workExperiences'] as List<dynamic>;
    final sideProjectsJson = resumeJson['sideProjects'] as List<dynamic>;

    List<WorkExperience> workExperiences = [];
    for (var workExperienceJson in workExperiencesJson) {
      final workExperience = WorkExperience.fromJson(workExperienceJson);
      workExperiences.add(workExperience);
    }

    List<ProjectInformation> sideProjects = [];
    for (var sideprojectJson in sideProjectsJson) {
      final sideproject = ProjectInformation.fromJson(sideprojectJson);
      sideProjects.add(sideproject);
    }

    for (final workExperience in workExperiences) {
      final companyName = workExperience.company;
      for (final project in workExperience.projects) {
        _printProjectInfo(project, companyName);
      }
    }

    for (final project in sideProjects) {
      _printProjectInfo(project);
    }
  });
}

void _printProjectInfo(ProjectInformation project, [String subTitle = '']) {
  final stringBuffer = StringBuffer();
  stringBuffer.writeln(
      '${project.projectName}${subTitle.isNotEmpty ? ' / $subTitle' : ''}');

  if (project.projectPeriod.isNotEmpty) {
    stringBuffer.writeln(project.projectPeriod.replaceAll('~', '-'));
  }

  if (project.projectDescription.isNotEmpty) {
    stringBuffer.writeln('프로젝트 소개: ' + project.projectDescription);
  }

  if (project.members.isNotEmpty) {
    stringBuffer.writeln('프로젝트 소개: ' + project.members);
  }

  if (project.contributionrate.isNotEmpty) {
    stringBuffer.writeln('SW구현 기여도: ' + project.contributionrate);
  }

  if (project.keywords.isNotEmpty) {
    stringBuffer.writeln('기술스택: ' +
        project.keywords.reduce((value, element) => '$value, $element'));
  }

  if (project.workDetail.isNotEmpty) {
    stringBuffer.writeln('상세업무:');
    stringBuffer.writeln(
        project.workDetail.reduce((value, element) => '$value\n$element'));
  }

  if (project.results.isNotEmpty) {
    stringBuffer.writeln('성과:');
    stringBuffer.writeln(
        project.results.reduce((value, element) => '$value\n$element'));
  }

  if (project.links.isNotEmpty) {
    stringBuffer.writeln('참조:');
    for (var link in project.links) {
      stringBuffer.writeln('•${link.text}: ${link.url}');
    }
  }

  print(stringBuffer);
}
