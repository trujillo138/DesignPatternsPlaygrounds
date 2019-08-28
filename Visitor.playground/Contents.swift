import UIKit

protocol Vehicle {
    var numberOfDoors: Int { get }
    var maxSpeed: Int { get }
    func accept<V: VehicleVisitor>(visitor: V) -> V.CommonOutcome
}

struct Car: Vehicle {
    var numberOfDoors: Int = 4
    var maxSpeed: Int = 50
    var brand: String
    
    func accept<V>(visitor: V) -> V.CommonOutcome where V : VehicleVisitor {
        return visitor.visit(car: self)
    }
}

struct Truck: Vehicle {
    var numberOfDoors: Int = 2
    var maxSpeed: Int = 30
    var tonsOfCapacity: Int = 3
    
    func accept<V>(visitor: V) -> V.CommonOutcome where V : VehicleVisitor {
        return visitor.visit(truck: self)
    }
}

struct Trailer: Vehicle {
    var numberOfDoors: Int = 1
    var maxSpeed: Int = 40
    var numberOfBeds: Int
    
    func accept<V>(visitor: V) -> V.CommonOutcome where V : VehicleVisitor {
        return visitor.visit(trailer: self)
    }
}

class ParkingLot {
    func buildLot(vehicles: [Vehicle]) {
        vehicles.forEach { $0.accept(visitor: self) }
    }
}

protocol VehicleVisitor {
    associatedtype CommonOutcome
    func visit(car: Car) -> CommonOutcome
    func visit(truck: Truck) -> CommonOutcome
    func visit(trailer: Trailer) -> CommonOutcome
}

extension ParkingLot: VehicleVisitor {
    func visit(car: Car) {
        print("Placed a \(car.brand) car with \(car.numberOfDoors) doors, a speed of \(car.maxSpeed) km/h")
    }
    
    func visit(truck: Truck) {
        print("Placed a \(truck.tonsOfCapacity)-ton truck with \(truck.numberOfDoors) doors, a speed of \(truck.maxSpeed) km/h")
    }
    
    func visit(trailer: Trailer) {
        print("Placed a trailer with \(trailer.numberOfDoors) door(s), a speed of \(trailer.maxSpeed) km/h. It has space for \(trailer.numberOfBeds) beds")
    }
}

let lot = ParkingLot()
let vechicles: [Vehicle] = [Car(numberOfDoors: 5, maxSpeed: 40, brand: "Audi"),
                            Truck(numberOfDoors: 2, maxSpeed: 30, tonsOfCapacity: 3),
                            Truck(numberOfDoors: 2, maxSpeed: 30, tonsOfCapacity: 5),
                            Trailer(numberOfDoors: 1, maxSpeed: 20, numberOfBeds: 1),
                            Car(numberOfDoors: 5, maxSpeed: 60, brand: "Porsche"),
                            Trailer(numberOfDoors: 1, maxSpeed: 35, numberOfBeds: 3)]
lot.buildLot(vehicles: vechicles)
