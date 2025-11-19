import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// Removed unused import: import 'dart:math';

// Import the swiping widget
import 'package:card_swiper/card_swiper.dart'; // Import the swiper package

// --- Data Classes ---
class ChatMessage {
  final String sender;
  final String text;
  final DateTime timestamp;

  ChatMessage({required this.sender, required this.text, required this.timestamp});
}

class InboxConversation {
  final String participantName;
  String lastMessage; // Made mutable to update on new messages
  DateTime timestamp; // Made mutable to update on new messages
  bool isUnread; // Made mutable

  InboxConversation({
    required this.participantName,
    required this.lastMessage,
    required this.timestamp,
    this.isUnread = false,
  });
}

// --- HomePage Widget ---
class HomePage extends StatefulWidget {
  final bool isRecruiter; // Determine user type after login/signup

  // Updated constructor syntax to use super.key
  const HomePage({super.key, required this.isRecruiter});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _userName = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _chatController = TextEditingController();
  bool _isEditingName = false;
  final SwiperController _swiperController = SwiperController();

  // State for Chat Screen (Inbox Toggle)
  // Removed unused variable: bool _isShowingInbox = true; // Start by showing the Inbox list
  InboxConversation? _selectedConversation; // Track the currently selected conversation

  // --- Data ---

  // Hackathons
  final List<Map<String, String>> _upcomingHackathons = [
    { 'title': 'HackFlutter', 'type': 'App Dev Online', 'date': '3/12/2024', 'image': 'images/hackflutter_image.png', },
    { 'title': 'Idea Ignite', 'type': 'Open Online', 'date': '6/26/2024', 'image': 'images/idea_ignite_image.png', },
    { 'title': 'Vision AI Hackathon', 'type': 'ML Online', 'date': '7/16/2024', 'image': 'images/vision_ai_image.png', },
  ];

  // Themes
  final List<String> _hackathonThemes = [ 'Web Dev', 'App Dev', 'ML', 'Blockchain', 'AR/VR', 'Cloud', ];

  // Resume Images (Recruiter)
  final List<String> _resumeImages = [
    'images/resume1.jpg', 'images/resume2.jpg', 'images/resume3.jpg', 'images/resume4.jpg',
    'images/resume5.jpg', // Abhishek's resume
    'images/resume6.jpg', 'images/resume7.jpg', 'images/resume8.jpg', 'images/resume9.png', 'images/resume10.png',
  ];

  // Inbox Messages (stores swipe actions) - This is separate from chat inbox
  final List<Map<String, dynamic>> _inboxMessages = [];

  // List of all Inbox Conversations (Visible in the inbox list)
  final List<InboxConversation> _inboxConversations = [
    InboxConversation(participantName: "Abhishek", lastMessage: "Will do! Thanks for your time, Omkar.", timestamp: DateTime.now().subtract(Duration(seconds: 30))), // Include Abhishek here
    InboxConversation(participantName: "Priya Sharma", lastMessage: "Thanks for the opportunity!", timestamp: DateTime.now().subtract(Duration(hours: 1)), isUnread: true),
    InboxConversation(participantName: "John Doe", lastMessage: "Okay, I will send the documents.", timestamp: DateTime.now().subtract(Duration(hours: 3))),
    InboxConversation(participantName: "Amit Singh", lastMessage: "Can we reschedule the call?", timestamp: DateTime.now().subtract(Duration(days: 1)), isUnread: true),
    InboxConversation(participantName: "Sarah Miller", lastMessage: "Great talking to you.", timestamp: DateTime.now().subtract(Duration(days: 2))),
    InboxConversation(participantName: "Vikram Patel", lastMessage: "Here is my portfolio link...", timestamp: DateTime.now().subtract(Duration(days: 2, hours: 5))),
    InboxConversation(participantName: "Neha Reddy", lastMessage: "Looking forward to the interview!", timestamp: DateTime.now().subtract(Duration(days: 3))),
    InboxConversation(participantName: "Rajesh Gupta", lastMessage: "Please find attached my cover letter.", timestamp: DateTime.now().subtract(Duration(days: 4)), isUnread: true),
    InboxConversation(participantName: "Anjali Desai", lastMessage: "Had a great time at the hackathon.", timestamp: DateTime.now().subtract(Duration(days: 5))),
  ];

  // Map to store messages for each participant (including Abhishek)
  final Map<String, List<ChatMessage>> _allChatMessages = {};

  @override
  void initState() {
    super.initState();
    // Initialize _allChatMessages with some fake data for each conversation
    _initializeFakeChatMessages();
  }

