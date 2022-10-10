import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shotcaller_validator/utils/app_colors.dart';
import 'package:shotcaller_validator/utils/app_strings.dart';
import 'package:shotcaller_validator/utils/app_styles.dart';
import 'package:shotcaller_validator/widgets/custom_button.dart';
import 'package:shotcaller_validator/widgets/custom_loader.dart';
import 'package:shotcaller_validator/widgets/custom_text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController nftIdController;
  bool isValidating = false;

  @override
  void initState() {
    nftIdController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nftIdController.dispose();
    super.dispose();
  }

  void showAlert({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onPressed,
    required String buttonText,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(color: AppColors.primaryColor),
          ),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: const TextStyle(color: AppColors.primaryColor),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> validateNFT() async {
    if (nftIdController.text.isNotEmpty) {
      setState(() {
        isValidating = true;
      });

      try {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection("NFTs")
            .where(
              "nft_id",
              isEqualTo: AppStrings.collectionAddress + nftIdController.text,
            )
            .get();

        if (snapshot.docs.isNotEmpty && snapshot.docs[0].exists) {
          if (snapshot.docs[0].get("redeemed")) {
            showAlert(
              context: context,
              title: AppStrings.holdOn,
              content: AppStrings.redeemed,
              onPressed: () => Navigator.of(context).pop(),
              buttonText: AppStrings.okButton,
            );
          } else {
            showAlert(
              context: context,
              title: AppStrings.shotcallerNFTTitle,
              content: AppStrings.shotcallerNFT,
              onPressed: () async {
                try {
                  QuerySnapshot snapshot = await FirebaseFirestore.instance
                      .collection("NFTs")
                      .where(
                        "nft_id",
                        isEqualTo:
                            AppStrings.collectionAddress + nftIdController.text,
                      )
                      .get();
                  String docId = snapshot.docs[0].id;
                  await FirebaseFirestore.instance
                      .collection("NFTs")
                      .doc(docId)
                      .update({
                    "redeemed": true,
                    "redeem_time": FieldValue.serverTimestamp(),
                  });
                  Navigator.of(context).pop();
                } catch (e) {
                  if (kDebugMode) {
                    print(e);
                  }
                }
              },
              buttonText: AppStrings.redeemBtn,
            );
          }
        } else {
          showAlert(
            context: context,
            title: AppStrings.holdOn,
            content: AppStrings.notExists,
            onPressed: () => Navigator.of(context).pop(),
            buttonText: AppStrings.okButton,
          );
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }

      setState(() {
        isValidating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(22),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    AppStrings.logoPath,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  AppStrings.appName,
                  style: AppStyles.headingStyleBold,
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  hintText: AppStrings.nftIdHint,
                  controller: nftIdController,
                ),
                const SizedBox(height: 32),
                isValidating
                    ? const CustomLoader()
                    : CustomButton(
                        text: AppStrings.validateBtn,
                        onPressed: () async {
                          await validateNFT();
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
