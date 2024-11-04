import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'dart:math' as math;

class CustomScrollPhysics extends ScrollPhysics {
  const CustomScrollPhysics({super.parent});

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    logger.info("ttttttt来了aaaaaaaa");

    // 增加用户拖动的偏移量
    return offset * 1.3; // 乘以一个大于1的系数来增加滚动距离
  }

  @override
  double get dragStartDistanceMotionThreshold => 1.0; // 将拖动开始的阈值设置为0，增加灵敏度

  double get friction => 0.05; // 调整摩擦力，以改变滚动的减速特性
}

// 隐藏滚动条用
class CustomScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    logger.info("ttttttt来了ttttttttttt");

    return const CustomScrollPhysics();
    // return const CustomScrollPhysics().applyTo(const MyBouncingScrollPhysics());
  }
}

// 弹性
class MyBouncingScrollPhysics extends ScrollPhysics {
  /// Creates scroll physics that bounce back from the edge.
  const MyBouncingScrollPhysics({
    this.decelerationRate = ScrollDecelerationRate.fast,
    super.parent,
  });

  /// Used to determine parameters for friction simulations.
  final ScrollDecelerationRate decelerationRate;

  @override
  BouncingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    logger.info("ttttttt来了22");

    return BouncingScrollPhysics(
        parent: buildParent(ancestor), decelerationRate: decelerationRate);
  }

  /// The multiple applied to overscroll to make it appear that scrolling past
  /// the edge of the scrollable contents is harder than scrolling the list.
  /// This is done by reducing the ratio of the scroll effect output vs the
  /// scroll gesture input.
  ///
  /// This factor starts at 0.52 and progressively becomes harder to overscroll
  /// as more of the area past the edge is dragged in (represented by an increasing
  /// `overscrollFraction` which starts at 0 when there is no overscroll).
  /// 拖拽的时候的弹性
  double frictionFactor(double overscrollFraction) {
    // return 0;
    logger.info("ttttttt来了tttttttttwwwwwwww");

    return math.pow(1 - overscrollFraction, 2) *
        switch (decelerationRate) {
          ScrollDecelerationRate.fast => 3,
          ScrollDecelerationRate.normal => 0.52,
        };
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    logger.info("ttttttt来了");

    assert(offset != 0.0);
    assert(position.minScrollExtent <= position.maxScrollExtent);

    if (!position.outOfRange) {
      return offset;
    }

    final double overscrollPastStart =
        math.max(position.minScrollExtent - position.pixels, 0.0);
    final double overscrollPastEnd =
        math.max(position.pixels - position.maxScrollExtent, 0.0);
    final double overscrollPast =
        math.max(overscrollPastStart, overscrollPastEnd);
    final bool easing = (overscrollPastStart > 0.0 && offset < 0.0) ||
        (overscrollPastEnd > 0.0 && offset > 0.0);

    final double friction = easing
        // Apply less resistance when easing the overscroll vs tensioning.
        ? frictionFactor(
            (overscrollPast - offset.abs()) / position.viewportDimension)
        : frictionFactor(overscrollPast / position.viewportDimension);
    final double direction = offset.sign;

    if (easing && decelerationRate == ScrollDecelerationRate.fast) {
      return direction * offset.abs();
    }
    return direction * _applyFriction(overscrollPast, offset.abs(), friction);
  }

  static double _applyFriction(
      double extentOutside, double absDelta, double gamma) {
    logger.info("ttttttt来了333");

    assert(absDelta > 0);
    double total = 0.0;
    if (extentOutside > 0) {
      final double deltaToLimit = extentOutside / gamma;
      if (absDelta < deltaToLimit) {
        return absDelta * gamma;
      }
      total += extentOutside;
      absDelta -= deltaToLimit;
    }
    return total + absDelta;
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    logger.info("ttttttt来了444");
    return 0.0;
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    logger.info("ttttttt来了55555");

    final Tolerance tolerance = toleranceFor(position);
    if (velocity.abs() >= tolerance.velocity || position.outOfRange) {
      return BouncingScrollSimulation(
        spring: spring,
        position: position.pixels,
        velocity: velocity,
        leadingExtent: position.minScrollExtent,
        trailingExtent: position.maxScrollExtent,
        tolerance: tolerance,
        constantDeceleration: switch (decelerationRate) {
          ScrollDecelerationRate.fast => 1400,
          ScrollDecelerationRate.normal => 0,
        },
      );
    }
    return null;
  }

  // The ballistic simulation here decelerates more slowly than the one for
  // MyClampingScrollPhysics so we require a more deliberate input gesture
  // to trigger a fling.
  @override
  double get minFlingVelocity {
    logger.info("ttttttt来了gaa");

    return kMinFlingVelocity * 2.0;
  }

  // Methodology:
  // 1- Use https://github.com/flutter/platform_tests/tree/master/scroll_overlay to test with
  //    Flutter and platform scroll views superimposed.
  // 3- If the scrollables stopped overlapping at any moment, adjust the desired
  //    output value of this function at that input speed.
  // 4- Feed new input/output set into a power curve fitter. Change function
  //    and repeat from 2.
  // 5- Repeat from 2 with medium and slow flings.
  /// Momentum build-up function that mimics iOS's scroll speed increase with repeated flings.
  ///
  /// The velocity of the last fling is not an important factor. Existing speed
  /// and (related) time since last fling are factors for the velocity transfer
  /// calculations.
  @override
  double carriedMomentum(double existingVelocity) {
    logger.info("ttttttt来了pppppppppp");

    return existingVelocity.sign *
        math.min(0.000816 * math.pow(existingVelocity.abs(), 1.967).toDouble(),
            40000.0);
  }

  // Eyeballed from observation to counter the effect of an unintended scroll
  // from the natural motion of lifting the finger after a scroll.
  @override
  double get dragStartDistanceMotionThreshold => 3.5;

  @override
  double get maxFlingVelocity {
    return switch (decelerationRate) {
      ScrollDecelerationRate.fast => kMaxFlingVelocity * 8.0,
      ScrollDecelerationRate.normal => super.maxFlingVelocity,
    };
  }

  @override
  SpringDescription get spring {
    logger.info("ttttttt来了77777777");

    switch (decelerationRate) {
      case ScrollDecelerationRate.fast:
        return SpringDescription.withDampingRatio(
          mass: 0.3,
          stiffness: 75.0,
          ratio: 1.3,
        );
      case ScrollDecelerationRate.normal:
        return super.spring;
    }
  }
}

