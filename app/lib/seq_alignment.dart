import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:super_tooltip/super_tooltip.dart';

Color colorForBase(String base) {
  switch (base) {
    case 'A':
      return Colors.green;
    case 'T':
      return Colors.blue;
    case 'C':
      return Colors.orange;
    case 'G':
      return Colors.red;
    default:
      return Colors.grey; // For any other character
  }
}

class RichSeq extends StatefulWidget {
  final String seq;
  final String fontFamily;
  final bool preferBelow;
  final bool forwards;
  final int startIndex;
  final int endIndex;

  const RichSeq({
    super.key,
    required this.seq,
    this.fontFamily = 'Courier New',
    this.preferBelow = false,
    this.forwards = true,
    this.startIndex = 0,
    this.endIndex = 0,
  });

  @override
  State<RichSeq> createState() => RichSeqState();
}

enum SelectMode {
  inactive,
  select,
  deselect,
}

class RichSeqState extends State<RichSeq> {
  final Set<int> selectedIndices = {};
  final Set<int> hoverIndices = {};
  SelectMode selectMode = SelectMode.inactive;

  Widget basePairs(BuildContext context, String seq) => IntrinsicWidth(
    child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: seq
            .split('')
            .mapIndexed((index, base) => BasePair(
                  index: index,
                  base: base,
                  preferBelow: widget.preferBelow,
                  fontFamily: widget.fontFamily,
                  isHovering: hoverIndices.contains(index),
                  isSelected: selectedIndices.contains(index),
                  isFirstSelectedBP: !selectedIndices.contains(index - 1) &&
                      !hoverIndices.contains(index - 1),
                  isFinalSelectedBP: !selectedIndices.contains(index + 1) &&
                      !hoverIndices.contains(index + 1),
                  onHoverStart: () => setState(() {
                    if (selectMode == SelectMode.select) {
                      selectedIndices.add(index);
                    } else {
                      if (selectMode == SelectMode.deselect) {
                        selectedIndices.remove(index);
                      }
                      hoverIndices.add(index);
                    }
                  }),
                  onHoverEnd: () => setState(() {
                    hoverIndices.remove(index);
                  }),
                  onTap: () => setState(() {
                    //print('Base tapped: $base at index $index');
                    if (selectedIndices.contains(index)) {
                      selectedIndices.remove(index);
                    } else {
                      selectedIndices.add(index);
                    }
                  }),
                  onPanStart: (e, rmb) => setState(() {
                    //print('onPanStart rmb=$rmb $index $base');
                    if (rmb) {
                      selectMode = SelectMode.deselect;
                      selectedIndices.remove(index);
                    } else {
                      selectMode = SelectMode.select;
                      selectedIndices.add(index);
                    }
                  }),
                  onPanUpdate: (e, rmb) {
                    //print('onPanUpdate rmb=$rmb $index $base');
                  },
                  onPanEnd: (e, rmb) => setState(() {
                    //print('onPanEnd rmb=$rmb $index $base');
                    selectMode = SelectMode.inactive;
                  }),
                ))
            .toList()),
  );

  Widget buildCounters(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildCounter(context, widget.startIndex),
      buildCounter(context, widget.endIndex),
    ],
  );

  Widget buildCounter(BuildContext context, int index) => Opacity(
    opacity: 0.5,
    child: Text(
      index.toString(),
      style: Theme.of(context)
          .textTheme
          .bodySmall!
          .copyWith(fontFamily: widget.fontFamily, fontSize: 10),
    ),
  );

  Widget buildTicks(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 9.0),
          child: Container(
            width: 1,
            height: 16,
            color: Colors.white.withAlpha(24),
          ),
        ),
      ],
    );
  }

  Widget buildLabel(BuildContext context, String label) => Opacity(
        opacity: 0.5,
        child: SizedBox(
          width: 28,
          height: 28,
          child: Center(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontFamily: widget.fontFamily,
                    fontSize: 14,
                    color: Colors.white.withAlpha(128),
                  ),
            ),
          ),
        ),
      );

  String get prefix => widget.forwards ? '5\'' : '3\'';
  String get suffix => widget.forwards ? '3\'' : '5\'';

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: IntrinsicWidth(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLabel(context, prefix),
            Stack(
              children: [
                buildTicks(context),
                IntrinsicWidth(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (!widget.preferBelow) buildCounters(context),
                      basePairs(context, widget.seq),
                      if (widget.preferBelow) buildCounters(context),
                    ],
                  ),
                ),
              ],
            ),
            buildTicks(context),
            buildLabel(context, suffix),
          ],
        ),
      ),
    );
  }
}