  void _initializeFakeChatMessages() {
    // Add Abhishek's existing messages
    _allChatMessages['Abhishek'] = [
      ChatMessage(sender: 'Abhishek', text: 'Hi Omkar, is the Software Dev position still open?', timestamp: DateTime.now().subtract(Duration(minutes: 10))),
      ChatMessage(sender: 'Omkar', text: 'Hi Abhishek! Yes, it is...', timestamp: DateTime.now().subtract(Duration(minutes: 9))),
      ChatMessage(sender: 'Abhishek', text: 'That is great! I saw the job post on the app.', timestamp: DateTime.now().subtract(Duration(minutes: 8))),
      ChatMessage(sender: 'Omkar', text: 'Awesome! Are you interested in applying?', timestamp: DateTime.now().subtract(Duration(minutes: 7))),
      ChatMessage(sender: 'Abhishek', text: 'Absolutely! I have a few questions though.', timestamp: DateTime.now().subtract(Duration(minutes: 6))),
      ChatMessage(sender: 'Omkar', text: 'Sure, ask away!', timestamp: DateTime.now().subtract(Duration(minutes: 5))),
      ChatMessage(sender: 'Abhishek', text: 'What are the required technical skills?', timestamp: DateTime.now().subtract(Duration(minutes: 4))),
      ChatMessage(sender: 'Omkar', text: 'We are looking for experience in Flutter, Dart, and some backend knowledge.', timestamp: DateTime.now().subtract(Duration(minutes: 3))),
      ChatMessage(sender: 'Abhishek', text: 'Perfect. I\'ll send you my resume shortly.', timestamp: DateTime.now().subtract(Duration(minutes: 2))),
      ChatMessage(sender: 'Omkar', text: 'Sounds good. Let me know if you have any other questions!', timestamp: DateTime.now().subtract(Duration(minutes: 1))),
      ChatMessage(sender: 'Abhishek', text: 'Will do! Thanks for your time, Omkar.', timestamp: DateTime.now().subtract(Duration(seconds: 30))),
    ];

    // Add some fake messages for other participants
    _allChatMessages['Priya Sharma'] = [
      ChatMessage(sender: 'Priya Sharma', text: 'Hello!', timestamp: DateTime.now().subtract(Duration(hours: 1, minutes: 5))),
      ChatMessage(sender: 'Omkar', text: 'Hi Priya, how can I help?', timestamp: DateTime.now().subtract(Duration(hours: 1, minutes: 3))),
      ChatMessage(sender: 'Priya Sharma', text: 'Just confirming the interview time.', timestamp: DateTime.now().subtract(Duration(hours: 1, minutes: 2))),
      ChatMessage(sender: 'Omkar', text: 'Yes, it is at 2 PM tomorrow.', timestamp: DateTime.now().subtract(Duration(hours: 1, minutes: 1))),
      ChatMessage(sender: 'Priya Sharma', text: 'Thanks for the opportunity!', timestamp: DateTime.now().subtract(Duration(hours: 1))),
    ];

    _allChatMessages['John Doe'] = [
      ChatMessage(sender: 'Omkar', text: 'Hi John, please send the documents.', timestamp: DateTime.now().subtract(Duration(hours: 3, minutes: 10))),
      ChatMessage(sender: 'John Doe', text: 'Okay, I will send the documents.', timestamp: DateTime.now().subtract(Duration(hours: 3))),
    ];

    _allChatMessages['Amit Singh'] = [
      ChatMessage(sender: 'Amit Singh', text: 'Hi, regarding the project update.', timestamp: DateTime.now().subtract(Duration(days: 1, hours: 2))),
      // Corrected: Use double quotes for the string literal with an apostrophe
      ChatMessage(sender: 'Omkar', text: "Sure, what's up?", timestamp: DateTime.now().subtract(Duration(days: 1, hours: 1))),
      ChatMessage(sender: 'Amit Singh', text: 'Can we reschedule the call?', timestamp: DateTime.now().subtract(Duration(days: 1))),
    ];

    _allChatMessages['Sarah Miller'] = [
      ChatMessage(sender: 'Sarah Miller', text: 'Following up on the meeting notes.', timestamp: DateTime.now().subtract(Duration(days: 2, hours: 1))),
      // Corrected: Use minutes instead of 0.5 hours
      ChatMessage(sender: 'Omkar', text: 'Got them, thanks.', timestamp: DateTime.now().subtract(Duration(days: 2, minutes: 30))),
      ChatMessage(sender: 'Sarah Miller', text: 'Great talking to you.', timestamp: DateTime.now().subtract(Duration(days: 2))),
    ];

    _allChatMessages['Vikram Patel'] = [
      ChatMessage(sender: 'Vikram Patel', text: 'Attaching my updated resume.', timestamp: DateTime.now().subtract(Duration(days: 2, hours: 6))),
      // Corrected: Use minutes instead of 0.5 hours
      ChatMessage(sender: 'Omkar', text: 'Received, thanks.', timestamp: DateTime.now().subtract(Duration(days: 2, minutes: 30))),
      ChatMessage(sender: 'Vikram Patel', text: 'Here is my portfolio link...', timestamp: DateTime.now().subtract(Duration(days: 2, hours: 5))),
    ];
    _allChatMessages['Neha Reddy'] = [
      ChatMessage(sender: 'Neha Reddy', text: 'Excited about the role!', timestamp: DateTime.now().subtract(Duration(days: 3, hours: 2))),
      // Corrected: Ensure integer for hours
      ChatMessage(sender: 'Omkar', text: 'We are too! Looking forward to the interview!', timestamp: DateTime.now().subtract(Duration(days: 3, hours: 1))),
      ChatMessage(sender: 'Neha Reddy', text: 'Looking forward to the interview!', timestamp: DateTime.now().subtract(Duration(days: 3))),
    ];
    _allChatMessages['Rajesh Gupta'] = [
      ChatMessage(sender: 'Rajesh Gupta', text: 'About the technical task.', timestamp: DateTime.now().subtract(Duration(days: 4, hours: 3))),
      ChatMessage(sender: 'Omkar', text: 'Any questions?', timestamp: DateTime.now().subtract(Duration(days: 4, hours: 2))),
      // Corrected: Removed isUnread from ChatMessage as it's an InboxConversation property
      ChatMessage(sender: 'Rajesh Gupta', text: 'Please find attached my cover letter.', timestamp: DateTime.now().subtract(Duration(days: 4))),
    ];
    _allChatMessages['Anjali Desai'] = [
      ChatMessage(sender: 'Anjali Desai', text: 'The hackathon was challenging but fun!', timestamp: DateTime.now().subtract(Duration(days: 5, hours: 4))),
      ChatMessage(sender: 'Omkar', text: 'Glad you enjoyed it!', timestamp: DateTime.now().subtract(Duration(days: 5, hours: 3))),
      ChatMessage(sender: 'Anjali Desai', text: 'Had a great time at the hackathon.', timestamp: DateTime.now().subtract(Duration(days: 5))),
    ];


    // Ensure all participants in _inboxConversations have an entry in _allChatMessages
    // Add empty lists for those who weren't explicitly added above, if needed.
    // Current implementation already adds lists above, this loop just ensures coverage.
    for (var conv in _inboxConversations) {
      if (!_allChatMessages.containsKey(conv.participantName)) {
        _allChatMessages[conv.participantName] = [
          // Add a default introductory message if needed, or leave empty
          // Example: ChatMessage(sender: conv.participantName, text: 'Hello!', timestamp: conv.timestamp),
        ];
      }
    }
  }


