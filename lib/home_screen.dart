import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movie_app/model.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/movieDetails.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamController _streamController=StreamController();

  List<MovieModel> movieList=[];
  List<MovieModel> filteredList=[];

String img_path="https://image.tmdb.org/t/p/w1280";

  Future<List<MovieModel>> getMovies() async{
    String url="https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=3fd2be6f0c70a2a598f084ddfb75487c&page=1";
    final response = await http.get(Uri.parse(url));
    if(response.statusCode== 200){
      final  result= json.decode(response.body);
      Iterable list=result["results"];
      return list.map((e) => MovieModel.fromJson(e)).toList();
    }
    else{
      return <MovieModel>[];
    }
  }


  Future _populateAllMovies()async{
      movieList= await getMovies();
      filteredList=List.from(movieList);
    _streamController.add(filteredList);
  }

  @override
  void initState() {
  _populateAllMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Movies",
        style: TextStyle(color: Colors.white),),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (val){
                    if(val.toString().isEmpty){
                      setState(() {
                        filteredList=movieList;
                      });
                    }
                    setState(() {
                      filteredList = movieList.where((e){
                        return e.title.toString().toLowerCase().contains(val.toString().toLowerCase());
                      }).toList();
                    });
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.black,),
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                    hintText: "Search for your movies here...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0,
                        color: Colors.black
                      )
                    )
                  ),
                ),
              ),
              StreamBuilder(
                stream: _streamController.stream,
                builder: (context,snapshots){
                  if(snapshots.hasData){
                    return SizedBox(
                      height: MediaQuery.of(context).size.height*0.8,
                      child: ListView.separated(
                          itemCount: filteredList.length,
                          separatorBuilder: (context, index){
                            return SizedBox(height: 5,);
                          },
                          itemBuilder: (context, index){
                            final movie= filteredList[index];
                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Card(
                                child: ListTile(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetails(model: movie)));
                                    },
                                    title:Row(
                                      children: [
                                        Container(
                                          height: 150,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      "${img_path}${movie.poster.toString()}")
                                              )
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(movie.title.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                                              Text(movie.date.toString())
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                ),
                              ),
                            );
                          }),
                    );
                  }
                  else{
                    return SizedBox(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      )


    );
  }
}
