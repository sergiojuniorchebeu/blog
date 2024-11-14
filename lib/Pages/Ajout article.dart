import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:io';

class ArticleFormPage extends StatefulWidget {
  const ArticleFormPage({super.key});

  @override
  _ArticleFormPageState createState() => _ArticleFormPageState();
}

class _ArticleFormPageState extends State<ArticleFormPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final List<XFile> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  // Function to pick images
  Future<void> _pickImages() async {
    final pickedImages = await _picker.pickMultiImage();
    if (pickedImages != null) {
      if (pickedImages.length <= 6) {
        setState(() {
          _selectedImages.clear();
          _selectedImages.addAll(pickedImages);
        });
      } else {
        _showSnackBar("Vous pouvez sélectionner jusqu'à 6 photos.");
      }
    }
  }

  // Helper function to show snackbar
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Submit form function
  void _submitForm() {
    if (_formKey.currentState!.saveAndValidate()) {
      final formData = _formKey.currentState!.value;
      _showSnackBar("Article ajouté avec succès !");
      // Handle form submission (e.g., save to database)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "Ajouter un Article",
          style: GoogleFonts.lato(color: Colors.white, fontWeight: FontWeight.bold),
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
            child: FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 500),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(child: widget),
                  ),
                  children: [
                    // Carousel for selected images
                    _selectedImages.isNotEmpty
                        ? CarouselSlider(
                      options: CarouselOptions(
                        height: 200,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                      ),
                      items: _selectedImages.map((image) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(image.path),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        );
                      }).toList(),
                    )
                        : Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "Aucune image sélectionnée",
                          style: GoogleFonts.lato(fontSize: 16, color: Colors.grey[600]),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Button to pick images
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton.icon(
                        onPressed: _pickImages,
                        icon: const Icon(Icons.add_a_photo, color: Colors.white),
                        label: const Text("Sélectionner des images"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Title field
                    // Champ pour le titre
                    FormBuilderTextField(
                      name: 'title',
                      decoration: InputDecoration(
                        labelText: 'Titre de l\'article',
                        labelStyle: GoogleFonts.lato(fontSize: 18, color: Colors.black87),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      style: GoogleFonts.lato(fontSize: 18),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ce champ est requis';
                        } else if (value.length > 50) {
                          return 'Le titre ne doit pas dépasser 50 caractères';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Description field
                    FormBuilderTextField(
                      name: 'description',
                      decoration: InputDecoration(
                        labelText: 'Description de l\'article',
                        labelStyle: GoogleFonts.lato(fontSize: 18, color: Colors.black87),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      style: GoogleFonts.lato(fontSize: 16),
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ce champ est requis';
                        } else if (value.length > 300) {
                          return 'La description ne doit pas dépasser 300 caractères';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Submit button
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                        ),
                        child: Text(
                          "Ajouter l'article",
                          style: GoogleFonts.lato(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
