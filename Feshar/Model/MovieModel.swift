//
//  MovieModel.swift
//  Feshar
//
//  Created by Awady on 3/30/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import Foundation
import UIKit

struct HomeModel: Codable {
    let page: Int
    let results: [MovieModel]
}

struct MovieModel: Codable {
    var id: Int?
    var name: String?
    var mainPoster: String?
    var IMDBRate: Double?
    var Description: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "title"
        case mainPoster = "poster_path"
        case IMDBRate = "vote_average"
        case Description = "overview"
    }
}

































//class MovieModel: Codable {
//
//    var mainPoster: UIImage?
//    var name: String?
//    var genre: String?
//    var IMDBRate: Double?
//    var Description: String?
//    var posters: [UIImage]?
//    var isFavorite: Bool = false
//
//    init(mainPoster: UIImage, name: String, genre: String, IMDBRate: Double, Description: String, posters: [UIImage], isFavorite: Bool) {
//        self.mainPoster = mainPoster
//        self.name = name
//        self.genre = genre
//        self.IMDBRate = IMDBRate
//        self.Description = Description
//        self.posters = posters
//        self.isFavorite = isFavorite
//    }
//}




//.........MOVIES DATA

//var movieGenres = ["NEW", "TRENDING" ,"COMEDY", "ACTION", "ROMANCE"]
//
//var allMovies = [CaptainMarvel ,Bloodshot, IamLegend, Tolkien, TheFaultInOurStars, SongOne, DearJohn, AreWeThereYet, MeMyselfIrene, TheHangover]
//
//let IamLegend = MovieModel(mainPoster: UIImage(named: "IamLegend")!, name: "Iam Legend", genre: "Action | Science fiction - 2h 43m", IMDBRate: 9.5, Description: "I Am Legend is a 2007 American post-apocalyptic action thriller film[4] based on the 1954 novel of the same name by Richard Matheson. Directed by Francis Lawrence, the film stars Will Smith as US Army virologist Robert Neville.", posters: [UIImage(named: "IamLegend2")!, UIImage(named: "IamLegend3")!], isFavorite: false)
//
//let CaptainMarvel = MovieModel(mainPoster: UIImage(named: "CaptainMarvel")!, name: "Captain Marvel", genre: "Action | Science fiction - 2h 43m", IMDBRate: 7.8, Description: "Captain Marvel is a 2019 American superhero film based on the Marvel Comics character Carol Danvers. Produced by Marvel Studios and distributed by Walt Disney Studios Motion Pictures, it is the twenty-first film in the Marvel Cinematic Universe (MCU).", posters: [UIImage(named: "CaptainMarvel2")!, UIImage(named: "CaptainMarvel3")!], isFavorite: false)
//
//let Bloodshot = MovieModel(mainPoster: UIImage(named: "Bloodshot")!, name: "Bloodshot", genre: "Action | Science fiction - 2h 43m", IMDBRate: 8.5, Description: "Bloodshot is a 2020 American superhero film based on the Valiant Comics character of the same name. It is intended to be the first installment in a series of films set within a Valiant Comics shared cinematic universe.", posters: [UIImage(named: "Bloodshot2")!, UIImage(named: "Bloodshot3")!], isFavorite: false)
//
//let Tolkien = MovieModel(mainPoster: UIImage(named: "Tolkien")!, name: "Tolkien", genre: "Action | Science fiction - 2h 43m", IMDBRate: 6.3, Description: "John Ronald Reuel Tolkien CBE FRSL (/ruːl ˈtɒlkiːn/;[a] 3 January 1892 – 2 September 1973) was an English writer, poet, philologist, and academic. He was the author of the classic high fantasy works The Hobbit and The Lord of the Rings.", posters: [UIImage(named: "Tolkien2")!, UIImage(named: "Tolkien3")!], isFavorite: false)
//
//
//let TheFaultInOurStars = MovieModel(mainPoster: UIImage(named: "TheFaultInOurStars")!, name: "The Foult In Our Stars", genre: "Romance | Science fiction - 2h 43m", IMDBRate: 8.5, Description: "The Fault in Our Stars is a 2014 American romantic drama film directed by Josh Boone. The film stars Shailene Woodley and Ansel Elgort.", posters: [UIImage(named: "TheFaultInOurStars2")!, UIImage(named: "TheFaultInOurStars3")!], isFavorite: false)
//
//let SongOne = MovieModel(mainPoster: UIImage(named: "SongOne")!, name: "Song One", genre: "Romance | Science fiction - 2h 43m", IMDBRate: 7.7, Description: "Song One is a 2014 American drama film written and directed by Kate Barker-Froyland at her directorial debut. The film follows Franny Ellis (Anne Hathaway), an anthropology student who returns to New York City after her estranged brother, Henry (Ben Rosenfield), a musician, enters a coma; to revive Henry and repair their relationship, Franny uses her anthropologist instincts.", posters: [UIImage(named: "SongOne2")!], isFavorite: false)
//
//let DearJohn = MovieModel(mainPoster: UIImage(named: "DearJohn")!, name: "Dear John", genre: "Romance | Science fiction - 2h 43m", IMDBRate: 7.2, Description: "Dear John is a 2010 American romantic drama-war film starring Amanda Seyfried and Channing Tatum. It was made by Screen Gems and was released theatrically in North America on February 5, 2010.", posters: [UIImage(named: "DearJohn2")!], isFavorite: false)
//
//
//let AreWeThereYet = MovieModel(mainPoster: UIImage(named: "AreWeThereYet")!, name: "Are We There Yet", genre: "Comedy | Science fiction - 2h 43m", IMDBRate: 8.0, Description: "Are We There Yet? is a 2005 American family comedy film directed by Brian Levant. It was written by Steven Gary Banks, Claudia Grazioso, J. David Stem, and David N. Weiss based on a story by Banks and Grazioso. Ice Cube stars alongside an ensemble cast featuring Nia Long, Aleisha Allen, Philip Daniel Bolden, Jay Mohr, and Tracy Morgan.", posters: [UIImage(named: "AreWeThereYet2")!, UIImage(named: "AreWeThereYet3")!], isFavorite: false)
//
//let MeMyselfIrene = MovieModel(mainPoster: UIImage(named: "MeMyselfIrene")!, name: "Me,Myself&Irene", genre: "Comedy | Science fiction - 2h 43m", IMDBRate: 7.9, Description: "Me, Myself & Irene is a 2000 American black comedy film[2] directed by the Farrelly brothers, and starring Jim Carrey and Renée Zellweger. Chris Cooper, Robert Forster, Richard Jenkins, Daniel Greene, Anthony Anderson, Jerod Mixon and Mongo Brownlee co-star.", posters: [UIImage(named: "MeMyselfIrene2")!], isFavorite: false)
//
//let TheHangover = MovieModel(mainPoster: UIImage(named: "TheHangover")!, name: "The Hangover", genre: "Comedy | Science fiction - 2h 43m", IMDBRate: 7.8, Description: "The Hangover is a 2009 American comedy film directed by Todd Phillips, co-produced with Daniel Goldberg, and written by Jon Lucas and Scott Moore. It is the first installment in The Hangover trilogy.", posters: [UIImage(named: "TheHangover2")!, UIImage(named: "TheHangover3")!], isFavorite: false)




    
