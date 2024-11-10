import 'package:flutter/material.dart';
import 'package:guess/constants.dart';
import 'package:guess/features/game_feature/data/models/scoring_model.dart';
import 'package:guess/features/game_feature/presentation/manager/provider/game_state.dart';
import 'package:guess/features/game_feature/presentation/views/widgets/game_room_list_tile.dart';
import 'package:guess/features/game_feature/presentation/views/widgets/sign_out_button.dart';
import 'package:provider/provider.dart';

class GameRoomView extends StatefulWidget {
  const GameRoomView({super.key});

  @override
  State<GameRoomView> createState() => _GameRoomViewState();
}

class _GameRoomViewState extends State<GameRoomView> {
  late TextEditingController _textEditingController;
  final List<String> _gameRooms = [];

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Game Rooms'),
        centerTitle: true,
        actions: const [
          SignOutButton(),
        ],
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: ListView.builder(
          itemCount: _gameRooms.length,
          itemBuilder: (context, index) {
            return GameRoomListTile(
              onPressedDelete: () => _removeRoom(index),
              collectionName: _gameRooms[index],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addGameRoom,
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  void _addGameRoom() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Room Name'),
          content: TextField(
            controller: _textEditingController,
            autofocus: true,
            onSubmitted: (_) => _submitRoom(),
            decoration: const InputDecoration(hintText: 'Enter room name'),
          ),
          actions: [
            TextButton(
              onPressed: _submitRoom,
              child: const Text('Done', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  void _submitRoom() {
    final roomName = _textEditingController.text.trim();

    if (roomName.isNotEmpty) {
      setState(() {
        _gameRooms.add(roomName);
        context.read<GameState>().scoringList.add(ScoringModel(roomName));
      });
      _textEditingController.clear();
      Navigator.of(context).pop();
    }
  }

  void _removeRoom(int index) {
    setState(() {
      _gameRooms.removeAt(index);
    });
  }
}
