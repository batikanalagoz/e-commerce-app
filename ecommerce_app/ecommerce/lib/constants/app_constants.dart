import 'package:ecommerce/models/categories_models.dart';
import 'package:ecommerce/services/assets.dart';

class AppConstants{

  static const String
  imageUrl = "https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/5da8f473-5c2a-49b3-8531-e0192f9ff8e9/W+NIKE+DUNK+LOW+NEXT+NATURE.png";

  static List<String> bannerImages = [
    AssetsManager.banner,
    AssetsManager.banner2,
    AssetsManager.banner3,
    AssetsManager.banner4,
    AssetsManager.banner5,
    AssetsManager.banner6,
    AssetsManager.banner7,
  ];

  static List<CategoriesModels> categoriesList = [
    CategoriesModels(
        id: "Computer",
        name: "Computer",
        image: AssetsManager.computer,
    ),
    CategoriesModels(
      id: "Books",
      name: "Books",
      image: AssetsManager.file,
    ),
    CategoriesModels(
      id: "Flower",
      name: "Flower",
      image: AssetsManager.flower,
    ),CategoriesModels(
      id: "Mobile Phone",
      name: "Mobile Phone",
      image: AssetsManager.mobilePhone,
    ),
    CategoriesModels(
      id: "Shoes",
      name: "Shoes",
      image: AssetsManager.shoes,
    ),
    CategoriesModels(
      id: "T-short",
      name: "T-short",
      image: AssetsManager.tShort,
    ),
    CategoriesModels(
      id: "Watch",
      name: "Watch",
      image: AssetsManager.watch,
    ),
  ];
}
