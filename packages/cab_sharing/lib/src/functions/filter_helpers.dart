import '../models/post_model.dart';

/// Filter options for cab sharing posts
enum CabFilter { all, toCampus, toAirport, toGHYStation, toKamakhya }

/// Returns filter label for display
String getFilterLabel(CabFilter filter) {
  switch (filter) {
    case CabFilter.all:
      return 'All';
    case CabFilter.toCampus:
      return 'To Campus';
    case CabFilter.toAirport:
      return 'To Airport';
    case CabFilter.toGHYStation:
      return 'To GHY Station';
    case CabFilter.toKamakhya:
      return 'To Kamakhya';
  }
}

/// Checks if a post matches the selected location filter
bool matchesLocationFilter(PostModel post, CabFilter filter) {
  switch (filter) {
    case CabFilter.all:
      return true;
    case CabFilter.toCampus:
      return post.to.toLowerCase().contains('iit') ||
          post.to.toLowerCase().contains('campus');
    case CabFilter.toAirport:
      return post.to.toLowerCase().contains('airport');
    case CabFilter.toGHYStation:
      return post.to.toLowerCase().contains('guwahati');
    case CabFilter.toKamakhya:
      return post.to.toLowerCase().contains('kamakhya');
  }
}

/// Checks if a post matches the selected date filter
bool matchesDateFilter(PostModel post, DateTime? selectedDate) {
  if (selectedDate == null) return true;

  final postDate = DateTime.parse(post.travelDateTime.substring(0, 10));
  final selectedDay = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
  );
  final postDay = DateTime(postDate.year, postDate.month, postDate.day);
  return postDay == selectedDay;
}

/// Checks if a post matches both location and date filters
bool matchesAllFilters(
  PostModel post,
  CabFilter locationFilter,
  DateTime? dateFilter,
) {
  return matchesLocationFilter(post, locationFilter) &&
      matchesDateFilter(post, dateFilter);
}

/// Filters posts based on selected filters
List<Map<String, List<PostModel>>> filterPosts(
  List<Map<String, List<PostModel>>> allPosts,
  CabFilter locationFilter,
  DateTime? dateFilter,
) {
  // If no filters applied, return all posts
  if (locationFilter == CabFilter.all && dateFilter == null) {
    return allPosts;
  }

  List<Map<String, List<PostModel>>> filtered = [];
  for (var dateGroup in allPosts) {
    String date = dateGroup.keys.first;
    List<PostModel> posts = dateGroup[date]!;
    List<PostModel> filteredPosts =
        posts
            .where(
              (post) => matchesAllFilters(post, locationFilter, dateFilter),
            )
            .toList();
    if (filteredPosts.isNotEmpty) {
      filtered.add({date: filteredPosts});
    }
  }
  return filtered;
}
