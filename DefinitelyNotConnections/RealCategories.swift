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
        [1 : [CategoryInfo(name: "Reasons Alex Loves Caro (Amongst Others)", colour: .yellow, clues: ["Smart", "Thoughtful", "Funny", "Crazy"]),
              CategoryInfo(name: "Caro's Titles", colour: .green, clues: ["Stupido", "Queen Of Alex's Heart", "Ruler Of Alex's Life", "Duchess Dumpling"]),
              CategoryInfo(name: "Things Alex Is", colour: .blue, clues: ["Smort", "Smudge", "Wrong", "Banana Boy"]),
              CategoryInfo(name: "Things That Live At The Top Of Caro's Brain", colour: .purple, clues: ["Banana", "Eggdoor", "Oops", "Bubbles"])],
        2 : [CategoryInfo(name: "Alex's Titles", colour: .yellow, clues: ["OCEAN COOKIE", "BABOUSHY", "BABY MAN", "STINKEPUH"]),
          CategoryInfo(name: "Who Caro Really Is", colour: .green, clues: ["MASHED POTATO", "LOUISE", "BOB", "FRANCESCA"]),
          CategoryInfo(name: "Key Lyrics Of Caro's Bops", colour: .blue, clues: ["NOSE", "HEAT", "COOK", "TEETH"]),
          CategoryInfo(name: "Potential Nicknames For Our Potential Children", colour: .purple, clues: ["JAN", "NOOK", "EGG", "BRINE"])]
        ]
