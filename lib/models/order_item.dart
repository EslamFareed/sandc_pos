import 'package:sandc_pos/models/product.dart';

class OrderItem {
  int? quantity;
  double? total;
  int? id;
  Product? product;

  OrderItem({this.quantity, this.id, this.total, this.product});
}
