//
//  RealCategories.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 12.08.26.
//

func getRealCategories(year: Int) -> [CategoryInfo]? {
    if let categoryInfos = realCategoryInfos[year] {
        return categoryInfos
    } else {
        print("Unable to find categories for year \(year).")
        return nil
    }
}

private let realCategoryInfos: [Int : [CategoryInfo]] =
    [2 : [CategoryInfo(name: "Alex's Titles", colour: .yellow, clues: ["OCEAN COOKIE", "BABOUSHY", "BABY MAN", "STINKEPUH"]),
          CategoryInfo(name: "Who Caro Really Is", colour: .green, clues: ["MASHED POTATO", "LOUISE", "BOB", "FRANCESCA"]),
          CategoryInfo(name: "Key Lyrics Of Caro's Bops", colour: .blue, clues: ["NOSE", "HEAT", "COOK", "TEETH"]),
          CategoryInfo(name: "Potential Nicknames For Our Potential Children", colour: .purple, clues: ["JAN", "NOOK", "EGG", "BRINE"])]]
