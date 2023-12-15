import SwiftUI

struct OneDollar: View 
{
    var body: some View
    {
        Image("OneDollar")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 450, height: 150)
            .clipped()
    }
}

struct FiveDollar: View 
{
    var body: some View 
    {
        Image("FiveDollar")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 450, height: 175)
            .clipped()
    }
}

struct TenDollar: View 
{
    var body: some View 
    {
        Image("TenDollar")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 450, height: 150)
            .clipped()
    }
}

struct TwentyDollar: View 
{
    var body: some View 
    {
        Image("TwentyDollar")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 450, height: 175)
            .clipped()
    }
}
