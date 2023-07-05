import 'package:quran/home/base_strategy/search_strategy.dart';

class SearchStrategyController{

  static final SearchStrategyController _singleton = SearchStrategyController._internal();

  factory SearchStrategyController() {
    return _singleton;
  }

  SearchStrategyController._internal();

  SearchStrategy? _searchStrategy;

  set setStrategy(SearchStrategy? strategy) => _searchStrategy = strategy; 

  get getStrategy => _searchStrategy;

  // const SearchStrategyController({this.searchStrategy});

  Future<void> executeSearch(String searchText)async{
    try{await _searchStrategy?.search(searchText);}catch(e){
      rethrow;
    }
  }

}