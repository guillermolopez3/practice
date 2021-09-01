import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///en este ejemplo el fab se expande y se contrae al hacer scroll
class AnimationFab extends StatefulWidget {
  const AnimationFab({Key? key}) : super(key: key);

  @override
  _AnimationFabState createState() => _AnimationFabState();
}

class _AnimationFabState extends State<AnimationFab> {
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

class _MyFab extends StatelessWidget {
  final _duration = Duration(milliseconds: 250);
  final _minSize = 50.0;
  final _maxSize = 150.0;
  final _iconSize = 24.0;
  final bool expanded;
  final VoidCallback onTap;

  _MyFab({Key? key, this.expanded = false, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final position = _minSize / 2 - _iconSize / 2;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: _duration,
        width: expanded ? _maxSize : _minSize,
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
                'Start chat',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