// 正常滚动
class MyClampingScrollPhysics extends ScrollPhysics {
  /// Creates scroll physics that prevent the scroll offset from exceeding the
  /// bounds of the content.
  const MyClampingScrollPhysics({super.parent});

  @override
  MyClampingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    logger.info("ccccccccccc来了1111111111");
    return MyClampingScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    logger.info("ccccccccccc来了2222222222222");

    // return 500.w;
    assert(() {
      if (value == position.pixels) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary(
              '$runtimeType.applyBoundaryConditions() was called redundantly.'),
          ErrorDescription(
            'The proposed new position, $value, is exactly equal to the current position of the '
            'given ${position.runtimeType}, ${position.pixels}.\n'
            'The applyBoundaryConditions method should only be called when the value is '
            'going to actually change the pixels, otherwise it is redundant.',
          ),
          DiagnosticsProperty<ScrollPhysics>(
              'The physics object in question was', this,
              style: DiagnosticsTreeStyle.errorProperty),
          DiagnosticsProperty<ScrollMetrics>(
              'The position object in question was', position,
              style: DiagnosticsTreeStyle.errorProperty),
        ]);
      }
      return true;
    }());

    logger.info("ccccccccccc来了2222222222222a");

    if (value < position.pixels &&
        position.pixels <= position.minScrollExtent) {
      // Underscroll.
      logger.info("ccccccccccc来了2222222222222aUnderscroll.");

      return value - position.pixels;
    }
    if (position.maxScrollExtent <= position.pixels &&
        position.pixels < value) {
      // Overscroll.
      logger.info("ccccccccccc来了2222222222222aOverscroll.");

      return value - position.pixels;
    }
    if (value < position.minScrollExtent &&
        position.minScrollExtent < position.pixels) {
      // Hit top edge.
      logger.info("ccccccccccc来了2222222222222aHit top edge.");

      return value - position.minScrollExtent;
    }
    if (position.pixels < position.maxScrollExtent &&
        position.maxScrollExtent < value) {
      // Hit bottom edge.
      logger.info("ccccccccccc来了2222222222222aHit bottom edge.");

      return value - position.maxScrollExtent;
    }
    return 0.0;
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    logger.info("ccccccccccc来了333333333333");

    final Tolerance tolerance = toleranceFor(position);
    if (position.outOfRange) {
      double? end;
      if (position.pixels > position.maxScrollExtent) {
        end = position.maxScrollExtent;
      }
      if (position.pixels < position.minScrollExtent) {
        end = position.minScrollExtent;
      }
      assert(end != null);
      return ScrollSpringSimulation(
        spring,
        position.pixels,
        end!,
        math.min(0.0, velocity),
        tolerance: tolerance,
      );
    }
    if (velocity.abs() < tolerance.velocity) {
      logger.info("qqqqqqqqq velocity.abs() < tolerance.velocity");
      return null;
    }
    if (velocity > 0.0 && position.pixels >= position.maxScrollExtent) {
      logger.info(
          "qqqqqqqqq velocity > 0.0 && position.pixels >= position.maxScrollExtent");
      return null;
    }
    if (velocity < 0.0 && position.pixels <= position.minScrollExtent) {
      logger.info(
          "qqqqqqqqq velocity < 0.0 && position.pixels <= position.minScrollExtent");
      return null;
    }

    // logger.info("qqqqqqqqqqqqqqqqqqq: ${velocity}");

    return ClampingScrollSimulation(
      position: position.pixels,
      velocity: velocity,
      tolerance: tolerance,
    );

    // return null;
  }
}
