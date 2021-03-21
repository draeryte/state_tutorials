import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:smtutorial/redux/redux_screen.dart';
import 'package:redux/redux.dart';
import 'models/drink.dart';

import 'redux/app_state.dart';

import 'redux/reducer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Store<AppState> _store = Store<AppState>(updateDrinksReducer,
      initialState: AppState(drinks: [
        Drink("Water", false),
        Drink("Cuba Libre", false),
        Drink("Pina Colada", false),
        Drink("Havana Cola", false)
      ]));
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: _store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Redux solution - Flutter Explained',
        theme: ThemeData.light().copyWith(primaryColor: Color(0xFFe13133)),
        home: ReduxScreen(),
      ),
    );
  }
}
