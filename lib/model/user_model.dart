class UserModel {
  static UserModel? currentUser;
  late String id;
  late String name;
  late String email;
  List<String> favouriteEventIds;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.favouriteEventIds,
  });

  UserModel.fromJson(Map<String, dynamic> json)
    : this(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        favouriteEventIds: (json["favouriteEventIds"]as List<dynamic>).map((favouriteEventId) => favouriteEventId.toString()).toList(),
      );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "favouriteEventIds": favouriteEventIds,
    };
  }
}
