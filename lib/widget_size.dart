import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///en este ejemplo el fab se expande y se contrae al hacer scroll
///pero calculo de antemano el tamaño del widget, esto es por ejemplo si el texto del FAB es muy largo
///el contenedor del fab se expanda y entre el nuevo texto
class WidgetSize extends StatefulWidget {
  const WidgetSize({Key? key}) : super(key: key);

  @override
  _WidgetSizeState createState() => _WidgetSizeState();
}

//mismo ejemplo que animation_fab
class _WidgetSizeState extends State<WidgetSize> {
  bool expanded = false;
  final _controller = ScrollController();

  _onScrollDirection(){
    if(_controller.position.userScrollDirection == ScrollDirection.reverse && expanded){
      setState(() {
        expanded = false;
      });
    }else if(_controller.position.userScrollDirection == ScrollDirection.forward && !expanded){
      setState(() {
        expanded=true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Animation FAB'),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (notification){
            _onScrollDirection();
            return true;
          },
          child: ListView.builder(
            controller: _controller,
            itemCount: 50,
            itemBuilder: (context, idx) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Colors.primaries[idx % Colors.primaries.length],
                  child: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                ),
                title: Text('Index $idx'),
                subtitle: Text('Probando animaciones'),
                trailing: Text('30 min'),
              );
            },
          ),
        ),
        floatingActionButton: _MyFab(
          onTap: () {},
          expanded: expanded,
        ));
  }
}

const _duration = Duration(milliseconds: 250);
const _minSize = 50.0;
const _iconSize = 24.0;

//modifico esta parte
class _MyFab extends StatefulWidget {
  final bool expanded;
  final VoidCallback onTap;

  _MyFab({Key? key, this.expanded = false, required this.onTap})
      : super(key: key);

  @override
  __MyFabState createState() => __MyFabState();
}

class __MyFabState extends State<_MyFab> {
  double _maxSize = 150.0;
  final _keyText = GlobalKey(); //key para el texto

  @override
  void initState() {
    //uso esto ya que me devuelve un callback luego de que los widgets fueron renderizados
    //y poder obtener sus medidas
    WidgetsBinding.instance!.addPostFrameCallback((_) { 
      //obtengo el ancho del texto y seteo la variable _maxSize
      setState(() {
        final ancho = _keyText.currentContext!.size!.width; //ancho del texto
        _maxSize = ancho + _minSize + _iconSize /2; //para calcular el ancho total
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final position = _minSize / 2 - _iconSize / 2;
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: _duration,
        width: widget.expanded ? _maxSize : _minSize,
        height: _minSize,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_minSize),
            color: Colors.blue[800]),
        child: Stack(
          children: [
            Positioned(
              top: position,
              left: position,
              child: Icon(
                Icons.message,
                color: Colors.white,
              ),
            ),
            Positioned(
              top: position,
              left: position + 1.5 * _iconSize,
              child: Text(
                'Start chat con amigos',
                key: _keyText, //le seteo la key
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
