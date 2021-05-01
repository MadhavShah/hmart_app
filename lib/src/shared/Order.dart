class Order {
  String name, price, image;
  bool userLiked;
  double discount;
  int quantity;

  Order(
      {this.name,
      this.price,
      this.discount,
      this.image,
      this.userLiked,
      this.quantity});
}
