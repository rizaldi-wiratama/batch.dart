// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:batch/batch.dart';
import 'package:cron/cron.dart';

// Project imports:
import 'package:batch/src/job/step_launcher.dart';

/// This class provides the feature to securely execute registered jobs.
class JobLauncher {
  /// Returns the new instance of [JobLauncher].
  JobLauncher({
    required this.jobs,
  });

  /// The jobs
  final List<Job> jobs;

  /// Cron
  final _cron = Cron();

  /// Runs all scheduled jobs.
  void execute() {
    if (jobs.isEmpty) {
      throw Exception(
        'The job to be launched is required.',
      );
    }

    info('The job schedule is being configured...');

    for (final job in jobs) {
      _cron.schedule(Schedule.parse(job.cron), () async {
        info('STARTED JOB (${job.name})');

        final context = ExecutionContext();
        context.jobExecution = JobExecution(name: job.name);

        await StepLauncher(
          context: context,
          steps: job.steps,
          parentJobName: job.name,
        ).execute();

        info('FINISHED JOB (${job.name})');
      });
    }

    info('The job schedule has configured!');
  }
}
