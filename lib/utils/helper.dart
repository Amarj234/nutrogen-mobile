import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nutrogen/data/model/meal_list_model.dart';
import 'package:nutrogen/res/app_routers.dart';

ThemeData get theme => Theme.of(AppRouters.rootKey.currentContext!);
AppLocalizations get loc =>
    AppLocalizations.of(AppRouters.rootKey.currentContext!);

String percent({required double? maxValue, required double? value}) {
  return (((value ?? 0) / (maxValue ?? 0)) * 100).toStringAsFixed(2);
}

Food collectFood(Food previousFood, Food food, {int quantity = 1}) {
  return previousFood = previousFood.copyWith(
    addedSugarG: (previousFood.addedSugarG ?? 0) + (food.addedSugarG ?? 0),
    calciumMg: (previousFood.calciumMg ?? 0) + (food.calciumMg ?? 0),
    carbohydrateG:
        (previousFood.carbohydrateG ?? 0) + (food.carbohydrateG ?? 0),
    cholesterolMg:
        (previousFood.cholesterolMg ?? 0) + (food.cholesterolMg ?? 0),
    energyKcal: (previousFood.energyKcal ?? 0) + (food.energyKcal ?? 0),
    fatG: (previousFood.fatG ?? 0) + (food.fatG ?? 0),
    folateUg: (previousFood.folateUg ?? 0) + (food.folateUg ?? 0),
    iodineUg: (previousFood.iodineUg ?? 0) + (food.iodineUg ?? 0),
    ironMg: (previousFood.ironMg ?? 0) + (food.ironMg ?? 0),
    magnesiumMg: (previousFood.magnesiumMg ?? 0) + (food.magnesiumMg ?? 0),
    niacinB3Mg: (previousFood.niacinB3Mg ?? 0) + (food.niacinB3Mg ?? 0),
    phosphorusMg: (previousFood.phosphorusMg ?? 0) + (food.phosphorusMg ?? 0),
    polyunsaturedFatG:
        (previousFood.polyunsaturedFatG ?? 0) + (food.polyunsaturedFatG ?? 0),
    potassiumMg: (previousFood.potassiumMg ?? 0) + (food.potassiumMg ?? 0),
    proteinG: (previousFood.proteinG ?? 0) + (food.proteinG ?? 0),
    riboflavinB2Mg:
        (previousFood.riboflavinB2Mg ?? 0) + (food.riboflavinB2Mg ?? 0),
    saturatedFatG:
        (previousFood.saturatedFatG ?? 0) + (food.saturatedFatG ?? 0),
    seleniumUg: (previousFood.seleniumUg ?? 0) + (food.seleniumUg ?? 0),
    sodiumMg: (previousFood.sodiumMg ?? 0) + (food.sodiumMg ?? 0),
    starchG: (previousFood.starchG ?? 0) + (food.starchG ?? 0),
    sugarG: (previousFood.sugarG ?? 0) + (food.sugarG ?? 0),
    thiaminB1Mg: (previousFood.thiaminB1Mg ?? 0) + (food.thiaminB1Mg ?? 0),
    transFatMg: (previousFood.transFatMg ?? 0) + (food.transFatMg ?? 0),
    vitaminAUg: (previousFood.vitaminAUg ?? 0) + (food.vitaminAUg ?? 0),
    vitaminCMg: (previousFood.vitaminCMg ?? 0) + (food.vitaminCMg ?? 0),
    vitaminEMg: (previousFood.vitaminEMg ?? 0) + (food.vitaminEMg ?? 0),
    zincMg: (previousFood.zincMg ?? 0) + (food.zincMg ?? 0),
  );
}