  // Add new chat message
  void _sendMessage() {
    // Only send if a conversation is selected and the message is not empty
    if (_chatController.text.isNotEmpty && _selectedConversation != null) {
      setState(() {
        // Determine the sender. In this fake chat setup:
        // If recruiter (Omkar), sender is Omkar.
        // If employee (Abhishek), sender is Abhishek.
        String sender = widget.isRecruiter ? 'Omkar' : 'Abhishek';

        ChatMessage newMessage = ChatMessage(sender: sender, text: _chatController.text, timestamp: DateTime.now());

        // Get the message list for the selected conversation and add the new message
        _allChatMessages[_selectedConversation!.participantName]?.add(newMessage);

        // Update the corresponding InboxConversation item in the list
        int convIndex = _inboxConversations.indexWhere((conv) => conv.participantName == _selectedConversation!.participantName);
        if (convIndex != -1) {
          // Update last message and timestamp
          _inboxConversations[convIndex].lastMessage = newMessage.text;
          _inboxConversations[convIndex].timestamp = newMessage.timestamp;

          // Set isUnread for the *other* person.
          // This logic assumes the current user sending the message makes it 'read' for them,
          // but potentially 'unread' for the recipient, if they were on the inbox screen.
          // If the recipient *is* the current user (e.g., Abhishek sending to himself),
          // setting isUnread might not make sense, but we'll set it to false for simplicity.
          bool isMessageFromCurrentUser = (widget.isRecruiter && sender == 'Omkar') || (!widget.isRecruiter && sender == 'Abhishek');

          if (_selectedConversation!.participantName != sender) {
            // Message sent to someone else, potentially unread for them.
            // For this fake data, we'll just set it to false for now, as we don't simulate the other user opening it.
            _inboxConversations[convIndex].isUnread = false; // Keep false for simplicity in fake chat
          } else {
            // Message sent to self (e.g., Abhishek sending to Abhishek, Omkar to Omkar)
            _inboxConversations[convIndex].isUnread = false;
          }


          // Move the updated conversation to the top of the list to show the latest activity
          InboxConversation updatedConv = _inboxConversations.removeAt(convIndex);
          _inboxConversations.insert(0, updatedConv);
        } else {
          // This case indicates a logic error where _selectedConversation is not in _inboxConversations
          print("Error: Selected conversation not found in inbox list during send.");
        }

        _chatController.clear(); // Clear the input field
      });
      print("Message Sent to ${_selectedConversation!.participantName}!");
    } else if (_selectedConversation == null) {
      print("No conversation selected to send message.");
    } else {
      print("Attempted to send empty message.");
    }
  }

