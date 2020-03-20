import CoreData
import Apollo

class Network {
    static let shared = Network()
    private(set) lazy var apollo = ApolloClient(url: URL(string: "https://stage.ektdevelopers.com/_graphql")!)
}
