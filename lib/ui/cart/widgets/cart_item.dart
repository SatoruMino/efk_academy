part of '../page/cart_page.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // .. image
          CachedNetworkImage(
            height: 100.h,
            width: 100.h,
            imageUrl: cart.courseImageUrl!,
            fit: BoxFit.cover,
          ),

          // .. info
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ..name
                Text(
                  cart.courseName!,
                  style: Theme.of(context).textTheme.labelMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                // .. price
                const SizedBox(height: 4),
              ],
            ),
          ),

          // ..remove
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.remove_circle_outline,
            ),
          ),
        ],
      ),
    );
  }
}
