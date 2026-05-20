import 'package:flutter/material.dart';

class ResponsiveHelper {
  static const double mobileMaxWidth = 600;
  static const double tabletMaxWidth = 900;
  static const double desktopMaxWidth = 1200;

  // Get responsive device type
  static DeviceType getDeviceType(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width < mobileMaxWidth) {
      return DeviceType.mobile;
    } else if (size.width < tabletMaxWidth) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  // Get effective width (constrained width for sizing calculations)
  static double getEffectiveWidth(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final actualWidth = size.width;
    
    if (actualWidth < mobileMaxWidth) {
      return actualWidth; // Mobile: use full width
    } else if (actualWidth < tabletMaxWidth) {
      return 550; // Tablet: constrained width
    } else {
      return 600; // Desktop: constrained width
    }
  }

  // Get responsive scale factor for components/icons
  static double getScaleFactor(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width < mobileMaxWidth) {
      return 1.0; // Mobile - normal size
    } else if (size.width < tabletMaxWidth) {
      return 0.9; // Tablet - slightly smaller
    } else {
      return 0.8; // Desktop - even smaller
    }
  }

  // Get responsive font scale
  static double getFontScale(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width < mobileMaxWidth) {
      return 1.0;
    } else if (size.width < tabletMaxWidth) {
      return 0.85;
    } else {
      return 0.75;
    }
  }

  // Get max width constraint
  static double getMaxWidth(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width < mobileMaxWidth) {
      return size.width;
    } else if (size.width < tabletMaxWidth) {
      return 550;
    } else {
      return 600;
    }
  }

  // Get responsive padding
  static EdgeInsets getResponsivePadding(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width < mobileMaxWidth) {
      return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
    } else if (size.width < tabletMaxWidth) {
      return const EdgeInsets.symmetric(horizontal: 20, vertical: 14);
    } else {
      return const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
    }
  }

  // Responsive width percentage - uses EFFECTIVE width instead of actual width
  static double getResponsiveWidth(
    BuildContext context,
    double percentageWidth,
  ) {
    final effectiveWidth = getEffectiveWidth(context);
    final scaleFactor = getScaleFactor(context);
    return (percentageWidth * effectiveWidth / 100) * scaleFactor;
  }

  // Better font sizing - uses effective width
  static double responsiveFontSize(
    BuildContext context,
    double baseFontSize,
  ) {
    final effectiveWidth = getEffectiveWidth(context);
    final fontScale = getFontScale(context);
    
    // Scale font based on effective width (not actual screen width)
    // Mobile 600px = 1.0 scale, smaller screens scale down
    final widthScale = effectiveWidth / 600;
    
    return baseFontSize * widthScale * fontScale;
  }

  // Icon/element sizing - uses effective width
  static double responsiveIconSize(
    BuildContext context,
    double baseIconSize,
  ) {
    final effectiveWidth = getEffectiveWidth(context);
    final scaleFactor = getScaleFactor(context);
    
    // Scale icon based on effective width
    final widthScale = effectiveWidth / 600;
    
    return baseIconSize * widthScale * scaleFactor;
  }
}

enum DeviceType { mobile, tablet, desktop }

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext, DeviceType) builder;

  const ResponsiveBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return builder(context, ResponsiveHelper.getDeviceType(context));
  }
}

class ResponsiveConstrainedBox extends StatelessWidget {
  final Widget child;
  final bool apply;

  const ResponsiveConstrainedBox({
    Key? key,
    required this.child,
    this.apply = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!apply) return child;

    final maxWidth = ResponsiveHelper.getMaxWidth(context);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}

class ResponsiveScaledText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const ResponsiveScaledText(
    this.text, {
    Key? key,
    required this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveHelper.getFontScale(context);
    final scaledStyle = style.copyWith(
      fontSize: (style.fontSize ?? 14) * scale,
    );

    return Text(
      text,
      style: scaledStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
