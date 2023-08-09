import SwiftUI

struct OTPInputView: View {
    @State private var otp: String = ""
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                ForEach(0..<4, id: \.self) { index in
                    DigitView(text: binding(forIndex: index), isLast: index == 3)
                }
            }
            .padding(.vertical, 20)
        }
    }
    
    private func binding(forIndex index: Int) -> Binding<String> {
        Binding(
            get: {
                guard index < otp.count else { return "" }
                let digitIndex = otp.index(otp.startIndex, offsetBy: index)
                return String(otp[digitIndex])
            },
            set: { newValue in
                if newValue.count <= 1 {
                    if index < otp.count {
                        otp = String(otp.prefix(index)) + newValue + String(otp.suffix(from: otp.index(otp.startIndex, offsetBy: index + 1)))
                    } else {
                        otp += newValue
                    }
                    if index < 3 && newValue.count == 1 {
                        withAnimation {
                            UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
                        }
                    }
                }
            }
        )
    }
}

struct DigitView: View {
    @Binding var text: String
    var isLast: Bool
    
    var body: some View {
        Rectangle()
            .frame(width: 20, height: 2)
            .foregroundColor(.gray)
            .overlay(
                Text(text)
                    .font(.title)
                    .foregroundColor(.black)
            )
            .onChange(of: text, perform: { newValue in
                if isLast && newValue.count == 1 {
                    withAnimation {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
            })
    }
}

struct OTPInputView_Previews: PreviewProvider {
    static var previews: some View {
        OTPInputView()
    }
}
