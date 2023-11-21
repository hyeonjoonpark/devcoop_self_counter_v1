class ItemResponseDto {
  final String itemName;
  final int itemPrice; // 타입을 int로 변경
  final String itemId;
  int quantity;

  ItemResponseDto({
    required this.itemName,
    required this.itemPrice,
    required this.itemId,
    required this.quantity,
  });

  factory ItemResponseDto.fromJson(Map<String, dynamic> json) {
    return ItemResponseDto(
      itemName: json['name'],
      itemPrice: int.parse(json['price'].toString()), // 문자열을 정수로 변환
      itemId: json['itemId'],
      quantity: json['quantity'],
    );
  }
}
