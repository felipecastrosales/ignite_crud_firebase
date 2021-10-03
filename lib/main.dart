import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'core/app_widget.dart';

void main() {
  runApp(
    const FirebaseConfigurationWidget(),
  );
}

class FirebaseConfigurationWidget extends StatelessWidget {
  const FirebaseConfigurationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const AppWidget();
        }
        if (snapshot.hasError) {
          return Material(
            child: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }
        return const Material(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
