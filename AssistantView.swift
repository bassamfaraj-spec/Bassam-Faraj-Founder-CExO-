import SwiftUI
import Combine

struct AssistantMessage: Identifiable, Equatable {
    enum Role { case user, assistant }
    let id: UUID
    let role: Role
    let text: String

    init(role: Role, text: String, id: UUID = UUID()) {
        self.role = role
        self.text = text
        self.id = id
    }
}

struct AssistantView: View {
    @State private var input: String = ""
    @State private var isSending: Bool = false
    @State private var streaming: Bool = true
    @State private var localOnly: Bool = false
    @State private var messages: [AssistantMessage] = [
        .init(role: .assistant, text: "Hi! I’m Phoenix. How can I help?")
    ]

    var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader { proxy in
                List(messages) { msg in
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: msg.role == .assistant ? "sparkles" : "person.fill")
                            .foregroundStyle(msg.role == .assistant ? .orange : .accentColor)
                        Text(msg.text)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .listRowSeparator(.hidden)
                    .id(msg.id)
                }
                .listStyle(.plain)
                .onChange(of: messages) { _ in
                    if let lastID = messages.last?.id {
                        withAnimation {
                            proxy.scrollTo(lastID, anchor: .bottom)
                        }
                    }
                }
            }

            Divider()

            VStack(spacing: 8) {
                Toggle("Stream", isOn: $streaming)
                    .toggleStyle(.switch)
                    .font(.caption)
                    .padding(.horizontal, 12)

                Toggle("Local Only", isOn: $localOnly)
                    .toggleStyle(.switch)
                    .font(.caption)
                    .padding(.horizontal, 12)

                HStack(alignment: .bottom, spacing: 8) {
                    TextField("Ask Phoenix…", text: $input, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                        .lineLimit(1...4)
                    Button {
                        Task { await send() }
                    } label: {
                        if isSending {
                            ProgressView()
                        } else {
                            Image(systemName: "paperplane.fill")
                        }
                    }
                    .disabled(input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isSending)
                }
                .padding(12)
                .background(.thinMaterial)
            }
        }
        .navigationTitle("Assistant")
        .onReceive(NotificationCenter.default.publisher(for: .assistantActionStatus)) { note in
            if let msg = note.userInfo?[AssistantStatusKeys.message] as? String {
                messages.append(.init(role: .assistant, text: msg))
            }
        }
    }

    private func send() async {
        let prompt = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !prompt.isEmpty else { return }
        await MainActor.run {
            isSending = true
            messages.append(.init(role: .user, text: prompt))
            input = ""
            messages.append(.init(role: .assistant, text: "…"))
        }
        if streaming {
            var latestIndex: Int? = nil
            await MainActor.run { latestIndex = messages.indices.last }
            do {
                for try await chunk in AssistantService.shared.stream(to: prompt, localOnly: localOnly) {
                    await MainActor.run {
                        if let idx = latestIndex {
                            messages[idx] = AssistantMessage(role: .assistant, text: chunk, id: messages[idx].id)
                        }
                    }
                }
                await MainActor.run {
                    isSending = false
                }
            } catch {
                await MainActor.run {
                    if let idx = latestIndex {
                        messages[idx] = AssistantMessage(role: .assistant, text: "Error: \(error.localizedDescription)", id: messages[idx].id)
                    }
                    isSending = false
                }
            }
        } else {
            do {
                let reply = try await AssistantService.shared.respond(to: prompt, localOnly: localOnly)
                await MainActor.run {
                    if let idx = messages.indices.last {
                        messages[idx] = AssistantMessage(role: .assistant, text: reply, id: messages[idx].id)
                    }
                    isSending = false
                }
            } catch {
                await MainActor.run {
                    if let idx = messages.indices.last {
                        messages[idx] = AssistantMessage(role: .assistant, text: "Error: \(error.localizedDescription)", id: messages[idx].id)
                    }
                    isSending = false
                }
            }
        }
    }
}

#Preview {
    NavigationStack { AssistantView() }
}
