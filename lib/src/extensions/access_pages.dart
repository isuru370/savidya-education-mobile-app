import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/permission_model/permission_model.dart';
import '../provider/bloc_provider/pages_bloc/pages_bloc.dart';
import '../provider/bloc_provider/permission_bloc/permission_bloc.dart';

class AccessPages extends StatelessWidget {
  final String pageName;
  final int userTypeId;
  final VoidCallback onSuccess;
  final VoidCallback onError;

  const AccessPages({
    super.key,
    required this.pageName,
    required this.userTypeId,
    required this.onSuccess,
    required this.onError,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PagesBloc>(context).add(GetPagesEvent());
    return BlocListener<PagesBloc, PagesState>(
      listener: (context, state) {
        if (state is PageFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.failureMessage)),
          );

          Future.microtask(onError);
        } else if (state is PagesSuccess) {
          for (int i = 0; i < state.pageList.length; i++) {
            if (state.pageList[i].pageName == pageName) {
              PermissionModel permissionModel = PermissionModel(
                userTypeId: userTypeId,
                pageId: state.pageList[i].id,
              );
              BlocProvider.of<PermissionBloc>(context).add(
                GetUserPermissionEvent(permissionModel: permissionModel),
              );
              break;
            }
          }
        }
      },
      child: BlocBuilder<PermissionBloc, PermissionState>(
        builder: (context, state) {
          if (state is PermissionProcess) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PermissionSuccess) {
            Future.microtask(() {
              if (state.permissionMessage) {
                onSuccess();
              } else {
                onError();
              }
            });
          }
          return Container();
        },
      ),
    );
  }
}
