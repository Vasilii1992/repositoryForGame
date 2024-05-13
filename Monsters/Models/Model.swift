
import Foundation
import MapKit



struct Monster: Equatable,Encodable,Decodable {
    let name: String
    let subtitle: String
    let imageName: String
    var latitude: Double
    var longitude: Double
    let backgraund: String
}

class MonsterAnnotation: MKPointAnnotation {
    let monster: Monster

    init(monster: Monster) {
        self.monster = monster
        super.init()
        self.title = monster.name
        self.subtitle = monster.subtitle
        self.coordinate = CLLocationCoordinate2D(latitude: monster.latitude, longitude: monster.longitude)
    }
}


var monsters = [
    Monster(name: Resources.MonsterName.godzilla, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.godzilla, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.godzilla),
    Monster(name: Resources.MonsterName.ghost, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.ghost, latitude: 59.93358487887655, longitude: 30.35071790935886, backgraund: Resources.MonsterBackgraund.ghost),
    Monster(name: Resources.MonsterName.slept, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.slept, latitude: 59.931509638232065, longitude: 30.358925674068285, backgraund: Resources.MonsterBackgraund.slept),
    Monster(name: Resources.MonsterName.serp, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.serp, latitude: 59.93967302105203, longitude: 30.340245368497094, backgraund: Resources.MonsterBackgraund.serp),
    Monster(name: Resources.MonsterName.morder, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.morder, latitude: 59.935527508674184, longitude: 30.36491185671947, backgraund: Resources.MonsterBackgraund.morder),
    Monster(name: Resources.MonsterName.drakosha, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.drakosha, latitude: 59.89157811298915, longitude: 30.424140876531627, backgraund: Resources.MonsterBackgraund.drakosha),
    Monster(name: Resources.MonsterName.sad, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.sad, latitude: 59.9358777789229, longitude: 30.3219035565975, backgraund: Resources.MonsterBackgraund.sad),
    Monster(name: Resources.MonsterName.toots, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.toots, latitude: 59.23487, longitude: 30.32190, backgraund: Resources.MonsterBackgraund.toots),
    Monster(name: Resources.MonsterName.glazastic, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.glazastic, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.glazastic),
    Monster(name: Resources.MonsterName.goblin, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.goblin, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.goblin),
    Monster(name: Resources.MonsterName.bigguy, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.bigguy, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.bigguy),
    Monster(name: Resources.MonsterName.sparrow, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.sparrow, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.sparrow),
    Monster(name: Resources.MonsterName.jack, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.jack, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.jack),
    Monster(name: Resources.MonsterName.soulrender, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.soulrender, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.soulrender),
    Monster(name: Resources.MonsterName.hexmire, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.hexmire, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.hexmire),
    Monster(name: Resources.MonsterName.doomshriek, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.doomshriek, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.doomshriek),
    Monster(name: Resources.MonsterName.frostclaw, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.frostclaw, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.frostclaw),
    Monster(name: Resources.MonsterName.embermaw, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.embermaw, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.embermaw),
    Monster(name: Resources.MonsterName.venomtide, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.venomtide, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.venomtide),
    Monster(name: Resources.MonsterName.vortexlash, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.vortexlash, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.vortexlash),
    Monster(name: Resources.MonsterName.craggnar, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.craggnar, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.craggnar),
    Monster(name: Resources.MonsterName.shadowspire, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.shadowspire, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.shadowspire),
    Monster(name: Resources.MonsterName.gloomfang, subtitle: Resources.MonsterSubtitle.levelForEachMonster, imageName: Resources.ImagesString.gloomfang, latitude: 59.937079, longitude: 30.352196, backgraund: Resources.MonsterBackgraund.gloomfang),


]



// создание сердец рядом с монстром
//    private func addHearts(to annotationView: MKAnnotationView, count: Int) {
//
//            let animationWidth: CGFloat = 30
//            let animationHeight: CGFloat = 30
//            let animationView = LottieAnimationView(name: "heartPoint")
//            animationView.frame = CGRect(x: -animationWidth/2, y: -animationHeight/2, width: animationWidth, height: animationHeight)
//            annotationView.addSubview(animationView)
//            annotationView.frame = annotationView.frame.offsetBy(dx: 0, dy: -animationHeight/2)
//            var delay: Double = 0
//            for _ in 0..<count {
//                animationView.play(fromProgress: 0, toProgress: 1, loopMode: .loop, completion: nil)
//                animationView.play()
//                animationView.alpha = 0
//                UIView.animate(withDuration: 0.5, delay: delay, options: [.curveEaseInOut], animations: {
//                    animationView.alpha = 1
//                }, completion: nil)
//                delay += 0.25
//            }
//        }
//
