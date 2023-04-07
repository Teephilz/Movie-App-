import 'package:flutter/material.dart';
class MovieModel{
  final String? title;
  final String? poster;
  final String? description;
  final String? date;

    MovieModel({
    this.title,
    this.poster,
    this.description,
    this.date
});
   factory MovieModel.fromJson(Map<String,dynamic>json){
     return MovieModel(
       title: json["original_title"],
       poster: json["poster_path"],
       description: json["overview"],
       date: json["release_date"]
     );
   }


}