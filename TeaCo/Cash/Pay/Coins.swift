import SwiftUI

struct Dime: View {
    var body: some View {
        Image("Dime")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 80, height: 80)
            .clipped()
//        Image("Speaker")
//            .frame(width: 24.79848, height: 24.79175)
//            .offset(x: 50)
    }
}

struct Nickel: View {
    var body: some View {
        Image("Nickel")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 125, height: 125)
            .clipped()
//        Image("Speaker")
//            .frame(width: 24.79848, height: 24.79175)
//            .offset(x: 50)
    }
}

struct Penny: View {
    var body: some View {
        Image("Penny")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 100, height: 100)
            .clipped()
//        Image("Speaker")
//            .frame(width: 24.79848, height: 24.79175)
//            .offset(x: 50)
    }
}

struct Quarter: View {
    var body: some View {
        Image("Quarter")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
//        Image("Speaker")
//            .frame(width: 24.79848, height: 24.79175)
//            .offset(x: 50)
    }
}

