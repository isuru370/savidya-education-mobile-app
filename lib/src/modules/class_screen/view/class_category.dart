import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../components/app_text_field.dart';
import '../../../components/button/app_main_button.dart';
import '../../../components/drop_down_button_widget.dart';
import '../../../models/category/category.dart';
import '../../../models/class_schedule/class_has_category_model_class.dart';
import '../../../models/class_schedule/class_schedule.dart';
import '../../../provider/cubit_provider/dropdown_button_cubit/dropdown_button_cubit.dart';
import '../../../provider/cubit_provider/dropdown_button_cubit/dropdown_button_state.dart';
import '../../../res/color/app_color.dart';
import '../bloc/class_bloc/class_bloc_bloc.dart';
import '../bloc/class_category/class_category_bloc.dart';
import '../bloc/class_has_category/class_has_category_bloc.dart';
import '../../../models/category_has_class/category_has_class.dart';

class ClassCategory extends StatefulWidget {
  final int? classId;

  const ClassCategory({super.key, this.classId});

  @override
  State<ClassCategory> createState() => _ClassCategoryState();
}

class _ClassCategoryState extends State<ClassCategory> {
  final TextEditingController _classFeesController = TextEditingController();
  int? _categoryId;
  int? _classId;
  String? _className;

  @override
  void initState() {
    super.initState();
    context.read<ClassBlocBloc>().add(GetActiveClass());
    context.read<ClassHasCategoryBloc>().add(GetAllClassHasCategory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text("Class Category"),
        backgroundColor: ColorUtil.tealColor[10],
      ),
      body: BlocListener<ClassHasCategoryBloc, ClassHasCategoryState>(
        listener: (context, state) {
          if (state is ClassHasCategoryFailure) {
            _showSnackbar(state.failureMessage);
          } else if (state is ClassHasCategorySuccess) {
            _resetForm();
            _showSnackbar(state.successMessage);
          }
        },
        child: BlocBuilder<ClassHasCategoryBloc, ClassHasCategoryState>(
          builder: (context, state) {
            if (state is ClassHasCategoryProcess) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildForm(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: _buildClassHasCategoryList(state),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: _formContainerDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyTextField(
              controller: _classFeesController,
              hintText: "Class Fees",
              inputType: TextInputType.number,
              obscureText: false,
              icon: const Icon(null),
            ),
            const SizedBox(height: 20),
            _buildCategoryDropdownSection(),
            const SizedBox(height: 20),
            if (widget.classId == null) _buildClassDropdownSection(),
            const SizedBox(height: 20),
            AppMainButton(
              testName: 'Add Class',
              onTap: _insertClassCategory,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _formContainerDecoration() {
    return BoxDecoration(
      color: ColorUtil.whiteColor[10],
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey
              .withAlpha((0.3 * 255).toInt()), // Use withAlpha for opacity
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
      border: Border.all(
        color: Colors.grey
            .withAlpha((0.5 * 255).toInt()), // Use withAlpha for opacity
      ),
    );
  }

  Widget _buildCategoryDropdownSection() {
    return BlocBuilder<ClassCategoryBloc, ClassCategoryState>(
      builder: (context, state) {
        if (state is ClassCategorySuccess) {
          return DropDownButtonWidget(
            widget: _buildCategoryDropdown(state.classCategoryList),
          );
        } else if (state is ClassCategoryFailure) {
          return Text(
            'Error: ${state.failureMessage}',
            style: const TextStyle(color: Colors.red),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildClassDropdownSection() {
    return BlocBuilder<ClassBlocBloc, ClassBlocState>(
      builder: (context, state) {
        if (state is GetActiveClassSuccess) {
          return DropDownButtonWidget(
            widget: _buildClassDropdown(state.studentModelClass),
          );
        } else if (state is ClassDataFailure) {
          return Text(
            'Error: ${state.failureMessage}',
            style: const TextStyle(color: Colors.red),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildCategoryDropdown(List<ClassCategoryModelClass> categoryList) {
    return BlocBuilder<DropdownButtonCubit, DropdownButtonState>(
      builder: (context, state) {
        return DropdownButton<ClassCategoryModelClass>(
          isExpanded: true,
          underline: const SizedBox(),
          iconSize: 40,
          hint: const Text('Select a Category'),
          icon: const Icon(Icons.arrow_drop_down),
          value: state.selectCategory,
          items: categoryList.map((category) {
            return DropdownMenuItem<ClassCategoryModelClass>(
              value: category,
              child: Text("${category.categoryId} ${category.categoryName}"),
            );
          }).toList(),
          onChanged: (category) {
            if (category != null) {
              context.read<DropdownButtonCubit>().selectCategory(category);
              setState(() {
                _categoryId = category.categoryId;
              });
            }
          },
        );
      },
    );
  }

  Widget _buildClassDropdown(List<ClassScheduleModelClass> classList) {
    return BlocBuilder<DropdownButtonCubit, DropdownButtonState>(
      builder: (context, state) {
        return DropdownButton<ClassScheduleModelClass>(
          isExpanded: true,
          underline: const SizedBox(),
          iconSize: 40,
          hint: const Text('Select a Class'),
          icon: const Icon(Icons.arrow_drop_down),
          value: state.selectClass,
          items: classList.map((classSchedule) {
            return DropdownMenuItem<ClassScheduleModelClass>(
              value: classSchedule,
              child: Text(
                  " ${classSchedule.className}  : Grade ${classSchedule.gradeName}"),
            );
          }).toList(),
          onChanged: (classSchedule) {
            if (classSchedule != null) {
              context.read<DropdownButtonCubit>().selectClass(classSchedule);
              setState(() {
                _classId = classSchedule.id;
                _className = classSchedule.className;
              });
            }
          },
        );
      },
    );
  }

  Widget _buildClassHasCategoryList(ClassHasCategoryState state) {
    if (state is ClassHasCategoryFailure) {
      return Center(child: Text(state.failureMessage));
    } else if (state is GetClassHasCategorySuccess) {
      final filteredList = state.allClassHasCatList.where((classHasCat) {
        return classHasCat.className != null &&
            _className != null &&
            classHasCat.className!.contains(_className!);
      }).toList();

      return ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final classHasCat = filteredList[index];

          final formattedFee = NumberFormat.currency(
            locale: 'si_LK',
            symbol: 'LKR ',
            decimalDigits: 2,
          ).format(classHasCat.classFees);

          return _buildClassCategoryTile(classHasCat, formattedFee);
        },
      );
    }
    return const Center(child: Text("No data found"));
  }

  Widget _buildClassCategoryTile(
      ClassHasCategoryModelClass classHasCat, String formattedFee) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey
                  .withAlpha((0.3 * 255).toInt()), // Replaces withOpacity
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                formattedFee,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.class_,
                  color: ColorUtil.blueColor[10],
                  size: 30,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '${classHasCat.categoryName!} - ${classHasCat.className!}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorUtil.blackColor[14],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _insertClassCategory() {
    final fees = double.tryParse(_classFeesController.text.trim()) ?? 0.0;

    if (_categoryId == null || fees <= 0) {
      _showSnackbar("Please enter valid data");
      return;
    }

    final classHasCatModelClass = CategoryHasClassModelClass(
      categoryId: _categoryId!,
      classId: widget.classId ?? _classId,
      fees: fees,
    );

    context.read<ClassHasCategoryBloc>().add(
          InsertClassHasCategory(classHasCatModelClass: classHasCatModelClass),
        );
  }

  void _resetForm() {
    _classFeesController.clear();
    context.read<DropdownButtonCubit>().selectCategory(null);
    context.read<DropdownButtonCubit>().selectClass(null);
  }

  void _showSnackbar(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    });
  }
}
