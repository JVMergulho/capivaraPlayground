//
//  utilities.swift
//  capivara
//
//  Created by João Vitor Lima Mergulhão on 04/02/25.
//

import UIKit

func imageToURL(image: UIImage) -> URL? {
    // Salvar a imagem em um arquivo temporário
    guard let data = image.pngData() else { return nil }
    
    // Criar um caminho para o arquivo temporário
    let fileManager = FileManager.default
    let tempDirectory = fileManager.temporaryDirectory
    let fileURL = tempDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("png")
    
    do {
        // Escrever os dados da imagem no arquivo
        try data.write(to: fileURL)
        return fileURL
    } catch {
        print("Erro ao salvar imagem: \(error)")
        return nil
    }
}
