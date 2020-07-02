class CategoryModel{
  String id;
  String strCategory;
  String strCategoryThumb;
  String strCategoryDescription;

  CategoryModel({
    this.id,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json){
    return CategoryModel(
        id: json['idCategory'],
        strCategory: json['strCategory'],
        strCategoryThumb: json['strCategoryThumb'],
        strCategoryDescription: json['strCategoryDescription']
    );
  }
}