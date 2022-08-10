//
//  main.swift
//  EmbraceSwiftGenerics
//
//  Created by Conrad Taylor on 8/3/22.
//  Copyright © 2022 Conrad Taylor. All rights reserved.
//

//
// Embrace Swift Generics
//
// Session:
//   https://developer.apple.com/videos/play/wwdc2022/110352
//
// Forum: https://developer.apple.com/forums/tags/wwdc2022-110352
//

//
// Embrace Swift Generics
//
// Session:
//   https://developer.apple.com/videos/play/wwdc2022/110352
//
// Forum: https://developer.apple.com/forums/tags/wwdc2022-110352
//

import Foundation

protocol AnimalFeed {
  associatedtype CropType: Crop
    where CropType.FeedType == Self
  static func grow() -> CropType
}

protocol Crop {
  associatedtype FeedType: AnimalFeed
    where FeedType.CropType == Self
  func harvest() -> FeedType
}

protocol Animal {
  associatedtype Feed: AnimalFeed
  func eat(_ food: Feed)
}

// Cow

struct Cow: Animal {
  func eat(_ food: Hay) {
    // Eat the hay
    print("Cow eats hay.")
  }
}

struct Hay: AnimalFeed {
  static func grow() -> Alfalfa {
    return Alfalfa()
  }
}

struct Alfalfa: Crop {
  func harvest() -> Hay {
    return Hay()
  }
}

// Horse

struct Horse: Animal {
  func eat(_ food: Carrot) {
    // Munch on the carrot
    print("Horse eats carrot.")
  }
}

struct Carrot: AnimalFeed {
  static func grow() -> Root {
    return Root()
  }
}

struct Root: Crop {
  func harvest() -> Carrot {
    return Carrot()
  }
}

// Chicken

struct Chicken: Animal {
  func eat(_ food: Scratch) {
    // Peck at the scratch
    print("Chicken eats scratch.")
  }
}

struct Scratch: AnimalFeed {
  static func grow() -> Millet {
    return Millet()
  }
}

struct Millet: Crop {
  func harvest() -> Scratch {
    return Scratch()
  }
}

struct Farm {
  // func feed<A: Animal>(_ animal: A) where A: Animal {
  private func feed(_ animal: some Animal) {
    let crop = type(of: animal).Feed.grow()
    let feed = crop.harvest()
    animal.eat(feed)
  }
  
  func feedAll(_ animals: [any Animal]) {
    for animal in animals {
      feed(animal)
    }
  }
}

// Cow

let cow: Cow = Cow()
//let alfalfa = Hay.grow()
//let hay = alfalfa.harvest()
//cow.eat(hay)

// Horse

let horse: Horse = Horse()
//let root = Carrot.grow()
//let carrot = root.harvest()
//horse.eat(carrot)

// Chicken

let chicken: Chicken = Chicken()
//let millet = Scratch.grow()
//let scratch = millet.harvest()
//chicken.eat(scratch)

let animals: [any Animal] = [cow, horse, chicken]
let farm = Farm()

farm.feedAll(animals)