  // Record swipe action (This method is still here but not triggered by buttons anymore)
  // Kept this method but it is currently unused according to the analyzer.
  void _recordSwipeAction(int index, String action) {
    if (index < 0 || index >= _resumeImages.length) return;
    String resumePath = _resumeImages[index];
    String candidateIdentifier = (resumePath == 'images/resume5.jpg') ? 'Abhishek' : 'Resume ${index + 1} (${resumePath.split('/').last})';

    setState(() {
      _inboxMessages.add({
        'candidate': candidateIdentifier, 'action': action, 'timestamp': DateTime.now(), 'resumePath': resumePath
      });
      // TODO: Optionally add this notification directly to _inboxConversations or a separate notification list
    });

    print("Action recorded for $candidateIdentifier: $action");
    // Show quick popup (SnackBar)
    ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(
        SnackBar(
          content: Text("$candidateIdentifier: $action"),
          backgroundColor: action == 'Accepted' ? Colors.green : Colors.redAccent,
          duration: Duration(seconds: 1), // Make it faster
        )
    );
    // swiperController.next() is still called elsewhere, which is fine for navigation
    // _swiperController.next(animation: true); // Removed if you don't want swipe to auto-advance on action
  }

  // Handles selecting/deselecting conversation and switching views
  // This method replaces the functionality of the old _isShowingInbox flag logic for view switching.
  void _toggleChatView({InboxConversation? conversation}) {
    setState(() {
      if (conversation != null) {
        _selectedConversation = conversation;
        // Mark the conversation as read when opened
        int convIndex = _inboxConversations.indexWhere((conv) => conv.participantName == conversation.participantName);
        if (convIndex != -1) {
          _inboxConversations[convIndex].isUnread = false;
        }
      } else {
        _selectedConversation = null; // Deselect conversation (Go back to inbox list)
      }
    });
  }


  // Placeholder for navigating to dedicated Inbox Screen (prints for now)
  // This method is currently unused according to the analyzer.
  void _navigateToInbox() {
    print("--- Inbox Activity (from Swipes) ---");
    if (_inboxMessages.isEmpty) { print("No swipe actions recorded yet."); }
    else {
      _inboxMessages.sort((a, b) => (b['timestamp'] as DateTime).compareTo(a['timestamp'] as DateTime));
      _inboxMessages.forEach((message) { print("${DateFormat('yyyy-MM-dd hh:mm a').format(message['timestamp'])} - ${message['candidate']}: ${message['action']}"); });
    }
    print("----------------------");
    // For now, just show the main chat inbox view
    _toggleChatView(conversation: null); // Go back to the inbox list view
  }

