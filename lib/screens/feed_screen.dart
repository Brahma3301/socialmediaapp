import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late Stream<List<String>> followingUidsStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> followingPostsStream;

  @override
  void initState() {
    super.initState();
    followingUidsStream = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((snapshot) => List<String>.from(snapshot['following'] ?? []));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        centerTitle: false,
        title: const Text('Pablogram'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.messenger_outline),
          ),
        ],
      ),
      body: StreamBuilder<List<String>>(
        stream: followingUidsStream,
        builder: (context, followingUidsSnapshot) {
          if (followingUidsSnapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (followingUidsSnapshot.hasError) {
            return const Center(
              child: Text('Error occurred. Please try again.'),
            );
          }

          final followingUids = followingUidsSnapshot.data ?? [];

          if (followingUids.isEmpty) {
            return const Center(
              child: Text('No posts available.'),
            );
          }

          followingPostsStream = FirebaseFirestore.instance
              .collection('posts')
              .where('uid',
                  whereIn: followingUids.isNotEmpty ? followingUids : [''])
              .snapshots();

          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: followingPostsStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Error occurred. Please try again.'),
                );
              }

              final posts = snapshot.data!.docs;

              if (posts.isEmpty) {
                return const Center(
                  child: Text('No posts available.'),
                );
              }

              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index].data();
                  return PostCard(snap: post);
                },
              );
            },
          );
        },
      ),
    );
  }
}
