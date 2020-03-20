//
//  ContentView.swift
//  SwiftUI-GraphQL
//
//  Created by Heber on 19/03/20.
//  Copyright © 2020 Heber. All rights reserved.
//

import SwiftUI

extension String: Identifiable{
    public var id: String {self}
}

struct ContentView: View{
    @ObservedObject private var launchData: LaunchListData = LaunchListData()
    var body: some View{
        return List(launchData.names) {name in
            Text(name)
        }
    }
}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
        
    }
}

class LaunchListData: ObservableObject {
    @Published var names: [String]
    
    init(){
        print("running loadData")
        self.names = [String]()
        loadData()
    }
    
    func loadData() {
        Network.shared.apollo.fetch(query: getProductsQuery()) { result in
            switch result {
            case .success(let graphQLResult):
                for launch in graphQLResult.data!.viewer.viewer{
                    if launch != nil {
                        if launch!.name != nil {
                            self.names.append(launch!.name!)
                        }
                    }
                }
                
                print("Success! Result: \(String(describing:self.names))")
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }
}
