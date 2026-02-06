import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class MoviePoster extends StatelessWidget {
  final String posterUrl;
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const MoviePoster({
    super.key,
    required this.posterUrl,
    this.width = 100,
    this.height = 150,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Image.network(
        posterUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildErrorPlaceholder(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildLoadingPlaceholder();
        },
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: AppColors.divider,
      child: const Icon(Icons.movie, size: 48, color: AppColors.textHint),
    );
  }

  Widget _buildLoadingPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: AppColors.divider,
      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}
