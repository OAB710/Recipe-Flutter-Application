import 'package:flutter/material.dart';
import 'package:recipr/utils/class.dart';
import 'package:recipr/utils/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:recipr/utils/data.dart'
    as data; // 💡 dùng alias tránh lỗi trùng tên

    

class DetailsPage extends StatefulWidget {
  final Recipe recipe;

  DetailsPage({required this.recipe});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  double _currentRating = 0.0;

  @override
  void initState() {
    super.initState();
    _currentRating = data.Data.ratings[widget.recipe.id] ?? 0.0;
  }

  void _saveRating(double rating) {
    setState(() {
      _currentRating = rating;
      data.Data.ratings[widget.recipe.id] = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final dateFormat = DateFormat.yMMMMd(locale);


    final localizedCost = getLocalizedCost(context, widget.recipe.cost);
    final formattedCost = NumberFormat.simpleCurrency(
      locale: locale,
    ).format(localizedCost);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              title: Text(widget.recipe.title),
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: widget.recipe.id,
                  child: FadeInImage(
                    image: NetworkImage(widget.recipe.imageUrl),
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/images/loading.gif'),
                  ),
                ),
              ),
            ),
          ];
        },
        body: Container(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.only(top: 8.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      Text(
                        '${localizations.estimated_cost}: $formattedCost',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${localizations.posted_at}: ${dateFormat.format(widget.recipe.postedAt)}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      Text(
                        localizations.rate_recipe_label, // 🔄 Sử dụng key i18n
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return IconButton(
                            icon: Icon(
                              index < _currentRating
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                            ),
                            onPressed: () {
                              _saveRating(index + 1.0);
                            },
                          );
                        }),
                      ),
                      Text(
                        '${localizations.your_rating_label}: $_currentRating', // 🔄 i18n
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Color(0xFF212121),
                  endIndent: 40.0,
                  indent: 40.0,
                ),
                Text(
                  localizations.nutrition_label,
                  style: TextStyle(
                    color: Color(0xFF212121),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                NutritionWidget(nutrients: widget.recipe.nutrients),
                Divider(
                  color: Color(0xFF212121),
                  endIndent: 40.0,
                  indent: 40.0,
                ),
                Text(
                  localizations.ingredients_label,
                  style: TextStyle(
                    color: Color(0xFF212121),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                IngredientsWidget(ingredients: widget.recipe.ingredients),
                Divider(
                  color: Color(0xFF212121),
                  endIndent: 40.0,
                  indent: 40.0,
                ),
                Text(
                  localizations.steps_label,
                  style: TextStyle(
                    color: Color(0xFF212121),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                RecipeSteps(steps: widget.recipe.steps),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NutritionWidget extends StatelessWidget {
  final List<Nutrients>? nutrients;
  NutritionWidget({this.nutrients});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86,
      width: double.infinity,
      child: Center(
        child: ListView.builder(
          itemCount: nutrients!.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return CircleIndicator(
              percent: nutrients![index].percent,
              nutrient: nutrients![index],
            );
          },
        ),
      ),
    );
  }
}

class IngredientsWidget extends StatelessWidget {
  final List<String>? ingredients;
  IngredientsWidget({this.ingredients});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ListView.builder(
        itemCount: ingredients!.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return _HoverIngredientCard(label: ingredients![index]);
        },
      ),
    );
  }
}

class _HoverIngredientCard extends StatefulWidget {
  final String label;
  const _HoverIngredientCard({required this.label});

  @override
  State<_HoverIngredientCard> createState() => _HoverIngredientCardState();
}

class _HoverIngredientCardState extends State<_HoverIngredientCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        margin: EdgeInsets.all(6),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color:
              _isHovered
                  ? Theme.of(context).colorScheme.secondary.withOpacity(0.8)
                  : Theme.of(context).colorScheme.secondary,
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(20),
          boxShadow:
              _isHovered
                  ? [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ]
                  : [],
        ),
        child: Text(
          widget.label,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class RecipeSteps extends StatelessWidget {
  final List<String> steps;
  RecipeSteps({this.steps = const []});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: steps.length,
      padding: const EdgeInsets.all(0.0),
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return _HoverStepTile(step: steps[index], index: index);
      },
    );
  }
}

class _HoverStepTile extends StatefulWidget {
  final String step;
  final int index;

  const _HoverStepTile({required this.step, required this.index});

  @override
  State<_HoverStepTile> createState() => _HoverStepTileState();
}

class _HoverStepTileState extends State<_HoverStepTile> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _hovering ? Colors.grey.shade200 : Colors.white,
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(12),
          boxShadow:
              _hovering
                  ? [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ]
                  : [],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Text(
                '${widget.index + 1}',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.step,
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
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
