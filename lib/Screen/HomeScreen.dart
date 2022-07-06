import 'package:flutter/material.dart';
import 'package:hallmarkcardgenerator/Screen/FormScreen.dart';
import 'package:hallmarkcardgenerator/Screen/DatabaseScreen.dart';
import 'package:path_provider/path_provider.dart';
class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('');
    return Scaffold(
      body: Center(
        child: Column(

          children: <Widget>[
            Expanded(
              child: Container(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, FormScreen.routeName);
                  },
                  child: Text('Create New Card'),
                ),
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),

              ),
            ),
            Expanded(
              child: Container(

                child: ElevatedButton(

                  onPressed: () {
                    Navigator.pushNamed(context, DatabaseScreen.routeName);
                  },
                  child: Text('Database '),
                ),
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
    );
  }
}
