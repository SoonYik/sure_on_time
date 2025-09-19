class Item{
  int id;
  int quantity;
  String destination;
  String dateOrder;
  String dateReq;
  String priority;
  String status;
  String? image;
  String? name;

  Item(this.id, this.quantity, this.destination, this.dateOrder, this.dateReq, this.priority, this.status, this.image, this.name);

  @override
  String toString() {
    return '$id: $quantity: $destination: $dateOrder: $dateReq: $priority';
  }
}

