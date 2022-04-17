import 'package:flutter/material.dart';

import '../../../consts/consts.dart';
import '../controllers/add_controller.dart';
import 'text_field.dart';

class FormStudent extends StatelessWidget {
  const FormStudent({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AddController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Textfield(
          textController: controller.nameC,
          label: Txt.name,
        ),
        Textfield(
          textController: controller.numberC,
          label: Txt.number,
        ),
        Textfield(
          textController: controller.genderC,
          label: Txt.genderLabel,
          isGender: true,
        ),
      ],
    );
  }
}
