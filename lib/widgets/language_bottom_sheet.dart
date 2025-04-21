import 'package:electro_app_team/widgets/selected_bottom_item.dart';
import 'package:electro_app_team/widgets/unselected_bottom_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<LanguageProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: (){
            languageProvider.changeLocal('en');
          },
          child: Padding(
            padding:  EdgeInsets.symmetric(
              horizontal: width*0.04,
              vertical: height*0.02
            ),
              child: languageProvider.currentLocal == ("en")
                  ? SelectedBottomItem(selectedItem: AppLocalizations.of(context)!.english)
                  : UnselectedBottomItem(selectedItem: AppLocalizations.of(context)!.english)
          ),
        ),
        InkWell(
          onTap: (){
            languageProvider.changeLocal('ar');
          },
          child: Padding(
            padding:  EdgeInsets.symmetric(
                horizontal: width*0.04,
                vertical: height*0.01
            ),
            child: languageProvider.currentLocal == ("ar")
             ? SelectedBottomItem(selectedItem: AppLocalizations.of(context)!.arabic)
             : UnselectedBottomItem(selectedItem: AppLocalizations.of(context)!.arabic)

          ),
        ),


      ],
    );
  }
}
