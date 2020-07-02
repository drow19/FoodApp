class FoodModel {
  String idMeal;
  String strMeal;
  String strMealThumb;

  FoodModel({
    this.idMeal,
    this.strMeal,
    this.strMealThumb
  });

  factory FoodModel.fromJson(Map<String, dynamic> json){
    return FoodModel(
        idMeal: json['idMeal'],
        strMeal: json['strMeal'],
        strMealThumb:json['strMealThumb']
    );
  }
}