class BasePair extends StatefulWidget {
  final int index;
  final String base;
  final String fontFamily;
  final bool isHovering;
  final bool isSelected;
  final Function onTap;
  final Function onHoverStart;
  final Function onHoverEnd;
  final bool isFirstSelectedBP;
  final bool isFinalSelectedBP;
  final Function(DragStartDetails, bool) onPanStart;
  final Function(DragUpdateDetails, bool) onPanUpdate;
  final Function(DragEndDetails, bool) onPanEnd;
  final bool preferBelow;

  const BasePair({
    super.key,
    required this.index,
    required this.base,
    required this.onTap,
    required this.onHoverStart,
    required this.onHoverEnd,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
    this.fontFamily = 'Courier New',
    this.isHovering = false,
    this.isSelected = false,
    this.isFirstSelectedBP = false,
    this.isFinalSelectedBP = false,
    this.preferBelow = false,
  });

  @override
  State<BasePair> createState() => _BasePairState();
}

class _BasePairState extends State<BasePair> {
  final Color activeColor = Colors.grey[200]!;
  static const borderRadius = 4.0;
  final _controller = SuperTooltipController();

  bool shouldBuildCounter() {
    return widget.index % 10 == 0;
  }

  Widget buildCounter(BuildContext context) => Container(
        width: 18,
        height: 18,
        color: Colors.red,
        child: Center(child: Text((widget.index + 190).toString())),
      );

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        TapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
          () => TapGestureRecognizer(),
          (instance) {
            instance.onTap = () => widget.onTap();
          },
        ),
        PanGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>(
          () => PanGestureRecognizer(
            allowedButtonsFilter: (buttons) => buttons == kPrimaryButton,
          ),
          (instance) {
            instance.onStart = (e) => widget.onPanStart(e, false);
            instance.onUpdate = (e) => widget.onPanUpdate(e, false);
            instance.onEnd = (e) => widget.onPanEnd(e, false);
          },
        ),
      },
      child: RawGestureDetector(
        gestures: {
          PanGestureRecognizer:
              GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>(
            () => PanGestureRecognizer(
              allowedButtonsFilter: (buttons) => buttons == kSecondaryButton,
            ),
            (instance) {
              instance.onStart = (e) => widget.onPanStart(e, true);
              instance.onUpdate = (e) => widget.onPanUpdate(e, true);
              instance.onEnd = (e) => widget.onPanEnd(e, true);
            },
          ),
        },
        child: MouseRegion(
          onEnter: (_) async {
            widget.onHoverStart();
            await _controller.showTooltip();
          },
          onExit: (_) async {
            widget.onHoverEnd();
            await _controller.hideTooltip();
          },
          child: Stack(
            children: [
              /*
              IgnorePointer(
                child: Center(
                  child: SuperTooltip(
                    showBarrier: false,
                    content: Text((widget.index + 1).toString()),
                    controller: _controller,
                    showOnTap: false,
                    toggleOnTap: false,
                    popupDirection: widget.preferBelow
                        ? TooltipDirection.down
                        : TooltipDirection.up,
                    child: Container(
                      width: 18,
                      height: 18,
                      //color: Colors.red,
                    ),
                  ),
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.all(0.25),
                child: AnimatedContainer(
                  width: 18,
                  height: 18,
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: widget.isSelected
                        ? widget.isHovering
                            ? activeColor.withAlpha(255)
                            : activeColor.withAlpha(200)
                        : widget.isHovering
                            ? activeColor.withAlpha(128)
                            : Colors.transparent,
                    borderRadius: BorderRadius.only(
                      bottomLeft: widget.isFirstSelectedBP
                          ? const Radius.circular(borderRadius)
                          : Radius.zero,
                      bottomRight: widget.isFinalSelectedBP
                          ? const Radius.circular(borderRadius)
                          : Radius.zero,
                      topLeft: widget.isFirstSelectedBP
                          ? const Radius.circular(borderRadius)
                          : Radius.zero,
                      topRight: widget.isFinalSelectedBP
                          ? const Radius.circular(borderRadius)
                          : Radius.zero,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Center(
                      child: Text(
                        widget.base.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontFamily: widget.fontFamily,
                              fontSize: 16.0,
                              fontWeight: widget.isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              color: colorForBase(widget.base),
                              height: 1.0,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
