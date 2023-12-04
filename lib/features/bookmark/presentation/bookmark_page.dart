import 'package:flutter/material.dart';
import 'package:ulas_buku_mobile/features/home/presentation/pages/home_page.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Bookmarks',
          style: TextStyle(
            fontFamily: 'Outfit',
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ));            
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.tune_rounded,
              color: Colors.black,
              size: 24,
            ),
            onPressed: () {
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 12, 0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: Colors.grey,
                        size: 24,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 4),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Search bookmarks...',
                              labelStyle: TextStyle(
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 0, 4),
              child: Text(
                'My Bookmarks',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                'https://images.unsplash.com/photo-1473755504818-b72b6dfdc226?w=1280&h=720',
                                width: 70,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(8, 0, 4, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'The Great Gatsby',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 4),
                                      child: Text(
                                        'F. Scott Fitzgerald',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
