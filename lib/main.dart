import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cartelera de Cine',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cartelera de Cine'),
      ),
      body: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedGenre = 'Todos';

  final List<Map<String, dynamic>> movies = const [
    {'title': 'Película 1', 'genre': 'Acción', 'image': 'IMG/1.jpg', 'font': 'Roboto'},
    {'title': 'Película 2', 'genre': 'Animación', 'image': 'IMG/2.png', 'font': 'Lora'},
    {'title': 'Película 3', 'genre': 'Ciencia ficción', 'image': 'IMG/3.png', 'font': 'Merriweather'},
    {'title': 'Película 4', 'genre': 'Drama', 'image': 'IMG/4.png', 'font': 'Quicksand'},
    {'title': 'Película 5', 'genre': 'Comedia', 'image': 'IMG/5.jpg', 'font': 'Work Sans'},
    {'title': 'Película 6', 'genre': 'Terror', 'image': 'IMG/6.jpg', 'font': 'PT Sans'},
    {'title': 'Película 7', 'genre': 'Romance', 'image': 'IMG/7.png', 'font': 'DM Sans'},
    {'title': 'Película 8', 'genre': 'Aventura', 'image': 'IMG/8.jpg', 'font': 'Mulish'},
    {'title': 'Película 9', 'genre': 'Fantasía', 'image': 'IMG/10.png', 'font': 'Kanit'},
    {'title': 'Película 10', 'genre': 'Documental', 'image': 'IMG/11.png', 'font': 'Noto Sans'},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredMovies = selectedGenre == 'Todos'
        ? movies
        : movies.where((movie) => movie['genre'] == selectedGenre).toList();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedGenre,
              items: ['Todos', 'Acción', 'Animación', 'Ciencia ficción', 'Drama', 'Comedia', 'Terror', 'Romance', 'Aventura', 'Fantasía', 'Documental']
                  .map((genre) => DropdownMenuItem(
                        value: genre,
                        child: Text(genre),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedGenre = value!;
                });
              },
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
                final movie = filteredMovies[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            movie['image'],
                            width: 120,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie['title'],
                                style: GoogleFonts.getFont(
                                  movie['font'],
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Género: ${movie['genre']}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
