import 'package:flutter/material.dart';
import 'package:ultimate_flutter_icons/flutter_icons.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey cartKey;

  const Header({
    super.key,
    required this.cartKey,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final textStyleCatalog = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,

      titleSpacing: 23,

      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "ShopVerse",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
              color: Colors.black,
            ),
          ),

          if (MediaQuery.sizeOf(context).width > 633)
            Row(
              children: [
                Text("About", style: textStyleCatalog),
                const SizedBox(width: 23),
                Text("Shop", style: textStyleCatalog),
                const SizedBox(width: 23),
                Text("Categories", style: textStyleCatalog),
                const SizedBox(width: 23),
                Text("Help", style: textStyleCatalog),
              ],
            ),

          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(23),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    FIcon(
                      MD.MdSearch,
                      size: 22,
                    ),

                    const SizedBox(width: 8),

                    Text(
                      "Search",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(width: 15),

              FIcon(
                MD.MdFavoriteBorder,
                size: 28,
              ),

              const SizedBox(width: 15),

              FIcon(
                MD.MdOutlineShoppingBag,
                key: cartKey,
                size: 28,
              ),
            ],
          )
        ],
      ),
    );
  }
}