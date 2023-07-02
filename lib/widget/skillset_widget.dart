import 'package:flutter/material.dart';

class SkillSetWidget extends StatefulWidget {
  SkillSetWidget({super.key, required this.skills});
  List<String> skills;

  @override
  State<SkillSetWidget> createState() => _SkillSetWidgetState();
}

class _SkillSetWidgetState extends State<SkillSetWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
