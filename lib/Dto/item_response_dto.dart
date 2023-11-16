class ItemResponseDto {
  final String itemName;
  final int itemPrice;

  ItemResponseDto({
    required this.itemName,
    required this.itemPrice,
  });

  factory ItemResponseDto.fromJson(Map<String, dynamic> json) {
    return ItemResponseDto(
      itemName: json['itemName'],
      itemPrice: json['itemPrice'],
    );
  }
}
