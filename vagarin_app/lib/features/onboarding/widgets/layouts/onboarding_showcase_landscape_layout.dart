import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class OnboardingShowcaseLandscapeLayout extends StatelessWidget {
  const OnboardingShowcaseLandscapeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              SizedBox(width: 164, height: 164, child: Placeholder()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "DVagarin",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Text(
                    "Uma rede, de fato, social.",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              MarkdownBody(
                data:
                    """No ritmo frenético das redes sociais de hoje, onde o scroll é infinito e o ruído digital constante, o **DVagarin** surge como um refúgio. Cansado de algoritmos, anúncios invasivos e da pressão por conteúdo viral? Nós também.

DVagarin é a sua pausa diária para o que realmente importa: **conexões genuínas com as pessoas que fazem parte da sua vida**.""",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
