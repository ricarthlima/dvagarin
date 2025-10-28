import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class OnboardingShowcasePortraitLayout extends StatelessWidget {
  const OnboardingShowcasePortraitLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16,
        children: [
          SizedBox(width: 128, height: 128, child: Placeholder()),
          Column(
            children: [
              Text(
                "DVagarin",
                style: Theme.of(
                  context,
                ).textTheme.displayLarge!.copyWith(fontSize: 32),
              ),
              Text(
                "Uma rede, de fato, social.",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          MarkdownBody(
            data:
                """No ritmo frenético das redes sociais de hoje, onde o scroll é infinito e o ruído digital constante, o **DVagarin** surge como um refúgio. Cansado de algoritmos, anúncios invasivos e da pressão por conteúdo viral? Nós também.

DVagarin é a sua pausa diária para o que realmente importa: **conexões genuínas com as pessoas que fazem parte da sua vida**.""",
          ),
        ],
      ),
    );
  }
}
