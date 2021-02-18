import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Sobre a App"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                  child: Text(
                """   
    Tempo nos Açores é uma simples app que
mostra o estado de tempo atual em alguns locais
do arquipélago dos Açores. 
    
    Foi desenvolvida com o intuito de aprender
mais sobre desenvolvimento de aplicações
móveis e, ao mesmo tempo, providenciar 
algumas informações úteis aos utilizadores da
app.

    Sobre mim: chamo-me Gonçalo, tenho 21 anos
e neste momento estou a meio do meu mestrado
em Engenharia Informática no Instituto Superior
Técnico. Sou açoriano e sou fanático pela beleza
das nossas ilhas.

  Contacto: goncalo.h.almeida@gmail.com
  Todo o código da app está disponível no meu
  github: xaleza
""",
                style: TextStyle(fontSize: 16),
              )),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Center(
                  child: Text(
                "Made by Gonçalo Almeida @ 2021",
                style: TextStyle(fontSize: 16),
              )),
            )
          ],
        ));
  }
}
