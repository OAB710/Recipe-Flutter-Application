import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:recipr/utils/class.dart';
import 'package:recipr/utils/data.dart' as data;
import 'package:recipr/screens/details.dart';
import 'package:recipr/screens/login_resigster.dart';

class HomePage extends StatefulWidget {
  final Function(String languageCode) onChangeLanguage;

  HomePage({required this.onChangeLanguage});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  Set<String> favoriteRecipeIds = {}; // Chỉ lưu ID công thức yêu thích
  String _searchQuery = ''; // Search query

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleFavorite(Recipe recipe) {
    setState(() {
      if (favoriteRecipeIds.contains(recipe.id)) {
        favoriteRecipeIds.remove(recipe.id);
      } else {
        favoriteRecipeIds.add(recipe.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var recipes = data.Data.getRecipes(
      context,
    ); // luôn lấy công thức theo ngôn ngữ
    var filteredRecipes =
        recipes
            .where(
              (recipe) => recipe.title.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ),
            )
            .toList();

    Widget body;
    if (_selectedIndex == 0) {
      // Home page
      body = _buildRecipeGrid(filteredRecipes);
    } else {
      // Favorites page
      final favoriteList =
          filteredRecipes
              .where((r) => favoriteRecipeIds.contains(r.id))
              .toList();
      body =
          favoriteList.isEmpty
              ? Center(child: Text(AppLocalizations.of(context)!.no_favorites))
              : _buildRecipeGrid(favoriteList);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.recipes_title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: widget.onChangeLanguage,
            icon: Icon(Icons.language),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: 'en', child: Text('English')),
                PopupMenuItem(value: 'vi', child: Text('Tiếng Việt')),
                PopupMenuItem(value: 'fr', child: Text('Français')),
              ];
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => LoginRegisterPage(
                        onChangeLanguage: widget.onChangeLanguage,
                      ),
                ),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.search_hint,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ),
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppLocalizations.of(context)!.home_label,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: AppLocalizations.of(context)!.favorites_label,
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeGrid(List<Recipe> recipes) {
    return GridView.builder(
      itemCount: recipes.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        final recipe = recipes[index];
        final localizedCost = getLocalizedCost(context, recipe.cost);
        final formattedCost = NumberFormat.simpleCurrency(
          locale: Localizations.localeOf(context).toString(),
        ).format(localizedCost);

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(recipe: recipe),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                        child: Hero(
                          tag: recipe.id,
                          child: FadeInImage(
                            image: NetworkImage(recipe.imageUrl),
                            placeholder: AssetImage(
                              'assets/images/loading.gif',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        recipe.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      formattedCost,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      favoriteRecipeIds.contains(recipe.id)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color:
                          favoriteRecipeIds.contains(recipe.id)
                              ? Colors.red
                              : Colors.grey,
                    ),
                    onPressed: () => _toggleFavorite(recipe),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

double getLocalizedCost(BuildContext context, double baseCostVND) {
  String locale = Localizations.localeOf(context).languageCode;
  switch (locale) {
    case 'en':
      return baseCostVND / 23000;
    case 'fr':
      return baseCostVND / 25000;
    default:
      return baseCostVND;
  }
}
