//
//  ContentView.swift
//  Valorant
//
//  Created by danyaq on 01.09.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @StateObject var vm = ViewModel()
    @State var selectedMode = "quick"
    @State var searchText = ""
    @State var showError = false
    @State var adapt = UIScreen.main.bounds.height < 700
    var body: some View {
        ZStack{
           
            Color.init(#colorLiteral(red: 0.9803921569, green: 0.6117647059, blue: 0.1215686275, alpha: 1)).edgesIgnoringSafeArea(.all)
            Image("logo").renderingMode(.template).resizable().frame(width: 120, height: 120).foregroundColor(Color.white.opacity(0.6)).offset(x: 60, y: 40)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            VStack(spacing: 0){
                HStack(spacing: 20){
                    Image("logo")
                        .renderingMode(.template)
                        .resizable()
                        .foregroundColor(Color.orange)
                        .padding(6)
                        .frame(width: 46, height: 46)
                        .background(Color.white)
                        .cornerRadius(11)
                    HStack(spacing: 5){
                        ZStack{
                            if searchText.isEmpty{
                                Text("Search")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(Color.white.opacity(0.7))
                            }
                        TextField("", text: $searchText)
                            .foregroundColor(Color.white)
                        }
                        Button(action: {
                           let tag = searchText.replacingOccurrences(of: "#", with: "-")
                            vm.fetchData(battleTag: tag){ error in
                                if !error.isEmpty{
                                    showError = true
                                }
                            }
                        }, label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color.white.opacity(0.7))
                        })
                        .alert(isPresented: $showError) {
                            Alert(title: Text(vm.errorMsg))
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 12)
                    .background(Color.init(#colorLiteral(red: 0.997971952, green: 0.7377240062, blue: 0.3904860616, alpha: 1)))
                    .cornerRadius(8)
                }
                
                .padding(.horizontal)
                .padding(.vertical)
                if vm.model == nil{
                    Spacer()
                    ProgressView()
                    Spacer()
                } else {
                HStack(spacing: 20){
                    WebImage(url: URL(string: vm.model?.icon ?? ""))
                        .resizable()
                        .frame(width: adapt ?  100 : 150, height: adapt ?  100 : 150)
                        .cornerRadius(10)
                    VStack(alignment: .leading, spacing: 10){
                        Text(vm.model?.name ?? "")
                            .font(.custom("Druk Wide Bold", size: 26))
                        Text("\(vm.model?.level ?? 0) уровень")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.white)
                }
                .padding(.horizontal)
                .padding(.vertical)
                .background(Color.white.opacity(0.15))
                .cornerRadius(10)
                .padding()
                    if vm.model?.isPrivate == true{
                        Text("Закрытый профиль")
                            .font(.custom("Druk Wide Bold", size: 21))
                    } else {
                    VStack(alignment: .center, spacing: 16){
                        HStack{
                            Text(selectedMode == "quick" ? "Быстрая\nигра" : "Рейтинговая\nигра")
                            .lineLimit(2)
                            .font(.custom("Druk Wide Bold", size: 21))
                            .animation(.none)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color.black)
                                .frame(width: 40, height: 40)
                                .background(Color.white.opacity(0.7))
                                .cornerRadius(10)
                                .onTapGesture {
                                    withAnimation(.spring()){
                                    if selectedMode == "quick"{
                                        selectedMode = "competiteve"
                                    } else {
                                        selectedMode = "quick"
                                    }
                                    }
                                }
                        }
                        .padding(.horizontal)
                        if selectedMode == "competiteve"{
                            VStack(alignment: .leading, spacing: 10){
                                Text("Награды")
                                HStack(spacing: 0){
                                    Text("Всего медалей - ")
                                    Text("\(vm.model?.competitiveStats?.awards?.medals ?? 0)")
                                        .foregroundColor(Color.black)
                                }
                                HStack(spacing: 0){
                                    HStack(spacing: 0){
                                    Image("trophy")
                                        .renderingMode(.template)
                                        .resizable()
                                        .frame(width: 40, height: 35)
                                        .offset(x: 2)
                                        .background(Color.black.opacity(0.4))
                                        .cornerRadius(10)
                                        .foregroundColor(Color.init(#colorLiteral(red: 1, green: 0.8488938212, blue: 0.466383934, alpha: 1)))
                                        Text(" - ")
                                    }
                                    Text("\(vm.model?.competitiveStats?.awards?.medalsGold ?? 0)")
                                        .foregroundColor(Color.black)
                                }
                                HStack(spacing: 0){
                                    HStack(spacing: 0){
                                    Image("trophy")
                                        .renderingMode(.template)
                                        .resizable()
                                        .frame(width: 40, height: 35)
                                        .offset(x: 2)
                                        .background(Color.black.opacity(0.4))
                                        .cornerRadius(10)
                                        .foregroundColor(Color.init(#colorLiteral(red: 0.8686730266, green: 0.8781773448, blue: 0.9257163405, alpha: 1)))
                                        Text(" - ")
                                    }
                                    Text("\(vm.model?.competitiveStats?.awards?.medalsSilver ?? 0)")
                                        .foregroundColor(Color.black)
                                }
                                HStack(spacing: 0){
                                    HStack(spacing: 0){
                                    Image("trophy")
                                        .renderingMode(.template)
                                        .resizable()
                                        .frame(width: 40, height: 35)
                                        .offset(x: 2)
                                        .background(Color.black.opacity(0.4))
                                        .cornerRadius(10)
                                        .foregroundColor(Color.init(#colorLiteral(red: 0.763766706, green: 0.4787502885, blue: 0.3492028117, alpha: 1)))
                                        Text(" - ")
                                    }
                                    Text("\(vm.model?.competitiveStats?.awards?.medalsBronze ?? 0)")
                                        .foregroundColor(Color.black)
                                }
                                HStack(spacing: 0){
                                    Text("Всего карточек - ")
                                    Text("\(vm.model?.competitiveStats?.awards?.cards ?? 0)")
                                        .foregroundColor(Color.black)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color.white.opacity(0.15))
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .transition(.move(edge: .leading))
                        } else if selectedMode == "quick"{
                        VStack(alignment: .leading, spacing: 10){
                            Text("Награды")
                            HStack(spacing: 0){
                                Text("Всего медалей - ")
                                Text("\(vm.model?.quickPlayStats?.awards?.medals ?? 0)")
                                    .foregroundColor(Color.black)
                            }
                            HStack(spacing: 0){
                                HStack(spacing: 0){
                                Image("trophy")
                                    .renderingMode(.template)
                                    .resizable()
                                    .frame(width: 40, height: 35)
                                    .offset(x: 2)
                                    .background(Color.black.opacity(0.4))
                                    .cornerRadius(10)
                                    .foregroundColor(Color.init(#colorLiteral(red: 1, green: 0.8488938212, blue: 0.466383934, alpha: 1)))
                                    Text(" - ")
                                }
                                Text("\(vm.model?.quickPlayStats?.awards?.medalsGold ?? 0)")
                                    .foregroundColor(Color.black)
                            }
                            HStack(spacing: 0){
                                HStack(spacing: 0){
                                Image("trophy")
                                    .renderingMode(.template)
                                    .resizable()
                                    .frame(width: 40, height: 35)
                                    .offset(x: 2)
                                    .background(Color.black.opacity(0.4))
                                    .cornerRadius(10)
                                    .foregroundColor(Color.init(#colorLiteral(red: 0.8686730266, green: 0.8781773448, blue: 0.9257163405, alpha: 1)))
                                    Text(" - ")
                                }
                                Text("\(vm.model?.quickPlayStats?.awards?.medalsSilver ?? 0)")
                                    .foregroundColor(Color.black)
                            }
                            HStack(spacing: 0){
                                HStack(spacing: 0){
                                Image("trophy")
                                    .renderingMode(.template)
                                    .resizable()
                                    .frame(width: 40, height: 35)
                                    .offset(x: 2)
                                    .background(Color.black.opacity(0.4))
                                    .cornerRadius(10)
                                    .foregroundColor(Color.init(#colorLiteral(red: 0.763766706, green: 0.4787502885, blue: 0.3492028117, alpha: 1)))
                                    Text(" - ")
                                }
                                Text("\(vm.model?.quickPlayStats?.awards?.medalsBronze ?? 0)")
                                    .foregroundColor(Color.black)
                            }
                            HStack(spacing: 0){
                                Text("Всего карточек - ")
                                Text("\(vm.model?.quickPlayStats?.awards?.cards ?? 0)")
                                    .foregroundColor(Color.black)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.white.opacity(0.15))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .transition(.move(edge: .trailing))
                        }
                    }
                    
                }
                Spacer()
                Button(action: {
                    
                }, label: {
                    Text("Поделиться")
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .font(.custom("Druk Wide Bold", size: 21))
                        .foregroundColor(Color.black)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.21), radius: 16, x: 0.0, y: 0.0)
                })
                .padding(.bottom)
                .padding(.horizontal)
                }
            }
            .font(.custom("Druk Wide Bold", size: 18))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
