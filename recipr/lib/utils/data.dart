import 'package:recipr/utils/class.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Data {
  static Map<String, double> ratings = {};
  static List<Recipe> getRecipes(context) {
    final localizations = AppLocalizations.of(context);
    
    return [
      Recipe(
        id: '1',
        title: localizations!.mandu_title,
        imageUrl:
            'https://images.unsplash.com/photo-1496116218417-1a781b1c416c?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        nutrients: [
          Nutrients(
            name: localizations.calories_label,
            weight: '300',
            percent: 0.5,
          ),
          Nutrients(
            name: localizations.protein_label,
            weight: '12g',
            percent: 0.6,
          ),
          Nutrients(
            name: localizations.carb_label,
            weight: '40g',
            percent: 0.8,
          ),
          Nutrients(name: localizations.fat_label, weight: '10g', percent: 0.4),
        ],
        steps: [
          localizations.gather_ingredients,
          localizations.steam_dumplings,
          localizations.serve_with_sauce,
        ],
        ingredients: [
          localizations.ground_pork,
          localizations.cabbage,
          localizations.soy_sauce,
          localizations.dumpling_wrappers,
        ],
        cost: 55000,
        postedAt: DateTime.now().subtract(Duration(days: 1)),
      ),
      Recipe(
        id: '2',
        title: localizations.cappuccino_title,
        imageUrl:
            'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
        nutrients: [
          Nutrients(
            name: localizations.calories_label,
            weight: '150',
            percent: 0.4,
          ),
          Nutrients(
            name: localizations.protein_label,
            weight: '6g',
            percent: 0.3,
          ),
          Nutrients(
            name: localizations.carb_label,
            weight: '12g',
            percent: 0.2,
          ),
          Nutrients(name: localizations.fat_label, weight: '8g', percent: 0.5),
        ],
        steps: [
          localizations.gather_ingredients,
          localizations.pull_espresso,
          localizations.foam_milk,
          localizations.serve_immediately,
        ],
        ingredients: [localizations.espresso_shots, localizations.whole_milk],
        cost: 39000,
        postedAt: DateTime.now().subtract(Duration(days: 50)),
      ),
      Recipe(
        id: '3',
        title: localizations.spaghetti_title,
        imageUrl:
            'https://images.unsplash.com/photo-1622973536968-3ead9e780960?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        nutrients: [
          Nutrients(
            name: localizations.calories_label,
            weight: '400',
            percent: 0.7,
          ),
          Nutrients(
            name: localizations.protein_label,
            weight: '18g',
            percent: 0.8,
          ),
          Nutrients(
            name: localizations.carb_label,
            weight: '70g',
            percent: 0.6,
          ),
          Nutrients(name: localizations.fat_label, weight: '12g', percent: 0.4),
        ],
        steps: [
          localizations.boil_pasta,
          localizations.prepare_sauce,
          localizations.combine_and_serve,
        ],
        ingredients: [
          localizations.spaghetti,
          localizations.tomato_sauce,
          localizations.grated_cheese,
          localizations.minced_beef,
        ],
        cost: 50000,
        postedAt: DateTime.now().subtract(Duration(days: 100)),
      ),
      Recipe(
        id: '4',
        title: localizations.pizza_title,
        imageUrl:
            'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        nutrients: [
          Nutrients(
            name: localizations.calories_label,
            weight: '500',
            percent: 0.8,
          ),
          Nutrients(
            name: localizations.protein_label,
            weight: '20g',
            percent: 0.7,
          ),
          Nutrients(
            name: localizations.carb_label,
            weight: '60g',
            percent: 0.6,
          ),
          Nutrients(name: localizations.fat_label, weight: '18g', percent: 0.5),
        ],
        steps: [
          localizations.preheat_oven,
          localizations.prepare_pizza_dough,
          localizations.add_toppings_and_bake,
        ],
        ingredients: [
          localizations.pizza_dough,
          localizations.mozzarella,
          localizations.tomato_sauce,
          localizations.pepperoni,
        ],
        cost: 200000,
        postedAt: DateTime.now().subtract(Duration(days: 200)),
      ),
      Recipe(
        id: '5',
        title: localizations.sushi_title,
        imageUrl:
            'https://images.unsplash.com/photo-1617196034738-26c5f7c977ce?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        nutrients: [
          Nutrients(
            name: localizations.calories_label,
            weight: '250',
            percent: 0.5,
          ),
          Nutrients(
            name: localizations.protein_label,
            weight: '12g',
            percent: 0.6,
          ),
          Nutrients(
            name: localizations.carb_label,
            weight: '30g',
            percent: 0.7,
          ),
          Nutrients(name: localizations.fat_label, weight: '8g', percent: 0.3),
        ],
        steps: [
          localizations.prepare_rice,
          localizations.roll_sushi,
          localizations.slice_and_serve,
        ],
        ingredients: [
          localizations.sushi_rice,
          localizations.nori_seaweed,
          localizations.raw_salmon,
          localizations.avocado,
        ],
        cost: 40000,
        postedAt: DateTime.now().subtract(Duration(days: 43)),
      ),
      Recipe(
        id: '6',
        title: localizations.salad_title,
        imageUrl:
            'https://images.unsplash.com/photo-1543339308-43e59d6b73a6?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        nutrients: [
          Nutrients(
            name: localizations.calories_label,
            weight: '120',
            percent: 0.3,
          ),
          Nutrients(
            name: localizations.protein_label,
            weight: '5g',
            percent: 0.2,
          ),
          Nutrients(
            name: localizations.carb_label,
            weight: '15g',
            percent: 0.2,
          ),
          Nutrients(name: localizations.fat_label, weight: '6g', percent: 0.4),
        ],
        steps: [
          localizations.wash_vegetables,
          localizations.chop_ingredients,
          localizations.toss_and_serve,
        ],
        ingredients: [
          localizations.lettuce,
          localizations.tomatoes,
          localizations.cucumber,
          localizations.salad_dressing,
        ],
        cost: 30000,
        postedAt: DateTime.now().subtract(Duration(days: 123)),
      ),
      // Add 6 more recipes in similar structure to reach 12 total recipes.
    ];
  }
}
