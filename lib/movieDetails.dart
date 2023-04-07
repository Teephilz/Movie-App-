import 'package:flutter/material.dart';

import 'model.dart';


class MovieDetails extends StatefulWidget {
MovieModel model;


  MovieDetails({
   required this.model
});


  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  int count = 1;
  String img_path="https://image.tmdb.org/t/p/w1280";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.model.title}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
        centerTitle: true,
        elevation: 0.0,
        leading: Container(),
        backgroundColor: Colors.green,

      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                        child: Container(
                          height: 300,
                          width: 300,
                          child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Container(
                                  height: 220,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(fit: BoxFit.fill,
                                          image: NetworkImage(
                                           "${img_path}${widget.model.poster.toString()}")
                                      )
                                  ),
                                ),
                              )
                          ),
                        )
                    ),

                    Container(
                      height: 300,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: (
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${widget.model.title}',
                                    style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                                SizedBox(height: 10,),
                                Text(
                                    widget.model.description.toString(),
                                    textAlign:TextAlign.justify,
                                    style: TextStyle(fontSize: 17, color: Colors
                                        .green, fontWeight: FontWeight.normal)),
                                SizedBox(height: 20,),
                                Text("Released on ${widget.model.date.toString()}.",
                                  style: TextStyle(color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16) ,)

                              ]
                          )
                      ),
                    ),

                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
