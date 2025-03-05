import SwiftUI

public struct CustomAuthTextField: View {
    @Binding var text: String
    var label: String
    var isSecureField: Bool = false
    @State private var isPasswordVisible: Bool = false

    public var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.headline)
                .foregroundColor(.gray)

            ZStack(alignment: .trailing) {
                if isSecureField {
                    if isPasswordVisible {
                        TextField("Mot de passe", text: $text)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(Color("Beige", bundle: .main))

                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                            .textFieldStyle(.plain)
                    } else {
                        SecureField("Mot de passe", text: $text)
                            .padding()
                            .foregroundColor(Color("Beige", bundle: .main))

                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                            .textFieldStyle(.plain)
                    }
                } else {
                    TextField("Entrer votre " + label.lowercased() , text: $text)
                        .padding()
                        .foregroundColor(Color("Beige", bundle: .main))

                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                        .textFieldStyle(.plain)
                }

                if isSecureField {
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(Color("Beige", bundle: .main))
                            .padding(.trailing, 8)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    CustomAuthTextField(text: .constant("example@example.com"), label: "Email", isSecureField: false)
}

