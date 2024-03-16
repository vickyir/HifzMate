//
//  Model.swift
//  FunQuranGame
//
//  Created by Vicky Irwanto on 16/03/24.
//
import Foundation

struct ModelSurah: Decodable
{
    let nomor: Int
    let nama: String
    let nama_latin: String
    let jumlah_ayat: Int
    let tempat_turun: String
    let arti: String
    let deskripsi: String
    let audio: String
}

struct Detail: Codable {
    let nomor: Int
    let nama_latin: String
    let arti: String
    let jumlah_ayat: Int
    let ayat: [ayat]
}

struct ayat: Codable{
    let id: Int
    let surah: Int
    let nomor: Int
    let ar: String
    let tr: String
    let idn: String
}
