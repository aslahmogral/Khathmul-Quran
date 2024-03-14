// import 'package:daily_quran/juz_section/juz_card/juz_card.dart';
// import 'package:daily_quran/juz_section/juz_provider.dart';
import 'package:flutter/material.dart';
import 'package:khathmul_quran/juz_provider.dart';
import 'package:khathmul_quran/utils/colors.dart';
import 'package:provider/provider.dart';
// import 'package:daily_quran/references/screens/surah_index_screen/surah_index_model.dart';
// import 'package:daily_quran/utils/colors.dart';

class JuzIndexScreen extends StatefulWidget {
  const JuzIndexScreen({
    super.key,
  });

  @override
  State<JuzIndexScreen> createState() => _JuzIndexScreenState();
}

class _JuzIndexScreenState extends State<JuzIndexScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Khathmul Quran',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.primaryColor),
        ),
      ),
      body: Consumer<JuzProgressProvider>(
          builder: (context, juzProgressModel, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                Card(
                  color: AppColors.primaryColor.withOpacity(0.5),
                  child: Container(
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${juzProgressModel.totalProgressOfJuz.toStringAsFixed(1).toString()} %',
                                style: TextStyle(
                                    color: AppColors.seconderyColor,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    resetButtonClicked(
                                        context, juzProgressModel);
                                  },
                                  icon: Icon(Icons.restart_alt))
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          SizedBox(
                            height: 10,
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                              color: AppColors.seconderyColor,
                              value: juzProgressModel.totalProgressOfJuz/100,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        4, // You can adjust the number of columns as needed
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0,
                  ),
                  itemCount: juzProgressModel.juzList.length,
                  shrinkWrap: true,
                  physics:
                      NeverScrollableScrollPhysics(), // to prevent scrolling of GridView within SingleChildScrollView
                  itemBuilder: (context, index) {
                    return GridTile(
                      child: Container(
                        // Your content for each grid item here
                        child: juzProgressModel.juzList[
                            index], // Replace YourWidget with your actual widget
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Future<dynamic> resetButtonClicked(
      BuildContext context, JuzProgressProvider model) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: StatefulBuilder(builder: (thisLowerContext, innerSetState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                        value: model.shouldReset,
                        onChanged: (val) {
                          innerSetState(() {
                            model.updateShouldReset(val!);
                          });
                        }),
                    Column(
                      children: [
                        Text('Are you Sure '),
                        Text('You Want to Reset ???')
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                // Consumer<JuzProgressProvider>(
                //     builder: (context, juzProgressModel, child) {
                //   return
                Column(
                  children: [
                    Visibility(
                      visible: !model.shouldReset,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              AppColors.seconderyColor),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Close',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: model.shouldReset,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.primaryColor),
                        ),
                        onPressed: () {
                          if (model.shouldReset) {}
                          model.resetAllJuzProgress();
                          innerSetState(() {
                            model.updateShouldReset(false);
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          'RESET',
                          style: TextStyle(
                              color: AppColors.seconderyColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
                // })
              ],
            );
          }),
        );
      },
    );
  }
}
