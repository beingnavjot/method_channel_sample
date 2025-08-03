import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoButton(
              color: Colors.deepPurple,
              child: Text("Invoke Native Method channel to show toast",style: TextStyle(color: Colors.white)),
              onPressed: () async {
                var _channel = MethodChannel('com.example.method_channel_sample');
                try {
                  await _channel.invokeMethod('showToast', {'message': "Sample toast message", 'duration': 'short'});
                } on PlatformException catch (e) {
                  print("Failed to show toast: '${e.message}'.");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
