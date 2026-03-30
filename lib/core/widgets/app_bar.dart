import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    this.title,
    this.actions,
    this.showBackButton = false,
    this.onBackPressed,
    this.centerTitle = false,
    this.leading,
    this.backgroundColor,
    this.elevation = 0,
    this.boldTitle = false,
  });

  final String? title;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final bool centerTitle;
  final Widget? leading;
  final Color? backgroundColor;
  final double elevation;
  final bool boldTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final hasLeading = leading != null || showBackButton;
    final hasActions = actions != null && actions!.isNotEmpty;

    return SafeArea(
      bottom: false,
      child: Material(
        color: backgroundColor ?? theme.colorScheme.background,
        elevation: elevation,
        child: SizedBox(
          height: preferredSize.height,
          child: Row(
            children: [
              /// 🔹 Leading (fixed width → prevents shift)
              SizedBox(
                width: 56,
                child: hasLeading
                    ? leading ??
                          ShadIconButton.ghost(
                            onPressed: onBackPressed ?? Get.back,
                            icon: const Icon(LucideIcons.arrowLeft),
                          )
                    : null,
              ),

              /// 🔹 Title
              Expanded(
                child: Align(
                  alignment: centerTitle
                      ? Alignment.center
                      : Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: title != null
                        ? Text(
                            title!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: boldTitle
                                  ? FontWeight.w700
                                  : FontWeight.w600,
                            ),
                          )
                        : const SizedBox(),
                  ),
                ),
              ),

              /// 🔹 Actions (fixed min width)
              SizedBox(
                width: hasActions ? null : 56,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (hasActions)
                      ...actions!.map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: e,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
