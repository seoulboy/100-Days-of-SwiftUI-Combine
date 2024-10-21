struct Town {
    var population = 5422
    var numberOfStoplights = 4

    func printTownDescription() {
        // note you have to print "self" here, not "myTown"
        print("Population: \(self.population), number of stoplights: \(self.numberOfStoplights)")
    }

    mutating func changePopulation(amount: Int) {
        population += amount
    }
}

var town = Town()
town.changePopulation(amount: 1000)
print(town.population)
