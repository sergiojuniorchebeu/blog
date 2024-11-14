import 'package:blog/Pages/Ajout%20article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Presentation Articles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPress() {
    setState(() {
      _controller.forward();
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticleFormPage()));
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          // Content Overlay
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MasonryGridView.count(
              crossAxisCount: 2,
              itemCount: 8, // Replace with actual data count
              itemBuilder: (context, index) {
                return _buildArticleCard(index);
              },
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
          ),
        ],
      ),
      floatingActionButton: ScaleTransition(
        scale: _scaleAnimation,
        child: FloatingActionButton(
          onPressed: _onPress,
          backgroundColor: Colors.blueAccent,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }

  // Builds individual article cards with animation
  Widget _buildArticleCard(int index) {
    return AnimatedScale(
      scale: 1.0, // Initial scale
      duration: Duration(milliseconds: 500 + index * 100), // Slightly staggered effect
      curve: Curves.easeInOut,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        shadowColor: Colors.black54,
        color: Colors.white.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title of the article
              Text(
                'Article Title $index',
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Short description
              Text(
                'This is a brief description of the article. It provides a quick summary of the content...',
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Action button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ArticleDetailPage(
                          title: 'Titre de l\'article',
                          description: 'Description détaillée de l\'article...',
                          imageUrls: [
                            'https://cdn-icons-png.flaticon.com/128/18167/18167036.png',
                            'https://cdn-icons-png.flaticon.com/128/18167/18167036.png',
                            'https://cdn-icons-png.flaticon.com/128/18167/18167036.png',
                          ],
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Read More',
                    style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
