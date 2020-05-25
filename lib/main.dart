import 'package:flutter/material.dart';
import './dummy_categories.dart';
import './models/meal.dart';
import './screens/filtered_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _avaibleMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((element) => element.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(
        () {
          _favoriteMeals.add(
            DUMMY_MEALS.firstWhere((element) => element.id == mealId),
          );
        },
      );
    }
  }
  
   bool _isMealFavorite(String id)
   {
     return _favoriteMeals.any((element) => element.id==id);
   }

  void _setFilters(Map<String, bool> filteredData) {
    setState(() {
      _filters = filteredData;
      _avaibleMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.yellow,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      initialRoute:
          '/', // it's default value '/' but you can change it with this line
      routes: {
        '/': (ctx) => TabsScreenW(_favoriteMeals),
        CategoryMealsScreen.roughName: (ctx) =>
            CategoryMealsScreen(_avaibleMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite,_isMealFavorite),
        FilteredScreen.routeName: (ctx) =>
            FilteredScreen(_filters, _setFilters),
      },
      /*  onGenerateRoute: (settings) { //it's usefull for dynamic ap which screen change in app life
        print(settings.arguments);
        if (settings.name == '/meal-detail') {
          return null;
        }
        return MaterialPageRoute(builder: (ctx) => CategoriesScreenW());
      }, */
      onUnknownRoute: (settings) {
        // it's start when Flutter get file to start screens on routes the last escape before crush for somewhing on screen
        return MaterialPageRoute(builder: (ctx) => CategoriesScreenW());
      },
    );
  }
}
