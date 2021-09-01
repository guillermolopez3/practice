import 'package:flutter/material.dart';
import 'package:practica_flutter/animation_fab.dart';
import 'package:practica_flutter/widget_size.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('indice'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              title: Text('Botton animation'),
              subtitle: Text('animación del FAB como gmail'),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AnimationFab())),
            ),
            Divider(),
            ListTile(
              title: Text('Tamaño de un widget'),
              subtitle: Text('calculo el tamaño del widget para que se adapte al contenido'),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => WidgetSize())),
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
