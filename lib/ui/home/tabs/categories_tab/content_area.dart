import 'package:dio/dio.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/product_model.dart';
import '../../../../providers/language_provider.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../services/product_service.dart';
import '../../../../utils/app_colors.dart';

class ContentArea extends StatefulWidget {
  final String categoryName;
  final String categoryId;
  final String categoryImage;

  const ContentArea({
    super.key,
    required this.categoryName,
    required this.categoryId,
    required this.categoryImage
  });

  @override
  State<ContentArea> createState() => _ContentAreaState();

}

class _ContentAreaState extends State<ContentArea> {
  late ProductService productService;
  late Future<List<ProductModel>> productsFuture;




  @override
  void initState() {
    super.initState();
    productService = ProductService(dio: Dio());
    _loadProducts();
  }

  @override
  void didUpdateWidget(ContentArea oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categoryId != widget.categoryId) {
      _loadProducts();
    }
  }

  void _loadProducts() {
    setState(() {
      productsFuture = productService.getProductsByCategory(widget.categoryId);
    });
  }
  @override
  Widget build(BuildContext context) {
   var height = MediaQuery.of(context).size.height;
   var width = MediaQuery.of(context).size.width;
   var languageProvider = Provider.of<LanguageProvider>(context);
   var themeProvider = Provider.of<ThemeProvider>(context);
    return SizedBox(
      height:height,

      child: Column(
        children: [
          // Header section
          // Padding(
          //   padding: EdgeInsets.only(
          //     left: width*0.01,
          //     bottom: height*0.01
          //   ),
          //   child: Row(
          //     children: [
          //       Text(
          //         widget.categoryName,
          //         style: Theme.of(context).textTheme.displayMedium,
          //       ),
          //     ],
          //   ),
          // ),

          // Carousel section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: SizedBox(
              height: height * 0.17,
              child: Stack(
                children:[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.categoryImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                 Padding(
                   padding: EdgeInsets.symmetric(
                     horizontal: width*0.01,
                     vertical: height*0.01
                   ),
                   child: Column(
                     children: [
                       Text(widget.categoryName.split(' ').map((str) => str.isNotEmpty
                           ? str[0].toUpperCase() + str.substring(1).toLowerCase()
                           : '').join(' '),
                         style: Theme.of(context).textTheme.displayMedium,),
                       SizedBox(height: height*0.01,),
                       Container(
                         padding: EdgeInsets.symmetric(horizontal: width*.04 , vertical: height*0.01),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(25),
                           color:  AppColors.blueColor,
                         ),
                         child: Text("Shop Now".toUpperCase() ,
                           style: TextStyle(
                             color: AppColors.whiteColor,
                           )
                           ,),
                       )
                     ],
                   ),
                 )

                ] 
              ),
            ),
          ),

          // Products Grid section
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return FutureBuilder<List<ProductModel>>(
                  future: productsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text(AppLocalizations.of(context)!.no_products));
                    } else {
                      final products = snapshot.data!;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.8,
                        ),
                        padding: const EdgeInsets.all(8),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Card(
                            color: AppColors.transparentColor,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.network(
                                    product.image,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const Icon(Icons.error),
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.all(8.0),
                                  child: Text(product.title ,
                                  style: TextStyle(
                                    color: themeProvider.currentTheme == ThemeMode.light
                                        ?AppColors.darkBlueColor
                                        :AppColors.whiteColor
                                  ),),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
