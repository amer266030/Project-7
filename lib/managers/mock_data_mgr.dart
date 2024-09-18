import '../model/project/project.dart';

class MockDataManager {
  // Singleton pattern
  static final MockDataManager _instance = MockDataManager._internal();
  factory MockDataManager() {
    return _instance;
  }
  MockDataManager._internal();

  // Flag to indicate preview mode
  bool isPreview = false;

  // Method to get mock projects
  List<Project> getMockProjects() {
    return [
      Project(
          projectId: '1',
          projectName: 'Mock Project 1',
          bootcampName: 'Flutter',
          rating: 8),
      Project(
          projectId: '2',
          projectName: 'Mock Project 2',
          bootcampName: 'Flutter',
          rating: 6),
      Project(
          projectId: '3',
          projectName: 'Mock Project 3',
          bootcampName: 'Flutter',
          rating: 10),
      Project(
          projectId: '4',
          projectName: 'Mock Project 4',
          bootcampName: 'Flutter',
          rating: 5),
      Project(
          projectId: '5',
          projectName: 'Mock Project 5',
          bootcampName: 'Swift',
          rating: 4),
      Project(
          projectId: '6',
          projectName: 'Mock Project 6',
          bootcampName: 'Swift',
          rating: 2),
    ];
  }
}
