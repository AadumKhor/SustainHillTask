import 'package:flutter/material.dart';
import 'package:task/models/dataModel.dart';
import 'package:task/repository/jsonRepo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        theme: ThemeData(
            primaryColor: Colors.white,
            accentColor: Colors.black,
            primaryColorLight: Color(0xffe4e6eb),
            textTheme: TextTheme(
                headline1: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400),
                headline2: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400),
                headline3: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600),
                headline4: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600))),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Scaffold(
      backgroundColor: _theme.primaryColor,
      appBar: AppBar(
        backgroundColor: _theme.primaryColor,
        title: Text(
          'JSONPlaceHolder Task',
          style: _theme.textTheme.headline3,
        ),
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: _theme.accentColor,
            ),
            onPressed: () {}),
      ),
      body: FutureBuilder<List<DataModel>>(
          future: makeGetRequest(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child: Text('There was some error loading the data!',
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: _theme.textTheme.headline4));
            }

            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  if (snapshot.data.length == 0) {
                    return Center(
                        child: Text('No data to show',
                            softWrap: true, style: _theme.textTheme.headline4));
                  }
                  return ExpansionTile(
                    initiallyExpanded: false,
                    backgroundColor: _theme.primaryColor,
                    leading: Container(
                      width: 40.0,
                      height: 40.0,
                      child: Center(
                        child: Text(
                          snapshot.data[index].postId,
                          style: _theme.textTheme.headline4
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index % 2 == 0
                              ? Colors.red.shade600
                              : Colors.blue.shade700),
                    ),
                    title: Text(
                      snapshot.data[index].title,
                      style: _theme.textTheme.headline2,
                    ),
                    children: <Widget>[
                      Text(
                        snapshot.data[index].body,
                        style: _theme.textTheme.headline1,
                      )
                    ],
                  );
                });
          }),
    );
  }
}
