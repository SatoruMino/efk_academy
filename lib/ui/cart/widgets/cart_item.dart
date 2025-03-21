part of '../page/cart_page.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.cart,
    required this.onRemove,
  });

  final Cart cart;
  final Function(String) onRemove;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
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
                      style: textTheme.labelLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // .. price
                    const SizedBox(height: 4),
                    if (cart.courseDiscount! > 0)
                      Row(
                        children: [
                          Text(
                            '\$${findPrice(cart.coursePrice!, cart.courseDiscount!).toStringAsFixed(2)}',
                            style: textTheme.displayMedium,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '\$${cart.coursePrice!.toStringAsFixed(2)}',
                            style: textTheme.labelMedium?.copyWith(
                                decoration: TextDecoration.lineThrough),
                          ),
                        ],
                      )
                    else
                      Text(
                        '\$${cart.coursePrice!.toStringAsFixed(2)}',
                        style: textTheme.displayMedium,
                      ),
                  ],
                ),
              ),
              // ..remove
              IconButton(
                onPressed: () => onRemove(cart.id),
                icon: Icon(
                  Icons.close_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          CustomButton(
            text: 'purchase_now'.tr(),
            style: CustomButtonStyle.primary(context),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
