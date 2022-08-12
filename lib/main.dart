import 'package:flutter/material.dart';

import 'constants.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const MyHomePage(title: 'Flutter Demo Home Page'),
    debugShowCheckedModeBanner: false,
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String currentPlayer = 'X';
  String winner = ' ';

  String hasWinner() {
    if (grid[0] == grid[1] &&
        grid[1] == grid[2] &&
        grid[0] == grid[2] &&
        grid[0] != ' ') {
      return grid[0];
    } else if (grid[0] == grid[4] &&
        grid[4] == grid[8] &&
        grid[0] == grid[8] &&
        grid[0] != ' ') {
      return grid[0];
    } else if (grid[0] == grid[3] &&
        grid[3] == grid[6] &&
        grid[0] == grid[6] &&
        grid[0] != ' ') {
      return grid[0];
    } else if (grid[1] == grid[4] &&
        grid[4] == grid[7] &&
        grid[1] == grid[7] &&
        grid[1] != ' ') {
      return grid[1];
    } else if (grid[2] == grid[5] &&
        grid[5] == grid[8] &&
        grid[2] == grid[8] &&
        grid[2] != ' ') {
      return grid[2];
    } else if (grid[3] == grid[4] &&
        grid[4] == grid[5] &&
        grid[3] == grid[5] &&
        grid[3] != ' ') {
      return grid[3];
    } else if (grid[6] == grid[7] &&
        grid[7] == grid[8] &&
        grid[6] == grid[8] &&
        grid[6] != ' ') {
      return grid[6];
    } else if (grid[2] == grid[4] &&
        grid[4] == grid[6] &&
        grid[2] == grid[6] &&
        grid[2] != ' ') {
      return grid[2];
    } else {
      return ' ';
    }
  }

  Widget showGrid() {
    return GridView.builder(
      itemCount: 9,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              winner = hasWinner();
              if (winner == ' ') {
                if (grid[index] == ' ') {
                  grid[index] = currentPlayer;
                  currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
                }

                winner = hasWinner();
              } if(winner != ' ') {

                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("$winner Won!"),
                        content: Text("You have been beated by $winner!"),
                        actions: [
                          TextButton(onPressed: () {
                            setState(() {
                              if(winner == 'X'){
                                playerX++;
                              }
                              else{
                                playerO++;
                              }
                              grid = List.generate(9, (index) => ' ', growable: false);
                              currentPlayer = 'X';
                              winner = ' ';
                              Navigator.pop(context);
                            });
                          }, child: Text("Restart"))
                        ],
                      );
                    });
              }

              winner = hasWinner();
            });
          },
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              child: Center(
                child: Text(
                  grid[index],
                  style: TextStyle(color: Colors.white, fontSize: 50),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget scoreBoard() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text("Player O", style: textStyle),
              Text(playerO.toString(), style: textStyle)
            ],
          ),
          Column(
            children: [
              Text("Player X", style: textStyle),
              Text(playerX.toString(), style: textStyle)
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight),
        child: AppBar(
          title: const Text("Tic Tac Toe"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    grid = List.generate(9, (index) => ' ', growable: false);
                    currentPlayer = 'X';
                    winner = ' ';
                  });
                },
                icon: const Icon(Icons.restart_alt_rounded))
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: appBarHeight + 30),
        color: Colors.black87,
        child: Column(
          children: [
            scoreBoard(),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Current Move: $currentPlayer',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(flex: 3, child: Container(child: showGrid())),
          ],
        ),
      ),
    );
  }
}
