import 'package:flutter/material.dart';

class Homecontant extends StatefulWidget {
  const Homecontant({super.key});

  @override
  State<Homecontant> createState() => _HomecontantState();
}

class _HomecontantState extends State<Homecontant> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [

        /// CATEGORY TABS
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: isDark ? Colors.grey.shade900 : Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCategoryTab(Icons.man, "Men's Fashion", isDark),
                _buildCategoryTab(Icons.woman, "Women's Fashion", isDark),
                _buildCategoryTab(Icons.devices, "Electronics", isDark),
                _buildCategoryTab(Icons.health_and_safety, "Health", isDark),
              ],
            ),
          ),
        ),

        /// EXCLUSIVE EVENT BANNER
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [Colors.grey.shade900, Colors.grey.shade800],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  // Background image with overlay
                  Positioned(
                    right: -40,
                    bottom: -40,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  // Content
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.purple.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                "EXCLUSIVE EVENT",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              "Limited Time\nOffer",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Curated selection of autumn essentials\nup to 40% off.",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                "Shop Collection",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        /// TRENDING COLLECTIONS TITLE
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Trending Collections",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "View All >",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        /// TRENDING COLLECTIONS GRID
        // SliverToBoxAdapter(
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 16),
        //     child: GridView.count(
        //       crossAxisCount: 3,
        //       shrinkWrap: true,
        //       physics: const NeverScrollableScrollPhysics(),
        //       crossAxisSpacing: 10,
        //       mainAxisSpacing: 10,
        //       childAspectRatio: 0.85,
        //       children: [
        //         _buildTrendingCard(
        //           "Onyx Watch Pro",
        //           "\$299",
        //           "4.9 (124)",
        //           "https://images.unsplash.com/photo-1523275335684-37898b6baf30",
        //           isDark,
        //         ),
        //         _buildTrendingCard(
        //           "Neo Glide Sneakers",
        //           "\$145",
        //           "4.8 (89)",
        //           "https://images.unsplash.com/photo-1542291026-7eec264c27ff",
        //           isDark,
        //           originalPrice: "\$180",
        //         ),
        //         _buildTrendingCard(
        //           "Sonic Aura X",
        //           "\$350",
        //           "5.0 (215)",
        //           "https://images.unsplash.com/photo-1505740420928-5e560c06d30e",
        //           isDark,
        //         ),
        //         _buildTrendingCard(
        //           "Latitude Leather Tote",
        //           "\$120",
        //           "4.7 (56)",
        //           "https://images.unsplash.com/photo-1548036328-c9fa89d128fa",
        //           isDark,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),

        /// CURATED FOR YOU TITLE
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 12),
            child: Text(
              "Curated For You",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        /// CURATED ITEMS
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildCuratedCard(
                  "Artisan Coffee Ensemble",
                  "Elevate your morning routine with our award-...",
                  "\$89.00",
                  "SEASONAL PICK",
                  "https://images.unsplash.com/photo-1559056199-641a0ac8b3f4",
                  isDark,
                  Colors.green,
                ),
                const SizedBox(height: 16),
                _buildCuratedCard(
                  "Velocity Performance Trainers",
                  "Engineered for the modern athlete with zer...",
                  "\$179.00",
                  "TOP RATED",
                  "https://images.unsplash.com/photo-1542291026-7eec264c27ff",
                  isDark,
                  Colors.blue,
                  originalPrice: "\$210.00",
                ),
              ],
            ),
          ),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(height: 40),
        ),
      ],
    );
  }

  Widget _buildCategoryTab(IconData icon, String label, bool isDark) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 24, color: isDark ? Colors.white : Colors.black),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 60,
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buildTrendingCard(
  //     String title,
  //     String price,
  //     String rating,
  //     String imageUrl,
  //     bool isDark, {
  //       String? originalPrice,
  //     }) {
  //   return LayoutBuilder(
  //     builder: (context, constraints) {
  //       final screenWidth = MediaQuery.of(context).size.width;
  //       final screenHeight = MediaQuery.of(context).size.height;
  //       final textScale = MediaQuery.of(context).textScaleFactor;
  //
  //       // Single scale factor for all responsive values
  //       final baseScale = screenWidth / 375; // 375 = base design width (iPhone SE)
  //
  //       // Calculate all sizes based on scale factor
  //       final titleFontSize = (14 * baseScale).clamp(12.0, 18.0);
  //       final priceFontSize = (16 * baseScale).clamp(13.0, 20.0);
  //       final ratingFontSize = (12 * baseScale).clamp(10.0, 16.0);
  //       final paddingValue = (12 * baseScale).clamp(8.0, 16.0);
  //       final borderRadius = (12 * baseScale).clamp(8.0, 16.0);
  //       final iconSize = (14 * baseScale).clamp(12.0, 18.0);
  //       final spacingSmall = (6 * baseScale).clamp(4.0, 8.0);
  //       final spacingMedium = (8 * baseScale).clamp(6.0, 12.0);
  //
  //       return Container(
  //         decoration: BoxDecoration(
  //           color: isDark ? Colors.grey.shade800 : Colors.white,
  //           borderRadius: BorderRadius.circular(borderRadius),
  //           border: Border.all(
  //             color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
  //             width: 0.5,
  //           ),
  //           boxShadow: [
  //             BoxShadow(
  //               color: isDark ? Colors.black26 : Colors.black.withOpacity(0.08),
  //               blurRadius: 4,
  //               offset: const Offset(0, 2),
  //             ),
  //           ],
  //         ),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             // Product Image with AspectRatio (4:3 ratio - perfect scaling)
  //             ClipRRect(
  //               borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(borderRadius),
  //                 topRight: Radius.circular(borderRadius),
  //               ),
  //               child: AspectRatio(
  //                 aspectRatio: 4 / 3,
  //                 child: Container(
  //                   color: isDark ? Colors.grey.shade700 : Colors.grey.shade100,
  //                   child: Image.network(
  //                     imageUrl,
  //                     fit: BoxFit.cover,
  //                     errorBuilder: (context, error, stackTrace) {
  //                       return Container(
  //                         color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
  //                         child: Center(
  //                           child: Icon(
  //                             Icons.image_not_supported_outlined,
  //                             color: isDark ? Colors.grey.shade500 : Colors.grey,
  //                             size: iconSize * 1.5,
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //               ),
  //             ),
  //
  //             // Product Details
  //             Padding(
  //               padding: EdgeInsets.all(paddingValue),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   // Title
  //                   Text(
  //                     title,
  //                     maxLines: 2,
  //                     overflow: TextOverflow.ellipsis,
  //                     style: TextStyle(
  //                       fontSize: titleFontSize,
  //                       fontWeight: FontWeight.w600,
  //                       color: isDark ? Colors.white : Colors.black87,
  //                       height: 1.3,
  //                     ),
  //                   ),
  //                   SizedBox(height: spacingSmall),
  //
  //                   // Rating Section
  //                   Row(
  //                     children: [
  //                       Icon(
  //                         Icons.star_rounded,
  //                         size: iconSize,
  //                         color: Colors.amber,
  //                       ),
  //                       SizedBox(width: spacingSmall * 0.7),
  //                       Text(
  //                         rating,
  //                         style: TextStyle(
  //                           fontSize: ratingFontSize,
  //                           color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
  //                           fontWeight: FontWeight.w500,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(height: spacingMedium),
  //
  //                   // Price Section
  //                   Row(
  //                     children: [
  //                       Flexible(
  //                         child: Text(
  //                           price,
  //                           style: TextStyle(
  //                             fontSize: priceFontSize,
  //                             fontWeight: FontWeight.bold,
  //                             color: Colors.red.shade600,
  //                           ),
  //                         ),
  //                       ),
  //                       if (originalPrice != null) ...[
  //                         SizedBox(width: spacingSmall),
  //                         Flexible(
  //                           child: Text(
  //                             originalPrice,
  //                             style: TextStyle(
  //                               fontSize: ratingFontSize,
  //                               color: isDark ? Colors.grey.shade500 : Colors.grey.shade500,
  //                               decoration: TextDecoration.lineThrough,
  //                               fontWeight: FontWeight.w400,
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _buildCuratedCard(
      String title,
      String description,
      String price,
      String badge,
      String imageUrl,
      bool isDark,
      Color badgeColor, {
        String? originalPrice,
      }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.network(
              imageUrl,
              height: 140,
              width: 140,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 140,
                  width: 140,
                  color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: badgeColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      badge,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: badgeColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.grey : Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      if (originalPrice != null) ...[
                        const SizedBox(width: 6),
                        Text(
                          originalPrice,
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark ? Colors.grey : Colors.grey.shade500,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Explore",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        size: 14,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}