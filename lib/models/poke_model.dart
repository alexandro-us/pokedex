class PokeListItem {
    String name;
    String picture;
    String id;

    PokeListItem({
        required this.name,
        required this.picture,
        required this.id,
    });

    factory PokeListItem.fromJson(Map<String, dynamic> json) => PokeListItem(
        name: json["name"],
        picture: json["picture"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "picture": picture,
        "id": id,
    };
}
