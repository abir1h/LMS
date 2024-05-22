import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../../domain/entities/option_data_entity.dart';
import '../../domain/entities/question_data_entity.dart';
import '../models/matching_question.dart';
import 'dashed_border.dart';

class MatchingAnswerWidget extends StatefulWidget {
  final QuestionDataEntity data;
  final Function(int optionDataId, String value)? onMatched;
  const MatchingAnswerWidget({Key? key, required this.data, this.onMatched})
      : super(key: key);

  @override
  State<MatchingAnswerWidget> createState() => _MatchingAnswerWidgetState();
}

class _MatchingAnswerWidgetState extends State<MatchingAnswerWidget>
    with AppTheme, Language {
  List<MatchingLeftSide> leftSideList = [];
  List<MatchingRightSide> rightSideList = [];

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _setData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  _setData() {
    for (OptionDataEntity optionDataEntity in widget.data.options) {
      MatchingLeftSide matchingLeftSide = MatchingLeftSide(
          id: optionDataEntity.id,
          leftSide: optionDataEntity.optionKey,
          selectedRightSide: MatchingRightSide(),
          mark: 1);
      MatchingRightSide matchingRightSide = MatchingRightSide(
          index: widget.data.options.indexOf(optionDataEntity) + 1,
          isUsed: false,
          rightSideText: optionDataEntity.optionValue);
      leftSideList.add(matchingLeftSide);
      rightSideList.add(matchingRightSide);
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.r8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ///LHS and RHS receiver
          SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            child: Row(
              children: leftSideList
                  .asMap()
                  .map((key, lhs) => MapEntry(
                      key,
                      Container(
                        width: 1.sw * 0.75,
                        margin: EdgeInsets.only(right: size.w16),
                        padding: EdgeInsets.symmetric(
                            horizontal: size.w12, vertical: size.h12),
                        decoration: BoxDecoration(
                          color: clr.drawerFillColor,
                          borderRadius: BorderRadius.circular(size.r16),
                          border: Border.all(
                              color: clr.cardStrokeColorBlue, width: size.r1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///LHS
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${key + 1}.  ",
                                  style: TextStyle(
                                      color: clr.blackColor,
                                      fontSize: size.textSmall,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: StringData.fontFamilyPoppins),
                                ),
                                Expanded(
                                  child: Text(
                                    lhs.leftSide,
                                    style: TextStyle(
                                        color: clr.blackColor,
                                        fontSize: size.textSmall,
                                        fontWeight: FontWeight.w500,
                                        fontFamily:
                                            StringData.fontFamilyPoppins),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: size.h28),

                            ///RHS
                            MatchingRHSReceiverWidget(
                              lhs: lhs,
                              onUpdate: () => setState(() {
                                widget.onMatched!(lhs.id,
                                    lhs.selectedRightSide.rightSideText);
                              }),
                            ),
                          ],
                        ),
                      )))
                  .values
                  .toList(),
            ),
          ),

          SizedBox(height: size.h20),

          ///drag hint text
          Text(
            label(e: en.dragAnOption, b: bn.dragAnOption),
            style: TextStyle(
              fontSize: size.textXMedium,
              color: clr.blackColor,
              fontWeight: FontWeight.w600,
              fontFamily: StringData.fontFamilyPoppins,
            ),
          ),

          SizedBox(height: size.h8),

          ///RHS
          SingleChildScrollView(
            child: Column(
              children: rightSideList
                  .asMap()
                  .map((key, value) {
                    value.index = key + 1;
                    return MapEntry(
                        key,
                        MatchingRHSSenderWidget(
                          scrollController: _scrollController,
                          rhs: value,
                        ));
                  })
                  .values
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class MatchingRHSReceiverWidget extends StatefulWidget {
  final MatchingLeftSide lhs;
  final VoidCallback onUpdate;
  const MatchingRHSReceiverWidget({
    Key? key,
    required this.lhs,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<MatchingRHSReceiverWidget> createState() =>
      _MatchingRHSReceiverWidgetState();
}

class _MatchingRHSReceiverWidgetState extends State<MatchingRHSReceiverWidget>
    with AppTheme, Language {
  bool _highlightAccept = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 100),
      scale: _highlightAccept ? 1.05 : 1.0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.w12),
        child: DashedRect(
          color: clr.textColorBlack,
          // strokeWidth: _highlightAccept ? 1.w : 0.6.w,
          // dashPattern: [size.s4, size.s4],
          // radius: Radius.circular(size.s8),
          // color: _highlightAccept ? clr.controlBgGreen : clr.textBlackDisable,
          child: DragTarget<MatchingRightSide>(
            onWillAccept: (rhs) {
              if (!(rhs?.isUsed ?? false)) {
                ///Update widget tree
                _highlightAccept = true;
                widget.onUpdate();
                return true;
              } else {
                ///Update widget tree
                _highlightAccept = false;
                widget.onUpdate();
                return false;
              }
            },
            onAccept: (rhs) {
              ///Release old option
              if (widget.lhs.selectedRightSide.index > 0) {
                widget.lhs.selectedRightSide.isUsed = false;
              }

              ///Lock new option
              rhs.isUsed = true;
              widget.lhs.selectedRightSide = rhs;

              ///Update widget tree
              _highlightAccept = false;
              widget.onUpdate();
            },
            onLeave: (x) {
              ///Update widget tree
              _highlightAccept = false;
              widget.onUpdate();
            },
            builder: (context, accepted, rejected) {
              return SizedBox(
                width: double.maxFinite,
                height: size.h42,
                child: Center(
                  child: widget.lhs.selectedRightSide.isUsed
                      ? Draggable<MatchingLeftSide>(
                          data: widget.lhs,
                          onDragCompleted: widget.onUpdate,
                          childWhenDragging: _buildDropBox(),
                          feedback: _buildRHSOption(),
                          child: _buildRHSOption(),
                        )
                      : _buildDropBox(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRHSOption() {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.w8, vertical: size.h8),
        decoration: BoxDecoration(
          color: clr.cardFillColorGreen,
          borderRadius: BorderRadius.circular(size.r8),
        ),
        child: Center(
          child: Text(
            widget.lhs.selectedRightSide.rightSideText,
            style: TextStyle(
                color: clr.blackColor,
                fontSize: size.textSmall,
                fontWeight: FontWeight.w500,
                fontFamily: StringData.fontFamilyPoppins),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _buildDropBox() {
    return Text(
      label(e: en.dropHere, b: bn.dropHere),
      style: TextStyle(
        fontSize: size.textSmall,
        color: clr.textColorGray,
        fontWeight: FontWeight.w600,
        fontFamily: StringData.fontFamilyPoppins,
      ),
    );
  }
}

class MatchingRHSSenderWidget extends StatefulWidget {
  final MatchingRightSide rhs;
  final ScrollController scrollController;
  const MatchingRHSSenderWidget({
    Key? key,
    required this.rhs,
    required this.scrollController
  }) : super(key: key);

  @override
  State<MatchingRHSSenderWidget> createState() =>
      _MatchingRHSSenderWidgetState();
}

class _MatchingRHSSenderWidgetState extends State<MatchingRHSSenderWidget>
    with AppTheme {
  bool _highlightAccept = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: size.h8),
      child: Listener(

        onPointerMove: (PointerMoveEvent event) {
          // print(event.position);
          // print(MediaQuery.of(context).size.width);
          // print(widget.scrollController.offset);
          if (event.position.dx > MediaQuery.of(context).size.width - 100) {
            // 120 is height of your draggable.
            widget.scrollController.jumpTo(widget.scrollController.offset + 20);
            // print(widget.scrollController.offset + 20);
          }
          // if (event.position.dx > 100) {
          //   // 120 is height of your draggable.
          //   widget.scrollController.jumpTo(widget.scrollController.offset - 20);
          //   print(widget.scrollController.offset - 20);
          // }
        },
        child: Draggable<MatchingRightSide>(
          data: widget.rhs,
          onDragCompleted: () => setState(() {}),
          feedback: Material(
            type: MaterialType.transparency,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7 - size.w32,
              padding:
                  EdgeInsets.symmetric(horizontal: size.w8, vertical: size.h8),
              decoration: BoxDecoration(
                color: clr.cardFillColorGreen,
                borderRadius: BorderRadius.circular(size.r8),
              ),
              child: Center(
                child: Text(
                  widget.rhs.rightSideText,
                  style: TextStyle(
                      color: clr.blackColor,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w500,
                      fontFamily: StringData.fontFamilyPoppins),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          childWhenDragging: Opacity(
            opacity: 0.3,
            child: _buildChild(),
          ),
          child: DragTarget<MatchingLeftSide>(
            onWillAccept: (lhs) {
              if ((lhs?.selectedRightSide.isUsed ?? false) &&
                  lhs!.selectedRightSide.index > 0 &&
                  lhs.selectedRightSide.index == widget.rhs.index) {
                setState(() {
                  _highlightAccept = true;
                });
                return true;
              } else {
                return false;
              }
            },
            onAccept: (lhs) {
              ///Release old option
              lhs.selectedRightSide.isUsed = false;
              lhs.selectedRightSide = MatchingRightSide();

              setState(() {
                _highlightAccept = false;
              });
            },
            onLeave: (x) {
              setState(() {
                _highlightAccept = false;
              });
            },
            builder: (context, accepted, rejected) => _buildChild(),
          ),
        ),
      ),
    );
  }

  Widget _buildChild() {
    return IgnorePointer(
      ignoring: widget.rhs.isUsed,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: _highlightAccept ? 1.03 : 1.0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.w12 * 5),
          child: DashedRect(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              // width: MediaQuery.of(context).size.width - (size.w24 * 2),
              padding: EdgeInsets.symmetric(
                  horizontal: size.w16, vertical: size.h12),
              decoration: BoxDecoration(
                color: widget.rhs.isUsed
                    ? clr.boxStrokeColor
                    : clr.cardFillColorGreen,
                borderRadius: BorderRadius.circular(size.r8),
              ),
              child: Center(
                child: Text(
                  widget.rhs.rightSideText,
                  style: TextStyle(
                      color: clr.blackColor,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w500,
                      fontFamily: StringData.fontFamilyPoppins),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
