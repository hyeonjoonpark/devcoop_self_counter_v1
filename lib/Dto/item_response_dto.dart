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
      itemPrice: json['price'] ?? 0, // null 처리
      itemId: json['itemId'] ?? 0, // null 처리 또는 기본값 지정
      quantity: json['quantity'] ?? 0, // null 처리 또는 기본값 지정
    );
  }
}
