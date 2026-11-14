
import 'package:flutter/material.dart';

void main() {
  runApp(const WhatsAppApp());
}

class WhatsAppApp extends StatelessWidget {
  const WhatsAppApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF075E54),
        ),
        useMaterial3: true,
      ),
      home: const WhatsAppHome(),
    );
  }
}

class WhatsAppHome extends StatefulWidget {
  const WhatsAppHome({super.key});

  @override
  State<WhatsAppHome> createState() => _WhatsAppHomeState();
}

class _WhatsAppHomeState extends State<WhatsAppHome> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> chats = [
    {
      'name': 'Ahmed Ali',
      'message': 'How are you?',
      'time': '10:30 AM',
      'color': Colors.blue,
      'unread': 2,
    },
    {
      'name': 'Mohamed',
      'message': 'See you tomorrow!',
      'time': '09:45 AM',
      'color': Colors.orange,
      'unread': 1,
    },
    {
      'name': 'Family Group',
      'message': 'Thank you everyone ❤️',
      'time': 'Yesterday',
      'color': Colors.purple,
      'unread': 5,
    },
    {
      'name': 'Abdi Hassan',
      'message': 'Send me the project',
      'time': 'Yesterday',
      'color': Colors.green,
      'unread': 0,
    },
    {
      'name': 'Fatima',
      'message': 'Good morning',
      'time': 'Monday',
      'color': Colors.pink,
      'unread': 0,
    },
    {
      'name': 'Programming Group',
      'message': 'Flutter is amazing!',
      'time': 'Monday',
      'color': Colors.teal,
      'unread': 3,
    },
  ];

  final List<String> pages = [
    'Chats',
    'Updates',
    'Communities',
    'Calls',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF075E54),
        foregroundColor: Colors.white,
        title: Text(
          pages[selectedIndex] == 'Updates'
              ? 'Updates'
              : pages[selectedIndex] == 'Communities'
                  ? 'Communities'
                  : pages[selectedIndex],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ChatSearch(chats),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {},
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'New group',
                child: Text('New group'),
              ),
              const PopupMenuItem(
                value: 'Settings',
                child: Text('Settings'),
              ),
              const PopupMenuItem(
                value: 'Profile',
                child: Text('Profile'),
              ),
            ],
          ),
        ],
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: [
          chatPage(),
          updatesPage(),
          communitiesPage(),
          callsPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF075E54),
        foregroundColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('New chat selected')),
          );
        },
        child: const Icon(Icons.message),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFD5F5E8),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.chat_outlined),
            selectedIcon: Icon(Icons.chat),
            label: 'Chats',
          ),
          NavigationDestination(
            icon: Icon(Icons.circle_outlined),
            selectedIcon: Icon(Icons.circle),
            label: 'Updates',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            selectedIcon: Icon(Icons.groups),
            label: 'Communities',
          ),
          NavigationDestination(
            icon: Icon(Icons.call_outlined),
            selectedIcon: Icon(Icons.call),
            label: 'Calls',
          ),
        ],
      ),
    );
  }

  Widget chatPage() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Chip(
                backgroundColor: const Color(0xFFD5F5E8),
                label: const Text('All'),
              ),
              const SizedBox(width: 8),
              const Chip(label: Text('Unread')),
              const SizedBox(width: 8),
              const Chip(label: Text('Favorites')),
              const SizedBox(width: 8),
              const Chip(label: Text('Groups')),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 5,
                ),
                leading: CircleAvatar(
                  radius: 27,
                  backgroundColor: chat['color'],
                  child: Text(
                    chat['name'][0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  chat['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(chat['message']),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      chat['time'],
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    if (chat['unread'] > 0)
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: const Color(0xFF25D366),
                        child: Text(
                          '${chat['unread']}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        name: chat['name'],
                        color: chat['color'],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget updatesPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Status',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        ListTile(
          leading: const CircleAvatar(
            radius: 28,
            backgroundColor: Color(0xFF075E54),
            child: Icon(Icons.add, color: Colors.white),
          ),
          title: const Text('My status'),
          subtitle: const Text('Tap to add status update'),
          onTap: () {},
        ),
        const Divider(),
        const Text(
          'Recent updates',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        statusTile('Ahmed Ali', Colors.blue),
        statusTile('Mohamed', Colors.orange),
        statusTile('Fatima', Colors.pink),
      ],
    );
  }

  Widget statusTile(String name, Color color) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(
          name[0],
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(name),
      subtitle: const Text('Today, 10:00 AM'),
    );
  }

  Widget communitiesPage() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.groups, size: 80, color: Color(0xFF075E54)),
          SizedBox(height: 15),
          Text(
            'Stay connected with communities',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Bring groups together in one place.'),
        ],
      ),
    );
  }

  Widget callsPage() {
    return ListView(
      children: [
        const ListTile(
          leading: CircleAvatar(
            backgroundColor: Color(0xFFD5F5E8),
            child: Icon(Icons.link, color: Color(0xFF075E54)),
          ),
          title: Text('Create call link'),
          subtitle: Text('Share a link for your WhatsApp call'),
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Recent',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        callTile('Ahmed Ali', Colors.blue, true),
        callTile('Mohamed', Colors.orange, false),
        callTile('Fatima', Colors.pink, true),
      ],
    );
  }

  Widget callTile(String name, Color color, bool video) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(name[0], style: const TextStyle(color: Colors.white)),
      ),
      title: Text(name),
      subtitle: const Text('Today, 09:30 AM'),
      trailing: Icon(
        video ? Icons.videocam : Icons.call,
        color: const Color(0xFF075E54),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String name;
  final Color color;

  const ChatScreen({
    super.key,
    required this.name,
    required this.color,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();
  final List<String> messages = [];

  void sendMessage() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      messages.add(controller.text.trim());
      controller.clear();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF075E54),
        foregroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: widget.color,
              child: Text(
                widget.name[0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            Text(widget.name),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD5F5E8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(messages[index]),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Message',
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.emoji_emotions_outlined),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: const Color(0xFF075E54),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatSearch extends SearchDelegate {
  final List<Map<String, dynamic>> chats;

  ChatSearch(this.chats);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = chats.where((chat) {
      return chat['name']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text(results[index]['name']),
          subtitle: Text(results[index]['message']),
        );
      },
    );
  }
}
