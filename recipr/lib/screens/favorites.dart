import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recipr/screens/details.dart';
import 'package:recipr/utils/data.dart';

class FavoritesPage extends StatefulWidget {
  final Set<String> favoriteRecipeIds;

  FavoritesPage({required this.favoriteRecipeIds});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String _searchQuery = ''; // Search query

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final recipes = Data.getRecipes(context);
    final favoriteRecipes =
        recipes
            .where((recipe) => widget.favoriteRecipeIds.contains(recipe.id))
            .where(
              (recipe) => recipe.title.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ),
            )
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations!.favorites_label),
        centerTitle: true,
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
                hintText: localizations.search_hint,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ),
      ),
      body:
          favoriteRecipes.isEmpty
              ? Center(
                child: Text(
                  localizations.no_favorites,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              )
              : ListView.builder(
                itemCount: favoriteRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = favoriteRecipes[index];
                  return ListTile(
                    leading: Image.network(
                      recipe.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(recipe.title),
                    subtitle: Text('ID: ${recipe.id}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(recipe: recipe),
                        ),
                      );
                    },
                  );
                },
              ),
    );
  }
}
