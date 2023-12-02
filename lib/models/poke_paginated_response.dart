// To parse this JSON data, do
//
//     final pokePaginatedResponse = pokePaginatedResponseFromJson(jsonString);

import 'dart:convert';

PokePaginatedResponse pokePaginatedResponseFromJson(String str) => PokePaginatedResponse.fromJson(json.decode(str));

String pokePaginatedResponseToJson(PokePaginatedResponse data) => json.encode(data.toJson());

class PokePaginatedResponse {
    int count;
    String next;
    dynamic previous;
    List<Result> results;

    PokePaginatedResponse({
        required this.count,
        required this.next,
        required this.previous,
        required this.results,
    });

    factory PokePaginatedResponse.fromJson(Map<String, dynamic> json) => PokePaginatedResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    String name;
    String url;

    Result({
        required this.name,
        required this.url,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}
