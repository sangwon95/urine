import 'package:flutter/material.dart';
import 'package:urine/common/common.dart';
import 'package:urine/layers/presentation/widget/style_text.dart';


/// 커스텀된 AppBar를 나타내는 위젯 클래스.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isActions;

  const CustomAppBar({
    super.key,
    this.title, required this.isActions,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.vertical(bottom: AppConstants.radius),
        child: AppBar(
          title: StyleText(
            text: title ?? '',
            size: AppDim.fontSizeLarge,
            color: AppColors.whiteTextColor,
            fontWeight: AppDim.weightBold,
          ),
          actions: [
            // Visibility(
            //   visible: isActions,
            //   child: InkWell(
            //     onTap: ()=>{
            //       showDialog(
            //         context: context,
            //         barrierDismissible: false,
            //         builder: (BuildContext context) {
            //           return const LogoutAlertDialog();
            //         },
            //       )
            //     },
            //     child: const Padding(
            //       padding: EdgeInsets.only(right: 20),
            //       child: Icon(Icons.logout, color: AppColors.white,),
            //     ),
            //   ),
            // )
          ],
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.white),
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}
