class DeleteDto {
  final int id;

  const DeleteDto({required this.id});

  factory DeleteDto.fromJson(Map<String, dynamic> json) {
    return DeleteDto(id: json['id']);
  }
}
