import 'package:cron/home/sections/core/home_section.dart';
import 'package:cron/shared/presentation/base_card.dart';
import 'package:flutter/material.dart';

class NextTasksSection extends StatelessWidget {
  const NextTasksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeSection(
      mustRender: true,
      title: '⏰ Próximos',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BaseCardContent(
            title: 'Definir gerenciamento de estados',
            subtitle: '09h00 - 09h30',
            color: Color.fromARGB(255, 0, 58, 72),
          ),
          SizedBox(height: 4),
          BaseCardContent(
            title: 'Criar estrutura de notas',
            subtitle: '09h30 - 10h00',
            color: Color.fromARGB(255, 18, 72, 0),
          ),
        ],
      ),
    );
  }
}
