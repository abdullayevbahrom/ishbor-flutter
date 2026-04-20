

// class CategoryModel {
//   final int id;
//   final String path;
//   final int level;
//   final int? parent;
//   final CategoryModel? parentObj;
//   final Map<String, dynamic>? iconUrls;
//   final Map<String, dynamic>? iconSmallUrls;
//   final List<CategoryModel>? children;
//   final List<CategoryTranslation> translations;
//
//   CategoryModel({
//     required this.id,
//     required this.path,
//     required this.level,
//     this.iconUrls,
//     this.iconSmallUrls,
//     this.parent,
//     this.parentObj,
//     this.children,
//     required this.translations
//   });
//
//   CategoryModel.clone(CategoryModel cat2) :
//       this.id = cat2.id, this.path = cat2.path, this.level = cat2.level,
//       this.parent = cat2.parent, this.parentObj = cat2.parentObj, this.iconUrls = cat2.iconUrls,
//       this.iconSmallUrls = cat2.iconSmallUrls, this.children = cat2.children,
//       this.translations = cat2.translations.map((t) => CategoryTranslation.clone(t)).toList();
//
//   static CategoryModel fromMap(Map<String, dynamic> data) {
//     List<Map<String, dynamic>> children = data['children'] == null ? [] : ((data['children'] as List<dynamic>).map((dynamic data) => Map<String, dynamic>.from(data)).toList());
//
//     return CategoryModel(
//         id: data['id'],
//         path: data['path'],
//         level: data['level'],
//         parent: data['parent'],
//         parentObj: data['parentObj'] != null ? CategoryModel.fromMap(data['parentObj']) : null,
//         iconUrls: data['icon'] != null ? data['icon']['urls'] : null,
//         iconSmallUrls: data['icon_small'] != null ? data['icon_small']['urls'] : null,
//         children: children.map((childData) => CategoryModel.fromMap(childData)).toList(),
//         translations: List.from(data['translations']).map((trans) => CategoryTranslation.fromJson(trans)).toList()
//     );
//   }
//
//   CategoryTranslation trans(String locale) {
//     CategoryTranslation catTrans = this.translations.firstWhere((t) => t.locale == (locale ?? 'ru'));
//
//     // if (catTrans.name == null) {
//     //   return this.translations.firstWhere((t) => t.locale == 'ru', orElse: () => null);
//     // }
//
//     return catTrans;
//   }
// }
