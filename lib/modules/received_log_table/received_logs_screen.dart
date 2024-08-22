import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:illa_logging_app/modules/received_log_table/cubit/cubit.dart';
import '../../models/received_logs/received_logs.dart';
import '../../shared/components/main_cubit/cubit.dart';
import 'cubit/states.dart';

class ReceivedLogsScreen extends StatefulWidget {
  @override
  State<ReceivedLogsScreen> createState() => _ReceivedLogsScreenState();
}

class _ReceivedLogsScreenState extends State<ReceivedLogsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool _isPanelVisible = false;
  String _panelTitle = '';
  String _panelDetails = '';
  String _panelImagePath = '';
  String _panelRate = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),  // Start completely off-screen to the right
      end: Offset.zero,         // End at the right edge of the screen
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  void _togglePanel(String title, int voteAverage, String imagePath, String details) {
    setState(() {
      _isPanelVisible = !_isPanelVisible;
      _panelTitle = title;
      _panelRate = '$voteAverage';
      _panelImagePath = imagePath;
      _panelDetails = details;
      if (_isPanelVisible) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReceivedLogsCubit()..getData(),
      child: BlocConsumer<ReceivedLogsCubit, ReceivedLogsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ReceivedLogsLoadingState) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: AppBar(
                    title: const Text('Received Logs'),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(
                          onPressed: () {
                            ThemeCubit.get(context).toggleTheme();
                          },
                          icon: ThemeCubit.get(context).themeIcon,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: const Center(child: CircularProgressIndicator()),
            );
          }
          else if (state is ReceivedLogsFailedState) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: AppBar(
                    title: const Text('Received Logs'),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(
                          onPressed: () {
                            ThemeCubit.get(context).toggleTheme();
                          },
                          icon: ThemeCubit.get(context).themeIcon,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: const Center(child: Text('Failed to load data')),
            );
          }
          else if (state is ReceivedLogsSuccessState) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: AppBar(
                    title: const Text('Received Logs'),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(
                          onPressed: () {
                            ThemeCubit.get(context).toggleTheme();
                          },
                          icon: ThemeCubit.get(context).themeIcon,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: PaginatedDataTable(
                      showCheckboxColumn: false,
                      onPageChanged: (page){},
                      source: ReceivedLogs(list,
                        onRowSelected: ({required image, required overview, required title, required voteAverage}) {
                          _togglePanel(title, voteAverage!, image, overview);
                        },
                      ),
                      columns: const [
                        DataColumn(label: Center(child: Text('Title'))),
                        DataColumn(label: Center(child: Text('Rate'))),
                        DataColumn(label: Center(child: Text('Overview'))),
                      ],
                      columnSpacing: 20,
                    ),
                  ),
                  SlideTransition(
                    position: _slideAnimation,
                    child: _isPanelVisible
                        ? _buildSidePanel()
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            );
          }
          return Container(); // Fallback
        },
      ),
    );
  }

  Widget _buildSidePanel() {
    return Container(
      width: 500,
      height: 550,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[700],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _panelTitle,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(Icons.star, color: Colors.yellow[700], size: 20,),
                const SizedBox(width: 5,),
                Text('${_panelRate} /10',
                  style: TextStyle(
                    color: Colors.yellow[700],
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Image(
              image: NetworkImage(_panelImagePath),
              height: 350,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text(_panelDetails),
            ),
          ],
        ),
      ),
    );
  }
}
