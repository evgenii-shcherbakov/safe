abstract class Entity {
  final String id;

  Entity(this.id);

  Map<String, dynamic> toJson();
}
