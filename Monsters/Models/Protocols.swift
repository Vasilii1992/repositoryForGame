

import Foundation
import Lottie


protocol MonsterCaptureDelegate: AnyObject {
    func didCaptureMonster(_ monster: Monster)
    func didEscapeMonster(_ monster: Monster)
    func updateHeart()
}


