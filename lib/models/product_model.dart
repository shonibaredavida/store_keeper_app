class ProductModel {
  final int? id;
  final String name;
  final String? desc;
  final double quantity;
  final String measure;
  final double price;
  final String? image;
  final String? dateModified;
  final String? dateCreated;
  ProductModel({
    this.id,
    required this.name,
    this.desc,
    required this.measure,
    required this.quantity,
    required this.price,
    this.image,
    this.dateCreated,
    this.dateModified,
  });
  // Convert a ProductModel into a Map. The keys correspond to the column names.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'measure': measure,
      'quantity': quantity,
      'price': price,
      'image': image,
      'dateCreated': dateCreated,
      'dateModified': dateModified,
    };
  }

  // Convert a Map into a ProductModel
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      desc: map['desc'],
      measure: map['measure'],
      quantity: map['quantity'],
      price: map['price'],
      image: map['image'],
      dateCreated: map['dateCreated'],
      dateModified: map['dateModified'],
    );
  }
}
