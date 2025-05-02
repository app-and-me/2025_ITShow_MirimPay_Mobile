import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';
import 'package:mirim_pay/widgets/DateFilterBottomSheet.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  int _selectedCategoryIndex = 0;
  String _selectedDateFilter = '오늘';
  final List<String> _categories = ['전체', '재고', '입고', '품절', '운영', '그 외'];
  final ScrollController _scrollController = ScrollController();
  bool _showDivider = false;

  final List<Map<String, dynamic>> _allQuestions = [
    {
      'question': '초코소라빵 재고 입고됐나요?',
      'date': '2025.04.21',
      'category': '재고',
      'answer': '네~ 어제 20개 정도 입고됐습니다'
    },
    {
      'question': '크림빵 품절인가요?',
      'date': '2025.04.21',
      'category': '품절',
      'answer': '오후 2시까지 20개 재고 있습니다'
    },
    {
      'question': '바게트 추가 재고 확인 가능한가요?',
      'date': '2025.04.21',
      'category': '재고',
      'answer': '현재 10개 남아있습니다'
    },
    {
      'question': '최애빵 입고 언제 되나요?',
      'date': '2025.04.14',
      'category': '입고',
      'answer': '내일 오전 10시 입고 예정입니다'
    },
    {
      'question': '영업 시간이 어떻게 되나요?',
      'date': '2025.04.16',
      'category': '운영',
      'answer': '평일은 오전 9시부터 오후 9시까지, 주말은 오전 10시부터 오후 8시까지 운영합니다'
    },
    {
      'question': '빵 맛이 너무 좋아요!',
      'date': '2025.04.15',
      'category': '그 외',
      'answer': '감사합니다. 더 맛있는 빵으로 보답하겠습니다'
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final shouldShowDivider = _scrollController.offset > 10;
    if (shouldShowDivider != _showDivider) {
      setState(() {
        _showDivider = shouldShowDivider;
      });
    }
  }

  List<Map<String, dynamic>> _getFilteredQuestions() {
    final String selectedCategory = _categories[_selectedCategoryIndex];
    if (_selectedCategoryIndex == 0) {
      return _allQuestions;
    }
    return _allQuestions.where((q) => q['category'] == selectedCategory).toList();
  }

  Map<String, List<Map<String, dynamic>>> _groupQuestionsByDate(List<Map<String, dynamic>> questions) {
    final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final weekAgo = today.subtract(const Duration(days: 7));
    final monthAgo = today.subtract(const Duration(days: 30));

    final todayQuestions = <Map<String, dynamic>>[];
    final recentQuestions = <Map<String, dynamic>>[];
    final monthlyQuestions = <Map<String, dynamic>>[];

    for (var question in questions) {
      final parts = question['date'].split('.');
      if (parts.length == 3) {
        final year = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final day = int.parse(parts[2]);
        final questionDate = DateTime(year, month, day);

        if (questionDate.year == today.year &&
            questionDate.month == today.month &&
            questionDate.day == today.day) {
          todayQuestions.add(question);
        } else if (questionDate.isAfter(weekAgo)) {
          recentQuestions.add(question);
        } else if (questionDate.isAfter(monthAgo)) {
          monthlyQuestions.add(question);
        }
      }
    }

    return {
      '오늘': todayQuestions,
      '최근 7일': recentQuestions,
      '최근 1개월': monthlyQuestions,
    };
  }

  void _showDateFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => DateFilterBottomSheet(
        currentFilter: _selectedDateFilter,
        onFilterSelected: (String filter) {
          setState(() {
            _selectedDateFilter = filter;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    final filteredQuestions = _getFilteredQuestions();
    final groupedQuestions = _groupQuestionsByDate(filteredQuestions);
    
    List<QuestionItem> questionItems = [];
    if (_selectedDateFilter == '오늘') {
      questionItems = (groupedQuestions['오늘'] ?? [])
          .map((q) => QuestionItem(
                question: q['question'],
                date: q['date'],
                category: q['category'],
                answer: q['answer'],
              ))
          .toList();
    } else if (_selectedDateFilter == '최근 7일') {
      questionItems = [
        ...(groupedQuestions['오늘'] ?? []),
        ...(groupedQuestions['최근 7일'] ?? []),
      ]
          .map((q) => QuestionItem(
                question: q['question'],
                date: q['date'],
                category: q['category'],
                answer: q['answer'],
              ))
          .toList();
    } else if (_selectedDateFilter == '최근 1개월') {
      questionItems = [
        ...(groupedQuestions['오늘'] ?? []),
        ...(groupedQuestions['최근 7일'] ?? []),
        ...(groupedQuestions['최근 1개월'] ?? []),
      ]
          .map((q) => QuestionItem(
                question: q['question'],
                date: q['date'],
                category: q['category'],
                answer: q['answer'],
              ))
          .toList();
    }

    return Scaffold(
      backgroundColor: colors.gray50,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: Text(
            '문의',
            style: Typo.headlineLg(context, color: colors.gray900),
          ),
          centerTitle: false,
          actions: [
            IconButton(
              icon: SvgPicture.asset('assets/icons/search.svg', color: colors.gray900),
              onPressed: () {},
            ),
          ],
          backgroundColor: colors.gray50,
          scrolledUnderElevation: 0,
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 120.0),
        child: Container(
          width: 92,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: colors.primary, width: 1),
          ),
          child: FloatingActionButton.extended(
            backgroundColor: colors.gray50,
            elevation: 0,
            onPressed: () {},
            label: Text(
              '문의하기',
              style: Typo.bodySm(context, color: colors.primary)
                  .copyWith(fontWeight: FontWeight.w400),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Column(
        children: [
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: List.generate(
                _categories.length,
                (index) => CategoryTab(
                  text: _categories[index],
                  isSelected: _selectedCategoryIndex == index,
                  onTap: () {
                    setState(() {
                      _selectedCategoryIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 0),
            height: 32,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: _showDivider ? colors.gray200 : Colors.transparent,
                  width: 1,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 150,
                top: 16,
              ),
              children: [
                DateFilterHeader(
                  title: _selectedDateFilter,
                  onTap: _showDateFilterBottomSheet,
                ),
                const SizedBox(height: 16),
                if (questionItems.isEmpty) ...[
                  Container(
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
                        Text(
                          '문의 내역이 없습니다',
                          style: Typo.bodyMd(context, color: colors.gray800),
                        ),
                      ],
                    ),
                  ),
                ]
                else ...questionItems,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryTab extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryTab({
    super.key,
    required this.text,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: Typo.headlineSub(
                context,
                color: isSelected ? colors.gray900 : colors.gray400,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 35,
              height: 1,
              child: Container(
                color: isSelected ? colors.gray900 : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateFilterHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const DateFilterHeader({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: Typo.bodyMd(context, color: colors.gray700),
          ),
          const SizedBox(width: 5),
          SvgPicture.asset(
            'assets/icons/arrow_down.svg',
            width: 16,
            height: 16,
            color: colors.gray700,
          ),
        ],
      ),
    );
  }
}

class QuestionItem extends StatefulWidget {
  final String question;
  final String date;
  final String? answer;
  final String category;

  const QuestionItem({
    super.key,
    required this.question,
    required this.date,
    required this.category,
    this.answer,
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
                    widget.question,
                    style: Typo.bodyMd(context, color: colors.gray800),
                  ),
                ),
                SvgPicture.asset(
                  isExpanded ? 'assets/icons/arrow_up.svg' : 'assets/icons/arrow_down.svg',
                  color: colors.gray400,
                ),
              ],
            ),
          ),
          if (isExpanded && widget.answer != null) ...[
            const SizedBox(height: 16),
            Text(
              widget.answer!,
              style: Typo.bodySm(context, color: colors.gray700),
            ),
            const SizedBox(height: 12),
          ],
          const SizedBox(height: 8),
          Text(
            widget.date,
            style: Typo.caption(context, color: colors.gray400),
          ),
        ],
      ),
    );
  }
}