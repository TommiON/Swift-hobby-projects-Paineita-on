//
//  Mittaukset.swift
//  Paineita on!
//
//  Created by Tommi Niittymies on 22.12.2018.
//  Copyright © 2018 Tommi Niittymies. All rights reserved.
//

import Foundation

struct Mittaukset: Codable {
    var mittausluettelo: [Mittaus]
    var mittauksiaYhteensä: Int {get{return mittausluettelo.count}}
    var keskimääräinenAlapaine: Int {
        get {
            if(mittauksiaYhteensä == 0) {return 0}
            var apu = 0
            for mittaus in mittausluettelo {
                apu += mittaus.alapaine
            }
            return apu / mittauksiaYhteensä
        }
    }
    var keskimääräinenYläpaine: Int {
        get {
            if(mittauksiaYhteensä == 0) {return 0}
            var apu = 0
            for mittaus in mittausluettelo {
                apu += mittaus.yläpaine
            }
            return apu / mittauksiaYhteensä
        }
    }
    
    init() {
        mittausluettelo = [Mittaus]()
        let tiedostomanageri = FileManager.default
        let polku = tiedostomanageri.homeDirectoryForCurrentUser.appendingPathComponent("Documents/paineet.json")
        let dekoodaaja = JSONDecoder()
        var tallennettuData = Data()
        if tiedostomanageri.fileExists(atPath: polku.path) {
            do {
                try tallennettuData = Data.init(contentsOf: polku)
            } catch {
                print("virhe tiedoston lukemisessa!")
            }
            do {
                mittausluettelo = try dekoodaaja.decode([Mittaus].self, from: tallennettuData)
            } catch {
                print("virhe json-dekoodauksessa!")
            }
        } else {
            tiedostomanageri.createFile(atPath: polku.path, contents: nil, attributes: nil)
        }
    }
    
    func tallenna() {
        let tiedostomanageri = FileManager.default
        let polku = tiedostomanageri.homeDirectoryForCurrentUser.appendingPathComponent("Documents/paineet.json")
        let koodaaja = JSONEncoder()
        var tallennettavaData = Data()
        do {
            tallennettavaData = try koodaaja.encode(mittausluettelo)
            print(tallennettavaData)
        } catch  {
            print("virhe json-koodauksessa!")
        }
        do {
            try tallennettavaData.write(to: polku)
        } catch  {
            print("virhe tiedostoon tallentamisessa!")
        }
    }
    
    mutating func lisääUusi(uusiMittaus: Mittaus) {
        mittausluettelo.append(uusiMittaus)
    }
    
    func mittausIndeksissä(indeksi: Int) -> Mittaus {
        return mittausluettelo[indeksi]
    }
}
