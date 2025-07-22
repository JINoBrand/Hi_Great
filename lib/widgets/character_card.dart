import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  final String name;
  final String quote;
  final String imageUrl;
  final double width;
  final double height;

  const CharacterCard({
    Key? key,
    required this.name,
    required this.quote,
    required this.imageUrl,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF0C0D0D),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.indigo.shade100, width: 1.5),
      ),
      child: AspectRatio(
        aspectRatio: 3/4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: imageUrl.startsWith('assets/')
              ? Image.asset(
                  imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                )
              : Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.account_circle, size: width, color: Colors.grey[300]),
                ),
        ),
      ),
    );
  }
}
