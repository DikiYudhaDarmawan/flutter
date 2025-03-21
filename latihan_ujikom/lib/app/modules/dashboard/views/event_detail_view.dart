import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latihan_ujikom/app/data/event_response.dart';

class EventDetailView extends GetView {
  const EventDetailView({super.key, required this.event});
  final Events event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text(event.name!),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                'https://picsum.photos/id/${event.id}/700/300',
                fit: BoxFit.cover,
                height: 200,
                width: 500,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 200,
                    child: Center(child: Text('Image not found')),
                  );
                },
              ),
              const SizedBox(height: 16),
              Text(
                event.name!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                event.description!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      event.location!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Event Date ${event.eventDate}',
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
