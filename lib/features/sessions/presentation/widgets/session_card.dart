import 'package:flutter/material.dart';

import '../../../../core/widgets/uog_card.dart';
import '../../../../core/design/app_spacing.dart';
import '../../../../core/utils/number_helper.dart';


class SessionCard extends StatelessWidget {

  final String title;
  final String time;
  final int currentCount;
  final int capacity;
  final bool allowMakeup;
  final VoidCallback? onTap;


  const SessionCard({

    super.key,

    required this.title,

    required this.time,

    required this.currentCount,

    required this.capacity,

    required this.allowMakeup,

    this.onTap,

  });



  @override
  Widget build(BuildContext context) {


    return Padding(

      padding: const EdgeInsets.only(
        bottom: AppSpacing.md,
      ),


      child: UOGCard(

        onTap: onTap,


        child: Padding(

          padding: const EdgeInsets.all(16),


          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,


            children: [


              Text(

                title,

                style: const TextStyle(

                  fontSize: 18,

                  fontWeight:
                      FontWeight.bold,

                ),

              ),



              const SizedBox(
                height: 12,
              ),



              Row(

                children: [


                  const Icon(
                    Icons.schedule,
                  ),


                  const SizedBox(
                    width: 8,
                  ),



                  Text(time),


                ],

              ),



              const SizedBox(
                height: 12,
              ),



              Row(

                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,


                children: [



                  Text(

                    "ظرفیت: "
                    "${NumberHelper.toPersian(currentCount)}"
                    " / "
                    "${NumberHelper.toPersian(capacity)}",

                  ),




                  if (allowMakeup)

                    Container(

                      padding:
                          const EdgeInsets.symmetric(

                            horizontal: 10,

                            vertical: 4,

                          ),


                      decoration:
                          BoxDecoration(

                            borderRadius:
                                BorderRadius.circular(20),


                            color:
                                Colors.green.shade100,

                          ),



                      child:
                          const Text(

                            "جبرانی فعال",

                          ),


                    ),


                ],

              ),



              const SizedBox(
                height: 8,
              ),



              if (onTap != null)

                const Align(

                  alignment:
                      Alignment.centerLeft,


                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),

                ),


            ],

          ),

        ),

      ),

    );

  }

}