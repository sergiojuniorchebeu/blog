import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ArticleDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final List<String> imageUrls;

  const ArticleDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrls,
  });

  void _editArticle(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Modification de l'article"),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmer la suppression'),
          content: const Text('Êtes-vous sûr de vouloir supprimer cet article ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteArticle(context);
              },
              child: const Text(
                'Supprimer',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteArticle(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Article supprimé"),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: Text(
          "Détails de l'article",
          style: GoogleFonts.lato(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: AnimationLimiter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 500),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  // Carousel Slider pour les images
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 250,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      enlargeCenterPage: true,
                    ),
                    items: imageUrls.map((url) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          url,
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Titre et Description de l'article
                  Text(
                    title,
                    style: GoogleFonts.lato(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Divider(color: Colors.grey[300]),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.black54,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Options de modification et suppression visibles
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _editArticle(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        ),
                        icon: const Icon(Icons.edit, color: Colors.white),
                        label: const Text(
                          'Modifier',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _confirmDelete(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        ),
                        icon: const Icon(Icons.delete, color: Colors.white),
                        label: const Text(
                          'Supprimer',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
