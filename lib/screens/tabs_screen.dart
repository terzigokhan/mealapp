import 'package:flutter/material.dart';
import '../models/meal.dart';
import './favorities_screen.dart';
import './categories_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreenW extends StatefulWidget {
  List<Meal> favoriteMeals;

  TabsScreenW(this.favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreenW> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    
    _pages = [
      {
        'page': CategoriesScreenW(),
        'title': 'Categories',
      },
      {
        'page': FavoritiesScreenW(widget.favoriteMeals),
        'title': 'Your Favoritie',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: MainDrawerW(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,

        //type: BottomNavigationBarType.fixed,//default value
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text('Favorities'),
          ),
        ],
      ),
    );

    /* DefaultTabController( //Bottom TabBar controller simple code
      length: 2,
      initialIndex: 0,//its controller fır first tab
      child: Scaffold(
        appBar: AppBar(
          title: Text('mojimi.'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.category,
                ),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(
                  Icons.star,
                ),
                text: 'Favorities',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            CategoriesScreenW(),
            FavoritiesScreenW(),
          ],
        ),
      ),
    ); */
  }
}
