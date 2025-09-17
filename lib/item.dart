class Item{
  int id;
  int quantity;
  String destination;
  String dateOrder;
  String dateReq;
  String priority;

  Item(this.id, this.quantity, this.destination, this.dateOrder, this.dateReq, this.priority);
  int get partID => id;
  int get partQuantity => quantity;
  String get partName => destination;
  String get partOrder => dateOrder;
  String get partReq => dateReq;
  String get partPriority => priority;

  @override
  String toString() {
    return '$id: $quantity: $destination: $dateOrder: $dateReq: $priority';
  }
}

