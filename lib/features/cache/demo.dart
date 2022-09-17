import 'package:flutter/material.dart';

import 'custom_cache_manager.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CacheView());
  }
}

class CacheView extends StatefulWidget {
  const CacheView({Key? key}) : super(key: key);

  @override
  _CacheViewState createState() => _CacheViewState();
}

class _CacheViewState extends State<CacheView> {
  String title = 'Waiting to download';
  String url =
      'https://firebasestorage.googleapis.com/v0/b/filledstacks.appspot.com/o/filledstacks_tutorials.pdf?alt=media&token=a5e671e7-5acd-4bc4-a167-8d8483954d2a';
  CustomCacheManager customCacheManager = CustomCacheManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() => title = 'Downloading...');
          var fetchedFile = await customCacheManager.getSingleFile(url);
          setState(() => title = 'File fetched: ${fetchedFile.path}');
        },
      ),
      body: Center(child: Text(title)),
    );
  }
}
