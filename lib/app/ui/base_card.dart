import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:focus/app/ui/app_colors.dart';

class BaseCard extends StatelessWidget {
  const BaseCard(
    this.params, {
    super.key,
  });
  final BaseCardParams params;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: params.onTap,
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          params.onChanged?.call();
        }
        if (details.primaryVelocity! < 0) {
          params.onChanged?.call();
        }
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: params.color ?? AppColors.defaultCardColor,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: 10,
              cornerSmoothing: 1,
            ),
          ),
          //borderRadius: BorderRadius.circular(14),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              child: Row(
                children: [
                  if (params.isInProgress == true) ...[
                    const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          params.title,
                          style: textTheme.bodyMedium?.copyWith(
                            decoration: params.hasBeenDismissed
                                ? TextDecoration.lineThrough
                                : null,
                            color: Colors.white
                                .withOpacity(params.hasBeenDismissed ? 0.5 : 1),
                          ),
                        ),
                        if (params.subtitle != null) ...[
                          Text(
                            params.subtitle!,
                            style: textTheme.bodySmall,
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (params.onChanged != null) ...[
                    RightIconButton(
                      onTap: params.openOptions,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RightIconButton extends StatelessWidget {
  const RightIconButton({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: const Icon(
        Icons.arrow_right,
        color: AppColors.primaryColor,
      ),
    );
  }
}

class CheckBox extends StatelessWidget {
  const CheckBox({
    required this.onChanged,
    required this.value,
    super.key,
  });

  final VoidCallback onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged,
      child: Container(
        width: 18,
        height: 18,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          border: Border.fromBorderSide(
            BorderSide(
              width: 0.5,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        child: value
            ? const Center(
                child: Icon(
                  Icons.check,
                  size: 12,
                  color: AppColors.primaryColor,
                ),
              )
            : null,
      ),
    );
  }
}

class BaseCardParams {
  BaseCardParams({
    required this.title,
    this.subtitle,
    this.color,
    this.isInProgress,
    this.onTap,
    this.openOptions,
    this.onChanged,
    this.hasBeenDismissed = false,
  });

  final String title;
  final String? subtitle;
  final Color? color;
  final bool? isInProgress;
  final VoidCallback? onTap;
  final VoidCallback? openOptions;
  final VoidCallback? onChanged;
  final bool hasBeenDismissed;
}
