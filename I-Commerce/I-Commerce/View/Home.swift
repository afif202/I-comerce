//
//  Home.swift
//  I-Commerce
//
//  Created by macbook on 01/03/21.
//

import SwiftUI

struct Home: View {
    @StateObject var HomeModel = HomeViewModel()
    var body: some View {
        ZStack{
            VStack(spacing: 10){
                HStack(spacing: 15){
                    Button(action: {
                        withAnimation(.easeIn){HomeModel.showMenu.toggle()}
                    },label:{
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(Color.blue)
                    })
                    
                    Text(HomeModel.userLocation == nil ? "Location..." : "Deliver To")
                        .background(Color.black)
                    
                    Text(HomeModel.userAddress)
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(.blue)
                    
                    Spacer(minLength: 0)
                    
                    //divider adalah garis pembatas bisa vertical dan horizontal sesuai stack nya(ZStack, HS dan VS)
                    
                    Divider()
                    
                    HStack(spacing: 15){
                        TextField("Search",text: $HomeModel.search)
                        
                        if HomeModel.search != "" {
                            Button(action: {}, label: {
                                Image(systemName: "magnifyingglass")
                                    .font(.title)
                                    .foregroundColor(.gray)
                            })
                            .animation(.easeIn)
                    }
                }
                    Divider()
                    Spacer()
                }
                
                HStack{
                                Menu(homeData: HomeModel)
                                    .offset(x: HomeModel.showMenu ? 0: -UIScreen.main.bounds.width / 1.6)
                                
                                Spacer(minLength: 0)
                            }
                            .background(Color.black.opacity(HomeModel.showMenu ? 0.3 : 0).ignoresSafeArea()
                                            .onTapGesture(perform: {
                                                withAnimation(.easeIn){HomeModel.showMenu.toggle()}
                                            
                                            })
                            )
                                            }
                        .onAppear(perform: {
                            HomeModel.locationManager.delegate = HomeModel
                        })
                           }
    }
}

