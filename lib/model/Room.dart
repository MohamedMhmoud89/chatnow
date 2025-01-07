class Room {
  static const String collectionName = 'room';

  String? id;
  String? title;
  String? description;
  String? catId;

  Room({this.id, this.title, this.description, this.catId});

  Room.fromFireStore(Map<String, dynamic> date)
      : this(
            id: date['id'],
            title: date['title'],
            description: date['description'],
            catId: date['catId']);

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'catId': catId
    };
  }
}
