import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

// final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(title),
        backgroundColor: Colors.green,
      ),
      body: const snackBarDemo(),
    );
  }
}

// ignore: camel_case_types
class snackBarDemo extends StatelessWidget {
  const snackBarDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green)),
        onPressed: () {
          const snackdemo = SnackBar(
            content: Text('Hii this is GFG\'s SnackBar'),
            backgroundColor: Colors.green,
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(5),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackdemo);

          // 'showSnackBar' is deprecated and shouldn't be used.
          //Use ScaffoldMessenger.showSnackBar.
          // Scaffold.of(context).showSnackBar(snackdemo);
        },
        child: const Text('Click Here'),
      ),

      // RaisedButton is deprecated and shouldn't be used.

      // child: RaisedButton(
      //	 child: const Text('Click Here!'),
      //	 color: Colors.green,
      //	 onPressed: () {
      //	 const snackdemo = SnackBar(
      //		 content: Text('Hii this is GFG\'s SnackBar'),
      //		 backgroundColor: Colors.green,
      //		 elevation: 10,
      //		 behavior: SnackBarBehavior.floating,
      //		 margin: EdgeInsets.all(5),
      //	 );
      //	 Scaffold.of(context).showSnackBar(snackdemo);
      //	 }),
    );
  }
}
