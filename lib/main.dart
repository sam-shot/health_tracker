import 'dart:io';

import 'package:flutter/material.dart';
import 'package:health_tracker/app/app.dart';
import 'package:health_tracker/app/injection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  await Supabase.initialize(
    url: 'https://qzobqokwkgvopegkgukq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InF6b2Jxb2t3a2d2b3BlZ2tndWtxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc2MDE3ODIsImV4cCI6MjA3MzE3Nzc4Mn0.AVxNw34Pcqd0cl6OEi89HU1m7rBQxEspnGrqMI_9J_c',
  );

  runApp(const ProviderScope(child: HealthTracker()));
}
