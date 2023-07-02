import 'dart:convert';

import 'package:flutter/services.dart';

class ResumeInfoManager {
  static ResumeInfoManager? _instance;
  Map<String, dynamic>? _resumeJson;
  bool _resumeLoaded = false;

  ResumeInfoManager._();

  factory ResumeInfoManager.getInstance() {
    _instance ??= ResumeInfoManager._();
    return _instance!;
  }

  Future<Map<String, dynamic>> getResumeJson() async {
    await _loadResumeInfo();

    return _resumeJson!;
  }

  Future<void> _loadResumeInfo() async {
    if (_resumeLoaded) {
      return;
    }

    final resumeJsonString =
        await rootBundle.loadString('assets/resume_info.json', cache: false);
    _resumeJson = jsonDecode(resumeJsonString) as Map<String, dynamic>;
    _resumeLoaded = true;
  }
}
