library cab_sharing;

import 'package:flutter/material.dart';

class AWidget extends StatelessWidget {
  const AWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Page 1')),
      floatingActionButton: ElevatedButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WidgetTwo()));
        },
        child: Text('Here'),
      ),
    );
  }
}

class WidgetTwo extends StatelessWidget {
  const WidgetTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Page 2')),
      floatingActionButton: ElevatedButton(
        onPressed: (){
          Navigator.of(context).pop();
        },
        child: Text('Here 2'),
      ),
    );
  }
}

