import SwiftUI

enum ButtonType: String {
    case first, second, third, forth, fifth, sixth, seventh, eighth, nineth, zero
    case comma, equal, plus, minus, multiple,devide
    case percent, opposite, clear
    
    var ButtonDisplayName: String {
        switch self {
        case .first :
            return "1"
        case .second :
            return "2"
        case .third :
            return "3"
        case .forth :
            return "4"
        case .fifth :
            return "5"
        case .sixth :
            return "6"
        case .seventh :
            return "7"
        case .eighth :
            return "8"
        case .nineth :
            return "9"
        case .zero :
            return "0"
        case .comma :
            return "."
        case .equal :
            return "="
        case .plus :
            return "+"
        case .minus :
            return "-"
        case .multiple :
            return "x"
        case .devide :
            return "÷"
        case .percent :
            return "%"
        case .opposite :
            return "+/-"
        case .clear :
            return "C"
        
        }
    }
    var BackgroundColor: Color {
        switch self {
        case .clear, .percent, .opposite :
            return Color.gray
        case .equal, .plus, .minus, .multiple, .devide :
            return Color.orange
        default :
            return Color("NumberBtn")
        }
    }
    var forgroundColor: Color {
        switch self {
        case .clear, .percent, .opposite :
            return Color.black
        default :
            return Color.white
        }
    }
}

struct ContentView: View {
    
    @State private var totalnumber: String = "|"
    @State var tempNumber: Int = 0
    @State var operatorType: ButtonType = .clear
    private let buttonData: [[ButtonType]] = [
        [.clear, .opposite, .percent, .devide],
        [.seventh, .eighth, .nineth, .multiple],
        [.forth, .fifth, .sixth, .minus],
        [.first, .second, .third, .plus],
        [.zero, .comma, .equal],
    ]
    
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Spacer()
                HStack{
                    Spacer()
                    Text(totalnumber)
                        .padding(50)
                        .font(.system(size: 70))
                        .foregroundColor(.white)
                }
                ForEach(buttonData, id: \.self) { line in
                    HStack {
                        ForEach(line, id: \.self) { item in
                            Button {
                                if totalnumber == "|" {
                                    if item == .clear {
                                        totalnumber = "|"
                                    } else if item == .plus ||
                                                item == .minus ||
                                                item == .multiple ||
                                                item == .devide ||
                                                item == .opposite ||
                                                item == .percent {
                                        totalnumber = "|"
                                    }
                                    else {
                                        totalnumber = item.ButtonDisplayName
                                    }
                                } else {
                                    if item == .clear {
                                        totalnumber = "|"
                                    } else if item == .plus ||
                                                item == .minus ||
                                                item == .multiple ||
                                                item == .devide ||
                                                item == .percent {
                                        tempNumber = Int(totalnumber) ?? 0
                                        operatorType = item
                                        totalnumber = "|"
                                    } else if item == .equal {
                                        if operatorType == .plus {
                                            totalnumber = String((Int(totalnumber) ?? 0) + tempNumber)
                                        } else if operatorType == .multiple {
                                            totalnumber = String(tempNumber * (Int(totalnumber) ?? 0))
                                        }
                                        else if operatorType == .minus {
                                            totalnumber = String(tempNumber - (Int(totalnumber) ?? 0))
                                        }
                                        else if operatorType == .percent {
                                            totalnumber = String(tempNumber % (Int(totalnumber) ?? 0))
                                        }
                                        else if operatorType == .devide {
                                            totalnumber = String(tempNumber / (Int(totalnumber) ?? 0))
                                        }
                                    } else if item == .opposite {
                                        tempNumber = Int(totalnumber) ?? 0
                                        totalnumber = String(tempNumber * -1)
                                    }
                                    else {
                                        totalnumber += item.ButtonDisplayName
                                    }
                                }
                            } label: {
                                Text(item.ButtonDisplayName)
                                    .frame(width: calculateButtonWidth(button: item), height: calculateButtonHeight(button: item))
                                    .background(item.BackgroundColor)
                                    .cornerRadius(40)
                                    .foregroundColor(item.forgroundColor)
                                    .font(.system(size:33))
                            }
                        }
                    }
                }
            }
        }
       
    }
    
    private func calculateButtonWidth(button buttonType: ButtonType) -> CGFloat {
        switch buttonType{
        case .zero:
            return (UIScreen.main.bounds.width - 5*10) / 4 * 2
        default:
            return (UIScreen.main.bounds.width - 5*10) / 4
        }
    }
    private func calculateButtonHeight(button: ButtonType) -> CGFloat {
        return (UIScreen.main.bounds.width - 5*10) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
