//
//  MapViewProtocol.swift
//  Monsters
//
//  Created by Василий Тихонов on 09.06.2024.
//

import Foundation
import MapKit
import Lottie

protocol MonsterCaptureDelegate: AnyObject {
    func didCaptureMonster(_ monster: Monster)
    func didEscapeMonster(_ monster: Monster)
    func updateHeart()
}

