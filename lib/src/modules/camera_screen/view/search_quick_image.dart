import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../components/grade_chip_widget.dart';
import '../../../provider/bloc_provider/student_bloc/student_grade/student_grade_bloc.dart';
import '../../../res/color/app_color.dart';
import '../bloc/quick_image/quick_image_bloc.dart';
import '../components/search_quick_image_list.dart';

class SearchQuickImage extends StatefulWidget {
  const SearchQuickImage({super.key});

  @override
  State<SearchQuickImage> createState() => _SearchQuickImageState();
}

class _SearchQuickImageState extends State<SearchQuickImage> {
  String? selectGradeName;
  String? dateOnly;
  TextEditingController searchController = TextEditingController();
  String? searchQuickImageId;

  @override
  void initState() {
    super.initState();
    // Fetch all quick images and grades on initialization
    context.read<QuickImageBloc>().add(const GetAllQuickImageEvent());
    context.read<StudentGradeBloc>().add(GetStudentGrade());
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtil.tealColor[10],
        title: const Text('Search Quick Image'),
      ),
      body: Column(
        children: [
          // Search bar for Quick Image ID
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Enter Quick Image ID',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          setState(() {
                            searchQuickImageId = null;
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {
                  searchQuickImageId = value.isNotEmpty ? value : null;
                });
              },
            ),
          ),
          // Grade selection UI
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
            height: 80,
            child: BlocBuilder<StudentGradeBloc, StudentGradeState>(
              builder: (context, state) {
                if (state is GetStudentGradeSuccess) {
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectGradeName = null;
                          });
                        },
                        child: GradeChipWidget(
                          label: 'All Grades',
                          selected: selectGradeName == null,
                        ),
                      ),
                      ...state.getGradeList.map((grade) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectGradeName = grade.gradeName;
                            });
                          },
                          child: GradeChipWidget(
                            label: '${grade.gradeName} Grade',
                            selected: selectGradeName == grade.gradeName,
                          ),
                        );
                      }),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          // Display list of quick images based on selected grade and search ID
          Expanded(
            child: BlocBuilder<QuickImageBloc, QuickImageState>(
              builder: (context, state) {
                if (state is QuickImageGetSuccess) {
                  // Filter the list based on grade and search ID
                  final filteredImages = state.quickImageList!
                      .where((quickImageStudent) =>
                          (selectGradeName == null ||
                              quickImageStudent.gradeName == selectGradeName) &&
                          (searchQuickImageId == null ||
                              quickImageStudent.cusId!
                                  .contains(searchQuickImageId!)))
                      .toList();

                  return ListView(
                    children: filteredImages.map((quickImageStudent) {
                      // Convert date for display
                      convertDate(quickImageStudent.createdAt!);
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        child: SearchQuickImageList(
                          onTap: () {
                            // Send quickImgId and quickImg URL back on item selection
                            Navigator.pop(context, {
                              'quickImgId': quickImageStudent.imgId,
                              'imageUrl': quickImageStudent.quickImg
                            });
                          },
                          networkQuickImageUrl: quickImageStudent.quickImg!,
                          quickImageId: quickImageStudent.cusId!,
                          quickImageCreateAt: dateOnly!,
                          studentGrade: quickImageStudent.gradeName!,
                        ),
                      );
                    }).toList(),
                  );
                } else if (state is QuickImageSaveProcess) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is QuickImageSaveFailure) {
                  return Center(
                    child: Text(state.message!),
                  );
                } else {
                  return const Center(
                    child: Text('No data available'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void convertDate(DateTime createAt) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    dateOnly = dateFormat.format(createAt);
  }
}
