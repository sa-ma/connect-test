import Foundation
import GandalfConnect

@main
struct Example {
    static func main() async {
        await testConnect()
    }
}

func testConnect() async {
    let services: InputData = [
        "uber": .service(Service(traits: ["rating"], activities: ["trip"],  required: false)),
        "netflix": .service(Service(activities: ["watch"])),
    ]
    let input = ConnectInput(
        publicKey: "0x02073d3b9daf439c19a267dcfc19bc1ac1aea5066d8c754554b046476099b6fa22",
        redirectURL: "https://gandalf.network",
        services: services
    )
    
    let connect = Connect(input: input)
    
    do {
        let generatedURL = try await connect.generateURL()
        print("Generated URL: \(generatedURL)")
        let dataKey = try Connect.getDataKeyFromURL(redirectURL: "https://example.com?dataKey=testDataKey")
        print("Data Key: \(dataKey)")
    } catch let error as GandalfError {
        print("GandalfError: \(error.message) with code: \(error.code.rawValue)")
    } catch {
        print("Unexpected error: \(error)")
    }
}
