import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../core/bookmark/bookmark_bloc.dart';
import '../core/bookmark/bookmark_event.dart';
import '../models/job/job_model.dart';

class JobDescriptionScreen extends StatelessWidget {
  final Job job;

  const JobDescriptionScreen({
    Key? key,
    required this.job,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookmarkBloc = context.watch<BookmarkBloc>();
    final isBookmarked = job.isBookmarked || bookmarkBloc.isJobBookmarked(job.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked ? Colors.blue : null,
            ),
            onPressed: () {
              if (isBookmarked) {
                context.read<BookmarkBloc>().add(RemoveBookmark(job.id));
              } else {
                context.read<BookmarkBloc>().add(BookmarkJob(job));
              }
            },
          ),
        ],
      ),
      body: _buildJobDescription(),
    );
  }

  Widget _buildJobDescription() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            job.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              if (job.companyLogoUrl != null)
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      job.companyLogoUrl!,
                      width: 50,
                      height: 50,
                      errorBuilder: (_, __, ___) => const Icon(Icons.business, size: 50),
                    ),
                  ),
                ),
              Expanded(
                child: Text(
                  job.companyName,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (job.salary != null) Text('Salary: ${job.salary}'),
          const SizedBox(height: 8),
          Text('Location: ${job.candidateRequiredLocation}'),
          const SizedBox(height: 8),
          Text('Job Type: ${job.jobType}'),
          const SizedBox(height: 8),
          Text('Category: ${job.category}'),
          const SizedBox(height: 8),
          Text('Posted on: ${job.publicationDate}'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: job.tags.map<Widget>((tag) => Chip(label: Text(tag))).toList(),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          const Text(
            'Job Description',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Html(
            data: job.description,
            style: {
              "body": Style(fontSize: FontSize(16.0)),
              "li": Style(),
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Implement apply action
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Apply for this Job'),
          ),
        ],
      ),
    );
  }
}