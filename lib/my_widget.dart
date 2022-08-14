import 'package:flutter/material.dart';

import 'package:network_layer/repository/app_repository.dart';
import 'package:network_layer/repository/network_layer/response/network_response.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie item'),
      ),
      body: FutureBuilder<NetworkResponse>(
          future: AppRepository().getMovieList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error found '),
              );
            } else {
              var response = snapshot.data;

              var dataResult = response?.whenOrNull(ok: (data) => data);

              return Text(' ${dataResult.data.length}');
            }
          }),
    );
  }
}