  // Helper to generate Avatar
  Widget _getAvatar(String name, {double radius = 20}) {
    Color backgroundColor;
    // Use specific images for Omkar/Abhishek
    if (name == 'Omkar') {
      return CircleAvatar(radius: radius, backgroundImage: const AssetImage('images/omkar.png'), onBackgroundImageError: (_, __) { print("Error loading Omkar image");});
    } else if (name == 'Abhishek') {
      return CircleAvatar(radius: radius, backgroundImage: const AssetImage('images/abhishek.png'), onBackgroundImageError: (_, __) { print("Error loading Abhishek image");});
    } else {
      // Generate color from name hash
      final int hue = name.hashCode % 360;
      // Used Color.fromARGB instead of HSLColor for simplicity, common pattern
      backgroundColor = Color.fromARGB(255, (hue * 0.7).toInt() % 255, (hue * 0.5).toInt() % 255, (hue * 0.9).toInt() % 255);

      return CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor,
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : '?', // First letter or '?'
          style: TextStyle(color: Colors.white, fontSize: radius * 0.9, fontWeight: FontWeight.bold),
        ),
      );
    }
  }


  // --- Build Methods ---

  Widget _buildHomeScreen() {
    return SingleChildScrollView( /* ... HomeScreen UI ... */
      padding: const EdgeInsets.all(16.0),
      child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text( 'Upcoming Hackathons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), ),
        const SizedBox(height: 10),
        ListView.builder( shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: _upcomingHackathons.length, itemBuilder: (context, index) { final hackathon = _upcomingHackathons[index]; return Card( elevation: 2, shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(12), ), margin: const EdgeInsets.symmetric(vertical: 8), child: Padding( padding: const EdgeInsets.all(12.0), child: Row( children: [ SizedBox( width: 80, height: 80, child: Image.asset( hackathon['image'] ?? 'images/placeholder_image.png', fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) { print("Error loading hackathon image: ${hackathon['image']}"); return Icon(Icons.image_not_supported, size: 80); }, ), ), const SizedBox(width: 12), Expanded( child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [ Text( hackathon['title'] ?? '', style: const TextStyle( fontWeight: FontWeight.bold, fontSize: 16, ), ), Text( hackathon['type'] ?? '', style: const TextStyle(color: Colors.grey), ), Row( children: [ const Icon(Icons.calendar_today, size: 14, color: Colors.grey), const SizedBox(width: 4), Text( hackathon['date'] ?? '', style: const TextStyle(color: Colors.grey), ), ], ), ], ), ), ElevatedButton( onPressed: () {}, child: const Text('Join'), ), ], ), ), ); }, ),
        const SizedBox(height: 20),
        const Text( 'Hackathon Themes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), ),
        const SizedBox(height: 10),
        Wrap( spacing: 8.0, runSpacing: 8.0, children: _hackathonThemes .map((theme) => Chip( label: Text(theme), )) .toList(), ),
      ], ),
    );
  }

  Widget _buildProfileScreen() {
    return Padding( /* ... Profile Screen UI ... */
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView( child: Column( crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
        const SizedBox(height: 30),
        GestureDetector( onTap: () { print('Change profile picture'); }, child: Padding( padding: const EdgeInsets.all(12.0), child: Stack( children: [
          // Use _getAvatar helper here too for consistency if needed, or keep specific images
          CircleAvatar( radius: 70, backgroundImage: AssetImage(widget.isRecruiter ? 'images/omkar.png' : 'images/abhishek.png'), onBackgroundImageError: (_, __) { print("Error loading profile image"); }, child: const Text(''), ),
          Positioned( bottom: 8, right: 8, child: Container( decoration: BoxDecoration(color: (widget.isRecruiter ? Colors.blue : Colors.green).withAlpha((255 * 0.2).round()), borderRadius: BorderRadius.circular(20), boxShadow: [ BoxShadow(color: Colors.black.withOpacity(0.2), spreadRadius: 1, blurRadius: 3, offset: const Offset(0, 1), ), ], ), padding: const EdgeInsets.all(8), child: const Icon( Icons.edit, size: 20, color: Colors.white, ), ), ), ], ), ), ),
        const SizedBox(height: 24),
        if (_isEditingName) ...[ TextField( controller: _nameController, decoration: const InputDecoration( labelText: 'Your Name', border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), ), onSubmitted: (value) { setState(() { _userName = value.trim(); _isEditingName = false; }); }, ), const SizedBox(height: 16), ElevatedButton( onPressed: () { setState(() { _userName = _nameController.text.trim(); _isEditingName = false; }); }, child: const Text('Save Name'), ), ]
        else ...[ Row( mainAxisAlignment: MainAxisAlignment.center, children: [ Text( _userName.isNotEmpty ? _userName : (widget.isRecruiter ? 'Omkar' : 'Abhishek'), style: const TextStyle( fontSize: 24, fontWeight: FontWeight.bold, ), ), IconButton( icon: const Icon(Icons.edit), onPressed: () { setState(() { _isEditingName = true; _nameController.text = _userName.isNotEmpty ? _userName : (widget.isRecruiter ? 'Omkar' : 'Abhishek'); }); }, color: widget.isRecruiter ? Colors.blue.shade500 : Colors.green.shade500, ), ], ), ],
        const SizedBox(height: 30),
        const Text( 'Open Source License', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold, ), ), const SizedBox(height: 12), const Text( 'This app uses the following open-source licenses:', textAlign: TextAlign.center, ), const SizedBox(height: 12), ElevatedButton( onPressed: () { _showLicenseDialog(context); }, child: const Text('View Licenses'), ), const SizedBox(height: 30), ElevatedButton( onPressed: () { print('Logout button pressed'); Navigator.of(context).pushNamedAndRemoveUntil('/welcome', (Route<dynamic> route) => false); }, style: ElevatedButton.styleFrom( backgroundColor: Colors.redAccent, ), child: const Text('Log Out'), ), const SizedBox(height: 30),
      ], ), ),
    );
  }

  void _showLicenseDialog(BuildContext context) {
    showDialog( /* ... License Dialog ... */ context: context, builder: (context) { return AlertDialog( title: const Text('Open Source Licenses'), content: SingleChildScrollView( child: ListBody( children: const <Widget>[ Text( 'This app uses the following open-source licenses:', style: TextStyle(fontWeight: FontWeight.bold), ), Text('\n- Flutter: BSD 3-Clause License'), Text('- Intl: BSD 3-Clause License'), Text('- card_swiper: MIT License'), ], ), ), actions: <Widget>[ TextButton( child: const Text('Close'), onPressed: () { Navigator.of(context).pop(); }, ), ], ); }, );
  }

  // --- UPDATED SWIPING SCREEN (Resumes) ---
  Widget _buildSwipingScreen() {
    if (!widget.isRecruiter) {
      return Center(child: Text("Resume swiping is only available for recruiters."));
    }
    if (_resumeImages.isEmpty) {
      return Center(child: Text('No resumes to swipe right now.'));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Review Resumes',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Swiper(
              controller: _swiperController,
              itemBuilder: (BuildContext context, int index) {
                if (index >= _resumeImages.length) return SizedBox.shrink();
                final resumePath = _resumeImages[index];

                return Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 4,
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(12), ),
                  child: Column( // Main column for Image + potentially other content
                    children: [
                      // Image Area
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          color: Colors.grey.shade200,
                          padding: const EdgeInsets.all(4.0), // Small padding around image
                          child: Image.asset(
                            resumePath,
                            fit: BoxFit.contain, // Important: Fits entire image
                            errorBuilder: (context, error, stackTrace) {
                              print("Error loading resume image: $resumePath, Error: $error");
                              return Center(child: Column( mainAxisSize: MainAxisSize.min, children: [ Icon(Icons.broken_image, size: 50, color: Colors.grey), SizedBox(height: 8), Text("Error loading resume", style: TextStyle(color: Colors.grey)), ],));
                            },
                          ),
                        ),
                      ),

                      // Removed: Action Buttons Area (The row with Reject and Accept buttons)
                      // The entire Padding containing the Row below has been removed.
                    ],
                  ),
                );
              },
              itemCount: _resumeImages.length,
              layout: SwiperLayout.DEFAULT,
              loop: true, // Loop resumes
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }


  // --- UPDATED CHAT SCREEN (With Inbox Toggle and Specific Chats) ---
  Widget _buildChatScreen() {
    // Determine the title of the header based on whether a conversation is selected
    String headerTitle = _selectedConversation != null ? _selectedConversation!.participantName : "Inbox";

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 0),
      child: Column(
        children: [
          // --- Header Row ---
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back to Inbox button (shown when a conversation is selected)
                if (_selectedConversation != null)
                  IconButton(
                    // Using the backarrow.png image as the icon
                    icon: ImageIcon( // Use ImageIcon for asset images
                      AssetImage('images/backarrow.png'), // Your back arrow image
                      color: widget.isRecruiter ? Colors.blue : Colors.green, // Apply theme color
                    ),
                    onPressed: () => _toggleChatView(conversation: null), // Go back to inbox list by deselecting conversation
                    tooltip: 'Back to Inbox',
                  )
                else
                // Placeholder to keep the title centered when on the Inbox list
                  SizedBox(width: 48), // Roughly match the width of the IconButton


                // Title and Avatar (changes based on selected conversation or shows "Inbox")
                Expanded( // Use Expanded to allow the title/avatar section to take available space
                  child: Center( // Center the content within the Expanded area
                    child: _selectedConversation != null
                        ? Row( // Show participant avatar and name when conversation is selected
                      mainAxisSize: MainAxisSize.min, // Keep the row compact
                      children: [
                        _getAvatar(headerTitle, radius: 20), // Avatar of the participant
                        SizedBox(width: 8),
                        Text(
                          headerTitle,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                        : Text( // Show "Inbox" title when no conversation is selected
                      "Inbox",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                // Placeholder on the right to balance the layout (matching the back button width)
                // You could add a search or menu icon here if needed later.
                SizedBox(width: 48),


              ],
            ),
          ),
          Divider(),

          // --- Conditional Content Area ---
          Expanded(
            // If _selectedConversation is null, show the Inbox list.
            // Otherwise, show the chat view for the selected conversation.
            child: _selectedConversation == null
                ? _buildInboxList() // Show Inbox List
                : _buildConversationView(widget.isRecruiter ? 'Omkar' : 'Abhishek', _selectedConversation!), // Show Selected Chat, passing the current user and the conversation
          ),
        ],
      ),
    );
  }

  // --- Helper Widget for Inbox List ---
  Widget _buildInboxList() {
    if (_inboxConversations.isEmpty) {
      return Center(child: Text("Your inbox is empty."));
    }
    // Sort conversations by timestamp descending (newest first)
    _inboxConversations.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return ListView.builder(
      itemCount: _inboxConversations.length,
      itemBuilder: (context, index) {
        final conversation = _inboxConversations[index];
        return ListTile(
          leading: _getAvatar(conversation.participantName, radius: 24), // Use helper
          title: Text(
            conversation.participantName,
            style: TextStyle(fontWeight: conversation.isUnread ? FontWeight.bold : FontWeight.normal),
          ),
          subtitle: Text(
            conversation.lastMessage,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: conversation.isUnread ? FontWeight.bold : FontWeight.normal, color: Colors.grey.shade600),
          ),
          trailing: Text(
            DateFormat('hh:mm a').format(conversation.timestamp), // Or relative time
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          onTap: () {
            // When an inbox item is tapped, select the conversation and show the chat view
            _toggleChatView(conversation: conversation);
            print("Tapped on conversation with ${conversation.participantName}");
            // In a real app, you would load the actual messages for this conversation here
          },
        );
      },
    );
  }

  // --- Helper Widget for Conversation View (Messages + Input) ---
  // Now takes the specific InboxConversation
  Widget _buildConversationView(String currentUser, InboxConversation conversation) {
    // Get the list of messages for the selected conversation from the map
    List<ChatMessage> messages = _allChatMessages[conversation.participantName] ?? [];

    return Column(
      children: [
        Expanded( // Message List area
          child: ListView.builder(
            reverse: true, // Show latest messages at the bottom
            itemCount: messages.length, // Use the messages for this specific conversation
            itemBuilder: (context, index) {
              // Build messages from latest to oldest
              final message = messages[messages.length - 1 - index];
              // Determine if the message is from the current user.
              // This logic assumes 'Omkar' is the current user if isRecruiter is true,
              // and 'Abhishek' is the current user if isRecruiter is false.
              final isMe = (widget.isRecruiter && message.sender == 'Omkar') || (!widget.isRecruiter && message.sender == 'Abhishek');
              return _buildChatBubble(message, isMe);
            },
          ),
        ),
        Divider(), // Separator between messages and input
        Padding( // Input Area
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Row( children: [
            Expanded( child: TextField( controller: _chatController, decoration: InputDecoration( hintText: 'Type your message...', filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(25), borderSide: BorderSide(color: Colors.grey.shade300), ), enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(25), borderSide: BorderSide(color: Colors.grey.shade300), ), focusedBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(25), borderSide: BorderSide(color: widget.isRecruiter ? Colors.blue : Colors.green, width: 1.5), ), contentPadding: const EdgeInsets.symmetric( horizontal: 16, vertical: 10), ), textInputAction: TextInputAction.send, onSubmitted: (_) => _sendMessage(), // Send message when pressing enter
            ),
            ),
            const SizedBox(width: 8),
            // Send Button
            ElevatedButton(
              onPressed: _sendMessage, // Call _sendMessage when the button is pressed
              child: const Text('Sent'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder( // Rounded corners for the button
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Adjust padding
              ),
            ),
          ], ),
        ),
      ],
    );
  }


  Widget _buildChatBubble(ChatMessage message, bool isMe) {
    // ... (ChatBubble code remains the same - determines alignment and color) ...
    final alignment = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    // Determine bubble color based on whether the message is from the current user
    final bubbleColor = isMe ? (widget.isRecruiter ? Colors.blue.shade100 : Colors.green.shade100) : Colors.grey.shade200;
    final textColor = Colors.black87;

    return Container( margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), child: Column( crossAxisAlignment: alignment, children: [
      // Optional: Show sender name for incoming messages (not from current user)
      if (!isMe)
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0, left: 8.0),
          child: Text(message.sender, style: TextStyle(fontSize: 10, color: Colors.grey.shade700)),
        ),
      Container( padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0), constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75), decoration: BoxDecoration( color: bubbleColor, borderRadius: BorderRadius.only( topLeft: Radius.circular(12), topRight: Radius.circular(12), bottomLeft: isMe ? Radius.circular(12) : Radius.circular(0), bottomRight: isMe ? Radius.circular(0) : Radius.circular(12), ) ), child: Text( message.text, style: TextStyle(color: textColor), ), ), SizedBox(height: 2), Text( DateFormat('hh:mm a').format(message.timestamp), style: TextStyle(color: Colors.grey.shade600, fontSize: 10), ) ], ), );
  }


  // --- Main Build Method ---
  @override
  Widget build(BuildContext context) {
    // Define themes based on user type
    ThemeData theme = widget.isRecruiter
        ? ThemeData( /* ... Recruiter Theme (Blue) ... */
        primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.white, appBarTheme: const AppBarTheme( backgroundColor: Colors.blue, foregroundColor: Colors.white, elevation: 1, ), bottomNavigationBarTheme: BottomNavigationBarThemeData( selectedItemColor: Colors.blue, unselectedItemColor: Colors.grey.shade600, backgroundColor: Colors.white, elevation: 4, type: BottomNavigationBarType.fixed, ), chipTheme: ChipThemeData( backgroundColor: Colors.blue.shade50, labelStyle: TextStyle(color: Colors.blue.shade800), side: BorderSide(color: Colors.blue.shade200), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), ), elevatedButtonTheme: ElevatedButtonThemeData( style: ElevatedButton.styleFrom( backgroundColor: Colors.blue, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16), elevation: 2, ), )
    )
        : ThemeData( /* ... Employee Theme (Green) ... */
        primarySwatch: Colors.green, scaffoldBackgroundColor: Colors.white, appBarTheme: const AppBarTheme( backgroundColor: Colors.green, foregroundColor: Colors.white, elevation: 1, ), bottomNavigationBarTheme: BottomNavigationBarThemeData( selectedItemColor: Colors.green, unselectedItemColor: Colors.grey.shade600, backgroundColor: Colors.white, elevation: 4, type: BottomNavigationBarType.fixed, ), chipTheme: ChipThemeData( backgroundColor: Colors.green.shade50, labelStyle: TextStyle(color: Colors.green.shade800), side: BorderSide(color: Colors.green.shade200), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), ), elevatedButtonTheme: ElevatedButtonThemeData( style: ElevatedButton.styleFrom( backgroundColor: Colors.green, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16), elevation: 2, ), )
    );

    // Determine AppBar title for the main Scaffold AppBar
    String mainAppBarTitle = 'Home'; // Default title
    if (widget.isRecruiter) {
      switch (_selectedIndex) {
        case 1: mainAppBarTitle = 'Profile'; break;
        case 2: mainAppBarTitle = 'Review Resumes'; break;
        case 3: mainAppBarTitle = 'Chat'; break; // Main AppBar title for Chat tab
      }
    } else {
      switch (_selectedIndex) {
        case 1: mainAppBarTitle = 'Profile'; break;
        case 2: mainAppBarTitle = 'Chat'; break; // Main AppBar title for Chat tab
      }
    }


    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(
          title: Text(mainAppBarTitle), // Use the main AppBar title
          // *** Added leading backarrow.png back to the main AppBar ***
          leading: IconButton(
            icon: Image.asset(
              'images/backarrow.png', // Your back arrow image
              width: 24, // Adjust size as needed
              height: 24, // Adjust size as needed
            ),
            onPressed: () {
              // This will try to pop the current screen off the navigator stack.
              // If HomePage is the very first screen, this might do nothing
              // or close the app, depending on your app's root setup.
              Navigator.of(context).pop();
            },
            tooltip: 'Back', // Added tooltip for accessibility
          ),
        ),
        body: _buildPage(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildPage() {
    // Select screen based on index and user type
    if (widget.isRecruiter) {
      switch (_selectedIndex) {
        case 0: return _buildHomeScreen();
        case 1: return _buildProfileScreen();
        case 2: return _buildSwipingScreen(); // Swipe screen at index 2 for recruiter
        case 3: return _buildChatScreen(); // Chat screen at index 3 for recruiter
        default: return _buildHomeScreen();
      }
    } else {
      // Employee View: Home (0), Profile (1), Chat (2)
      switch (_selectedIndex) {
        case 0: return _buildHomeScreen();
        case 1: return _buildProfileScreen();
        case 2: return _buildChatScreen(); // Chat screen at index 2 for employee
        default: return _buildHomeScreen();
      }
    }
  }

  Widget _buildBottomNavigationBar() {
    // Build items based on user type
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem( icon: Image.asset( 'images/home.png', width: 24, height: 30, color: _selectedIndex == 0 ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor, ), label: 'Home'),
      BottomNavigationBarItem( icon: Image.asset( 'images/profile.png', width: 24, height: 30, color: _selectedIndex == 1 ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor, ), label: 'Profile'),
    ];

    if (widget.isRecruiter) { // Add Swipe for Recruiter at index 2
      items.add(BottomNavigationBarItem( icon: Image.asset( 'images/swipe.png', width: 24, height: 30, color: _selectedIndex == 2 ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor, ), label: 'Swipe'));
    }

    // Add Chat for Recruiter at index 3 OR Employee at index 2
    int chatIndex = widget.isRecruiter ? 3 : 2;
    items.add(BottomNavigationBarItem( icon: Image.asset( 'images/chat.png', width: 24, height: 30, color: _selectedIndex == chatIndex ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor, ), label: 'Chat'));

    return BottomNavigationBar(
      items: items,
      currentIndex: _selectedIndex,
      onTap: (index) {
        // When switching to the chat tab, ensure the inbox list is shown initially
        if (index == chatIndex) {
          // If we are already on the chat tab and a conversation is selected,
          // tapping the chat icon again could potentially go back to the inbox.
          // For now, we'll just ensure the inbox list is shown if no conversation is selected.
          if (_selectedConversation == null) {
            _toggleChatView(conversation: null); // Ensure inbox list is visible
          }
        } else {
          // When switching away from the chat tab, deselect any open conversation
          _selectedConversation = null;
        }
        setState(() { _selectedIndex = index; });
      },
      showUnselectedLabels: true, selectedFontSize: 12, unselectedFontSize: 12,
    );
  }
}

