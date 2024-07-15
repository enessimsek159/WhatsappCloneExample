

import SwiftUI

struct Chat: Identifiable {
    let id = UUID()
    let name: String
    let message: String
    let time: String
    let isRead: Bool
    let imageName: String
}

struct ChatRow: View {
    var chat: Chat

    var body: some View {
        HStack {
            Image(chat.imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(chat.name)
                    .font(.headline)
                Text(chat.message)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack {
                Text(chat.time)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                if chat.isRead {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                }
            }
        }
        .padding(.vertical, 8)
    }
}

struct ContentView: View {
    @State private var searchText = ""
    let chats = [
        Chat(name: "Leia Organa", message: "Hi from the codepen", time: "1.36 pm", isRead: false, imageName: "icon1"),
        Chat(name: "Luke Skywalker", message: "Www.apple.com", time: "5.18 pm", isRead: true, imageName: "icon2"),
        Chat(name: "A new", message: "😊😊😊", time: "4.51 pm", isRead: false, imageName: "icon3"),
        // Add more Chat instances as needed
    ]
    
    var filteredChats: [Chat] {
        if searchText.isEmpty {
            return chats
        } else {
            return chats.filter { $0.name.contains(searchText) || $0.message.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                List(filteredChats) { chat in
                    ChatRow(chat: chat)
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle("Stream Chat", displayMode: .inline)
            .navigationBarItems(trailing:
                HStack {
                    Button(action: {
                        // more options action
                    }) {
                        Image(systemName: "ellipsis")
                    }
                }
            )
        }
    }
}


#Preview {
    ContentView()
}
