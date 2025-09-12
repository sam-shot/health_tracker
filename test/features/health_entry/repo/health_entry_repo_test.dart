

// 1. Generate mocks for the repository's dependencies (NO Uuid needed)
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health_tracker/data/local/health_entry_local_data_source.dart';
import 'package:health_tracker/data/remote/health_entry_remote_data_source.dart';
import 'package:health_tracker/features/health_entry/models/health_entry_model.dart';
import 'package:health_tracker/features/health_entry/repo/health_entry_repo.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'health_entry_repo_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HealthEntryLocalDataSource>(),
  MockSpec<HealthEntryRemoteDataSource>(),
  MockSpec<Connectivity>(),
])


void main() {
  late MockHealthEntryLocalDataSource mockLocalDataSource;
  late MockHealthEntryRemoteDataSource mockRemoteDataSource;
  late MockConnectivity mockConnectivity;
  late HealthEntryRepositoryImpl repository;

  setUp(() {
    mockLocalDataSource = MockHealthEntryLocalDataSource();
    mockRemoteDataSource = MockHealthEntryRemoteDataSource();
    mockConnectivity = MockConnectivity();
    
    // Create an instance of the repository with the mock dependencies
    repository = HealthEntryRepositoryImpl(
      mockLocalDataSource,
      mockRemoteDataSource,
      mockConnectivity,
    );
  });

  // Test Group for the saveHealthEntry method
  group('saveHealthEntry', () {
    
    final testEntry = HealthEntry(
      id: 'a1b2c3d4-test-uuid-1234',
      userId: 'test_user',
      title: 'Daily Mood',
      mood: Mood.happy,
      note: 'Feeling great today!',
      createdAt: DateTime.now(),
      isSynced: false,
    );
    
    test(
      'should save the entry to local source and NOT attempt to sync when offline',
      () async {
        // Simulate being offline
        when(mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => ConnectivityResult.none);
        
        // Call the method with the complete entry object
        await repository.saveHealthEntry(entry: testEntry);
        
        // Verify that saveHealthEntry was called on the LOCAL source with the exact entry.
        verify(mockLocalDataSource.saveHealthEntry(testEntry)).called(1);

        // Verify that the sync method was NEVER called because we are offline.
        verifyNever(mockLocalDataSource.getUnsyncedHealthEntries());
        verifyNever(mockRemoteDataSource.saveHealthEntry(any));
      },
    );

    test(
      'should save to local and THEN sync to remote when online',
      () async {
        // Simulate being online
        when(mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => ConnectivityResult.mobile);

        // When the sync method asks for unsynced entries, return our test entry
        when(mockLocalDataSource.getUnsyncedHealthEntries())
            .thenAnswer((_) async => [testEntry]);

        // Call the method with the complete entry object
        await repository.saveHealthEntry(entry: testEntry);

        // Verify it was first saved locally. This is the first call.
        verify(mockLocalDataSource.saveHealthEntry(testEntry)).called(1);

        // Verify the sync process was triggered
        verify(mockLocalDataSource.getUnsyncedHealthEntries()).called(1);
        
        // Verify the unsynced entry was sent to the remote source
        verify(mockRemoteDataSource.saveHealthEntry(testEntry)).called(1);
        
        // Verify the entry was updated locally to be marked as synced
        verify(mockLocalDataSource.saveHealthEntry(testEntry.copyWith(isSynced: true))).called(1);
      },
    );
  });
}