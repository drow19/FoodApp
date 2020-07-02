
class DetailModel{
  String idMeal;
  String strMeal;
  String strDrinkAlternate;
  String strCategory;
  String strArea;
  String strInstructions;
  String strMealThumb;
  String strTags;
  String strYoutube;

  String strIngredient1;
  String strIngredient2;
  String strIngredient3;
  String strIngredient4;
  String strIngredient5;

  String strMeasure1;
  String strMeasure2;
  String strMeasure3;
  String strMeasure4;
  String strMeasure5;

  String strSource;
  String dateModified;

  DetailModel({
    this.idMeal,
    this.strMeal,
    this.strDrinkAlternate,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    this.strIngredient1,
    this.strIngredient2,
    this.strIngredient3,
    this.strIngredient4,
    this.strIngredient5,
    this.strMeasure1,
    this.strMeasure2,
    this.strMeasure3,
    this.strMeasure4,
    this.strMeasure5,
    this.dateModified,
    this.strSource
  });

  factory DetailModel.fromJson(Map<String, dynamic> json){
    return DetailModel(
        idMeal: json['idMeal'],
        strMeal: json['strMeal'],
        strArea: json['strArea'],
        strDrinkAlternate: json['strDrinkAlternate'],
        strCategory: json['strCategory'],
        strInstructions: json['strInstructions'],
        strMealThumb: json['strMealThumb'],
        strTags: json['strTags'],
        strYoutube: json['strYoutube'],
        strIngredient1: json['strIngredient1'],
        strIngredient2: json['strIngredient2'],
        strIngredient3: json['strIngredient3'],
        strIngredient4: json['strIngredient4'],
        strIngredient5: json['strIngredient5'],
        strMeasure1: json['strMeasure1'],
        strMeasure2: json['strMeasure2'],
        strMeasure3: json['strMeasure3'],
        strMeasure4: json['strMeasure4'],
        strMeasure5: json['strMeasure5'],
        strSource: json['strSource'],
        dateModified: json['dateModified']
    );
  }
}