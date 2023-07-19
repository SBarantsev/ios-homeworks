//
//  Language.swift
//  Navigation
//
//  Created by Sergey on 30.05.2023.
//

import Foundation

struct Post {
    let author: String
    let description: String
    let image: String
    let likes: Int
    let views: Int
}

extension Post {
    static func make() -> [Post] {
        [
            Post(author: "AMC.com",
                 description: "Спин-офф \"Ходячих мервецов\" выйдет 18 июня 2023 года. На стриминговой платформе АМС выйдет спин-офф сериала под названием \"Ходячие мертвецы: Мертвый город\". Рассказ о миссии Нигана и Мэгги.",
                 image: "NewsTWD",
                 likes: 253,
                 views: 645),
            Post(author: "MyDrivers.com",
                 description: "Apple будет судиться с Huawei за торговую марку. Американская компания Apple может столкнуться с юридическими трудностями в Китае после выхода гарнитуры Vision Pro на глобальном рынке.",
                 image: "NewsVisionPro",
                 likes: 245,
                 views: 876),
            Post(author: "Championat.com",
                 description: "Хачанову одобрили визу, и он едет на Уимблдон. Серебряный призер Олимпиады-2010, 10-я ракетка мира россиянин Карен Хачанов прошел дальше всех соотечественников по турнирной сетке \"Ролан Гаросс\" - 2023.",
                 image: "NewsKhachanov",
                 likes: 345,
                 views: 984),
            Post(author: "cybersport.ru",
                 description: "Cтудия Mundfish представила книгу об истории мира Atomic Heart. Выпуском занимается издательство АСТ. Книга посвящена предыстории Atomic Heart и рассказывает об альтернативной истории Советского Союза.",
                 image: "NewsAtomicHeart",
                 likes: 98,
                 views: 345)
        ]
    }
}

