import 'package:cab_sharing/src/services/api.dart';
import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../widgets/home/date_tile.dart';

class SearchScreen extends StatefulWidget {
  final Map<String,dynamic> userData;
  SearchScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(27, 27, 29, 1),
        elevation: 0,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(27, 27, 29, 1),
      body: FutureBuilder(
          future: APIService.getSearchResults(widget.userData),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, List<PostModel>>> snapshot) {
            print(snapshot.data);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            else if (snapshot.data == null) {
              print('empty');
              return Container(
                width: 234,
                height: 73,
                child: Text('Some error occured'),
              );
            }
            else if(snapshot.data!.isEmpty)
              {
                print('empty');
                return Container(
                  width: 234,
                  height: 73,
                  child: Text('No Results Found'),
                );
              }
            else
              {
                String date = snapshot.data!.keys.toList().first;
                print('here is the data');
                print(snapshot.data);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DateTile(posts: snapshot.data![date]!, date: date)
                  ],
                );
              }

          }),
    );
  }
}
