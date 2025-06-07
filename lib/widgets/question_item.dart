import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mirim_pay/pages/main/models/question_model.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';

class QuestionItem extends StatefulWidget {
  final QuestionModel question;

  const QuestionItem({
    super.key,
    required this.question,
  });

  @override
  State<QuestionItem> createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colors.gray100,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            behavior: HitTestBehavior.translucent,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.question.question,
                    style: Typo.bodyMd(context, color: colors.gray800),
                  ),
                ),
                SvgPicture.asset(
                  isExpanded ? 'assets/icons/arrow_up.svg' : 'assets/icons/arrow_down.svg',
                  colorFilter: ColorFilter.mode(colors.gray400, BlendMode.srcIn),
                ),
              ],
            ),
          ),
          if (isExpanded && widget.question.answer != null) ...[
            const SizedBox(height: 16),
            Text(
              widget.question.answer!,
              style: Typo.bodySm(context, color: colors.gray700),
            ),
            const SizedBox(height: 12),
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.question.category,
                style: Typo.caption(context, color: colors.gray500),
              ),
              const SizedBox(height: 8),
              Text(
                widget.question.date,
                style: Typo.caption(context, color: colors.gray400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
