import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:smtutorial/models/drink.dart';
import 'package:smtutorial/widgets/drinks_widget.dart';

import '../constants.dart';
import '../models/drink.dart';
import 'actions.dart';
import 'app_state.dart';

// Widget
class ReduxScreen extends StatelessWidget {
  final List<Drink> drinks = [
    Drink("Water", false),
    Drink("Cuba Libre", false),
    Drink("Pina Colada", false),
    Drink("Havana Cola", false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cocktail Order"),
      ),
      body: Container(
        decoration: kMainBackgroundImage,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: kWhiteBackground,
              // TODO 10: Surround the column with a StoreConnector
              // TODO 10.1: convert the state in a List of Drinks
              child: StoreConnector<AppState, List<Drink>>(
                converter: (store) => store.state.drinks,
                builder: (context, List<Drink> stateDrinks) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Drinks tonight",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    ...stateDrinks
                        .map(
                          (drink) => DrinksWidget(
                            drink: drink,
                            onChanged: (value) {
                              // TODO 11: Use the StoreProvider.of to dispatch the UpdateDrinkAction
                              drink.selected = !drink.selected;
                              StoreProvider.of<AppState>(context)
                                  .dispatch(UpdateDrinkAction(drink));
                            },
                          ),
                        )
                        .toList(),
                    Text(
                      "The order is: ",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => ListTile(
                          title: Text(
                            // TODO 12: replace with the state drinks and remove the drinks list from the widget
                            stateDrinks
                                .where((element) => element.selected)
                                .toList()[index]
                                .name,
                          ),
                        ),
                        itemCount: stateDrinks
                            .where((element) => element.selected)
                            .length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
