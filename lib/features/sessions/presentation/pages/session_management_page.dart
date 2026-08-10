import 'package:flutter/material.dart';

import '../controllers/session_controller.dart';
import '../widgets/session_list.dart';

import '../../../../core/design/app_spacing.dart';



class SessionManagementPage extends StatefulWidget {

  const SessionManagementPage({
    super.key,
  });


  @override
  State<SessionManagementPage> createState() =>
      _SessionManagementPageState();

}



class _SessionManagementPageState
    extends State<SessionManagementPage> {


  final SessionController controller =
      SessionController();



  @override
  void initState() {

    super.initState();

    controller.loadSessions();

    controller.addListener(_refresh);

  }



  void _refresh() {

    if (mounted) {

      setState(() {});

    }

  }



  @override
  void dispose() {

    controller.removeListener(_refresh);

    super.dispose();

  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title:
            const Text(
              "مدیریت سانس‌ها",
            ),

        centerTitle:
            true,

      ),




        floatingActionButton:

            FloatingActionButton.extended(

            onPressed: () async {

                await Navigator.pushNamed(
                context,
                '/session/create',
                );


                await controller.loadSessions();

            },

            icon:
                const Icon(
                    Icons.add,
                ),

            label:
                const Text(
                    "افزودن سانس",
                ),

            ),





      body: Padding(

        padding:
            const EdgeInsets.all(
              AppSpacing.md,
            ),



        child:

            controller.sessions.isEmpty

                ?

                const Center(

                  child:
                      Text(
                        "هنوز سانسی ثبت نشده",
                      ),

                )

                :

                SingleChildScrollView(

                  child:

                      SessionList(

                        sessions:

                            controller.sessions

                      ),

                ),

      ),

    );

  }

}