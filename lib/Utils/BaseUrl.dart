class BaseUrl{

  static category(){
    return "https://www.themealdb.com/api/json/v1/1/categories.php";
  }

  static meals(){
    return "https://www.themealdb.com/api/json/v1/1/filter.php?c=";
  }

  static details(){
    return "https://www.themealdb.com/api/json/v1/1/lookup.php?i=";
  }

  static search(){
    return "https://www.themealdb.com/api/json/v1/1/search.php?s=";
  }
}