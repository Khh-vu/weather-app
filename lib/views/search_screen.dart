import 'package:flutter/material.dart';

import '../models/city.dart';
import '../services/city_service.dart';
import '../services/search_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static String routeName = '/search';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<City> _citySearchList = [];
  List<City> _cityList = [];
  List<String> _searchHistory = [];

  bool _showScrollToTop = false;

  void _searchFilter(String searchValue) {
    List<City> result = [];
    if (searchValue.isEmpty) {
      _showScrollToTop = false;
      result.clear();
    } else {
      result = _cityList
          .where((city) =>
              city.name.toLowerCase().contains(searchValue.toLowerCase()))
          .toList();
    }
    setState(() {
      _citySearchList = result;
    });
  }

  void getHistory() async {
    _searchHistory = await SearchHistoryService().getSearchHistory();
    setState(() {});
  }

  void saveHistoryAndPop(BuildContext context, {required String text}) async {
    await SearchHistoryService().setSearchHistory(text);
    if (!mounted) return;
    Navigator.of(context).pop<String>(text);
  }

  @override
  void initState() {
    super.initState();
    getHistory();
    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.offset >= 200) {
          _showScrollToTop = true;
        } else {
          _showScrollToTop = false;
        }
      });
    });
  }

  @override
  void didChangeDependencies() async {
    _cityList = await CityService.getCityList(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        shrinkWrap: true,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            titleSpacing: 0,
            title: TextField(
              controller: _searchController,
              style: textTheme.bodyText1,
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: textTheme.bodyText1,
                border: InputBorder.none,
              ),
              onChanged: (value) {
                _searchFilter(value);
              },
            ),
            actions: <Widget>[
              if (_searchController.text.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.clear),
                  tooltip: 'Clear',
                  onPressed: () {
                    setState(() {
                      _showScrollToTop = false;
                      _searchController.clear();
                      _citySearchList.clear();
                    });
                  },
                ),
            ],
          ),
          SliverList(
            delegate: _searchController.text.isEmpty
                ? SliverChildBuilderDelegate(
                    (context, index) {
                      return ListTile(
                        onTap: () {
                          saveHistoryAndPop(
                            context,
                            text: _searchHistory[index],
                          );
                        },
                        leading: const Icon(Icons.history),
                        title: Text(_searchHistory[index]),
                        trailing: IconButton(
                          onPressed: () async {
                            await SearchHistoryService()
                                .clearItemFromSearchHistory(
                              _searchHistory[index],
                            );
                            setState(() {
                              _searchHistory.removeAt(index);
                            });
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      );
                    },
                    childCount: _searchHistory.length,
                  )
                : SliverChildBuilderDelegate(
                    (context, index) {
                      return ListTile(
                        onTap: () {
                          saveHistoryAndPop(
                            context,
                            text: _citySearchList[index].name,
                          );
                        },
                        leading: const Icon(Icons.location_city),
                        title: Text(_citySearchList[index].name),
                      );
                    },
                    childCount: _citySearchList.length,
                  ),
          ),
        ],
      ),
      floatingActionButton: _showScrollToTop == false
          ? null
          : FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.linear,
                );
              },
              tooltip: 'Scroll to Top',
              child: const Icon(Icons.arrow_upward),
            ),
    );
  }
}
